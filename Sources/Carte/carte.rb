# encoding: utf-8

require_relative "./bundler/setup"
require "base64"
require "xcodeproj"

include Xcodeproj::Project::Object

class ProjectIntegrator
  attr_accessor :project

  def initialize(project)
    self.project = project
  end

  def integrate
    self.project.targets.each do |target|
      next unless target.kind_of?(PBXNativeTarget)
      remove_existing_scripts(target)
      next if target.test_target_type?
      resources_phase_index = target.build_phases.find_index { |p|
        p.kind_of?(PBXResourcesBuildPhase)
      } or next
      pre_script_phase = new_script_phase(
        "[Carte] Pre Script",
        "ruby ${PODS_ROOT}/Carte/Sources/Carte/carte.rb pre"
      )
      post_script_phase = new_script_phase(
        "[Carte] Post Script",
        "ruby ${PODS_ROOT}/Carte/Sources/Carte/carte.rb post",
      )
      target.build_phases.insert(resources_phase_index + 1, post_script_phase)
      target.build_phases.insert(resources_phase_index, pre_script_phase)
    end
    self.project.save
  end

  def remove_existing_scripts(target)
    target.build_phases
      .select { |p|
        p.kind_of? PBXShellScriptBuildPhase and \
          not p.name.nil? and \
          p.name.include?("Carte")
      }
      .each { |p|
        index = target.build_phases.index(p)
        target.build_phases.delete_at(index)
      }
  end

  def new_script_phase(name, shell_script)
    uuid = self.class.uuid_with_name(name)
    phase = PBXShellScriptBuildPhase.new(project, uuid)
    phase.initialize_defaults
    phase.name = name
    phase.shell_script = shell_script
    phase.show_env_vars_in_log = '0'
    return phase
  end

  def self.uuid_with_name(name)
      Digest::MD5.hexdigest(name).upcase[0,24]
  end
end

class InfoPlistGenerator
  attr_accessor :srcroot
  attr_accessor :infoplist_file

  # @return [Hash{Sting => String}] license text by library name
  #
  attr_accessor :items

  def initialize(srcroot, infoplist_file)
    self.srcroot = srcroot
    self.infoplist_file = infoplist_file
    self.items = {}
  end

  def generate
    self.plistbuddy("Delete :Carte")
    self.plistbuddy("Add :Carte array")
    self.add_items_from_cocoapods
    self.items.sort.each_with_index do |(name, text), index|
      plistbuddy "Add :Carte:#{index}:name string #{name}"
      plistbuddy "Add :Carte:#{index}:text string #{text}"
    end
  end

  def cleanup
    self.plistbuddy("Delete :Carte")
  end

  def plistbuddy(command)
    `/usr/libexec/PlistBuddy -c "#{command}" "#{self.infoplist_file}" \
     2>/dev/null || true`
  end

  def add_items_from_cocoapods
    license_files_from("#{srcroot}/Pods").each do |filename|
      begin
        name = filename.split("/Pods/")[1].split("/")[0]
        self.items[name] = Base64.strict_encode64(File.read(filename))
      rescue
      end
    end
    return items
  end

  def license_files_from(path)
    return `find "#{path}" -iname "LICENSE*" -maxdepth 2 2>/dev/null`
      .split("\n")
  end
end

def find_xcodeproj(path)
  candidates = `ls "#{path}" | grep .xcodeproj`.strip.split("/")
  return [path, candidates.first].join("/")
end

def run(command)
  case command
  when "configure"
    # prepare_command's working directory is Pods/
    root_path = File.expand_path("../../../../../", __FILE__)
    project_path = find_xcodeproj(root_path)
    project = Xcodeproj::Project.open(project_path)
    integrator = ProjectIntegrator.new(project)
    integrator.integrate()

  when "pre"
    generator = InfoPlistGenerator.new(ENV["SRCROOT"], ENV["INFOPLIST_FILE"])
    generator.generate()

  when "post"
    generator = InfoPlistGenerator.new(ENV["SRCROOT"], ENV["INFOPLIST_FILE"])
    generator.cleanup()

  else
    help
  end
end

def help
  puts "Usage: ruby carte.rb configure PROJECT_ROOT_PATH\n" \
       "       ruby carte.rb pre\n" \
       "       ruby carte.rb post"
  exit 1
end

if __FILE__ == $0
  run(ARGV[0])
end
