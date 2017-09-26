require "base64"
require "minitest/autorun"

require_relative "../../Sources/Carte/carte"

include Xcodeproj::Project::Object

class Test < Minitest::Test
  def setup
    @original_directory = Dir.pwd
    @fixture_directory = "#{Dir.pwd}/Tests/CarteTests/Fixtures"
    cleanup_fixtures()
    prepare_fixture("CarteFixtureApp")
  end

  def teardown
    Dir.chdir @original_directory
    cleanup_fixtures()
  end

  def prepare_fixture(name)
    `unzip -qq -o \
      #{@fixture_directory}/#{name}.zip \
      -d #{@fixture_directory} -x "__MACOSX/*"`
  end

  def cleanup_fixtures
    return if @fixture_directory.nil?
    return unless @fixture_directory.include? "Carte"
    `find #{@fixture_directory}/* -type d -maxdepth 0 | xargs rm -r`
  end

  def fixture_dir(fixture_name, *paths)
    return ([@fixture_directory, fixture_name] + paths).join("/")
  end

  def fixture_project(fixture_name)
    path = fixture_dir(fixture_name, "#{fixture_name}.xcodeproj")
    return Xcodeproj::Project.open(path)
  end

  def plistbuddy(info, command)
    return`/usr/libexec/PlistBuddy -c "#{command}" "#{info}" 2>&1`.strip
  end

  def plistbuddy_b64(info, command)
    return Base64.strict_decode64(plistbuddy(info, command))
  end

  def prepare_fixture_project_cocoapods_environment(fixture_name)
    # copy `LICENSE`, `Sources/` to `Pods/Carte/`
    pod_dir = fixture_dir(fixture_name, "Pods/Carte")
    begin
      FileUtils.mkdir pod_dir
      FileUtils.cp "#{@original_directory}/LICENSE", pod_dir
      FileUtils.cp_r "#{@original_directory}/Sources", pod_dir
    rescue
    end

    # run pod install
    Dir.chdir fixture_dir(fixture_name) do
      assert system("pod install >/dev/null")
    end
  end

  def test_integrator_integrate
    project = fixture_project("CarteFixtureApp")
    integrator = ProjectIntegrator.new(project)
    integrator.integrate()
    target = project.targets.find { |t| t.name == "CarteFixtureApp" }
    assert_equal target.build_phases[2].name, "[Carte] Pre Script"
    assert_equal target.build_phases[2].shell_script, \
      "$SHELL -c \"ruby ${PODS_ROOT}/Carte/Sources/Carte/carte.rb pre\""
    assert_equal target.build_phases[2].uuid, \
      ProjectIntegrator.uuid_with_name(target.build_phases[2].name)
    assert target.build_phases[3].kind_of? PBXResourcesBuildPhase
    assert_equal target.build_phases[4].name, "[Carte] Post Script"
    assert_equal target.build_phases[4].uuid, \
      ProjectIntegrator.uuid_with_name(target.build_phases[4].name)
    assert_equal target.build_phases[4].shell_script, \
      "$SHELL -c \"ruby ${PODS_ROOT}/Carte/Sources/Carte/carte.rb post\""
  end

  def test_generator_generate
    srcroot = fixture_dir("CarteFixtureApp")
    info = fixture_dir("CarteFixtureApp", "CarteFixtureApp/Info.plist")
    generator = InfoPlistGenerator.new(srcroot, info)
    generator.generate()
    assert_equal plistbuddy(info, "Print Carte:0:name"), "Alamofire"
    assert plistbuddy_b64(info, "Print Carte:0:text").include?("alamofire.org")
    assert_equal plistbuddy(info, "Print Carte:1:name"), "Moya"
    assert plistbuddy_b64(info, "Print Carte:1:text").include?("Artsy")
    assert_equal plistbuddy(info, "Print Carte:2:name"), "RxSwift"
    assert plistbuddy_b64(info, "Print Carte:2:text").include?("Krunoslav")
    assert_equal plistbuddy(info, "Print Carte:3:name"), "Then"
    assert plistbuddy_b64(info, "Print Carte:3:text").include?("Suyeol")
  end

  def test_generator_cleanup
    srcroot = fixture_dir("CarteFixtureApp")
    info = fixture_dir("CarteFixtureApp", "CarteFixtureApp/Info.plist")
    generator = InfoPlistGenerator.new(srcroot, info)
    generator.generate()
    generator = InfoPlistGenerator.new(srcroot, info)
    generator.cleanup()
    assert plistbuddy(info, "Print Carte").include?("Does Not Exist")
  end

  def test_cocoapods
    prepare_fixture_project_cocoapods_environment("CarteFixtureApp")

    # test integration
    project = fixture_project("CarteFixtureApp")
    target = project.targets.find { |t| t.name == "CarteFixtureApp" }
    pre_script_phase_index = target.build_phases.find_index { |p|
      p.kind_of? PBXShellScriptBuildPhase and p.name == "[Carte] Pre Script"
    }
    resources_phase_index = target.build_phases.find_index { |p|
      p.kind_of? PBXResourcesBuildPhase
    }
    post_script_phase_index = target.build_phases.find_index { |p|
      p.kind_of? PBXShellScriptBuildPhase and p.name == "[Carte] Post Script"
    }
    refute_nil pre_script_phase_index
    refute_nil resources_phase_index
    refute_nil post_script_phase_index
    assert_equal pre_script_phase_index, resources_phase_index - 1
    assert_equal post_script_phase_index, resources_phase_index + 1
    assert_equal \
      target.build_phases[pre_script_phase_index].shell_script,
      "$SHELL -c \"ruby ${PODS_ROOT}/Carte/Sources/Carte/carte.rb pre\""
    assert_equal \
      target.build_phases[post_script_phase_index].shell_script,
      "$SHELL -c \"ruby ${PODS_ROOT}/Carte/Sources/Carte/carte.rb post\""

    # remove post script to prevent from cleanup Info.plist
    target.build_phases.delete_at(post_script_phase_index)
    project.save

    # run xcodebuild to check integration
    Dir.chdir fixture_dir("CarteFixtureApp")
    assert system("xcodebuild build " \
                  "-workspace CarteFixtureApp.xcworkspace " \
                  "-scheme CarteFixtureApp " \
                  "CODE_SIGN_IDENTITY=\"\" " \
                  "CODE_SIGNING_REQUIRED=NO >/dev/null")

    info = fixture_dir("CarteFixtureApp", "CarteFixtureApp/Info.plist")
    assert_equal plistbuddy(info, "Print Carte:0:name"), "Alamofire"
    assert plistbuddy_b64(info, "Print Carte:0:text").include?("alamofire.org")
    assert_equal plistbuddy(info, "Print Carte:1:name"), "Carte"
    assert plistbuddy_b64(info, "Print Carte:1:text").include?("Suyeol")
    assert_equal plistbuddy(info, "Print Carte:2:name"), "Moya"
    assert plistbuddy_b64(info, "Print Carte:2:text").include?("Artsy")
    assert_equal plistbuddy(info, "Print Carte:3:name"), "RxSwift"
    assert plistbuddy_b64(info, "Print Carte:3:text").include?("Krunoslav")
    assert_equal plistbuddy(info, "Print Carte:4:name"), "Then"
    assert plistbuddy_b64(info, "Print Carte:4:text").include?("Suyeol")
  end

  def test_cocoapods_integrate_twice
    prepare_fixture_project_cocoapods_environment("CarteFixtureApp")
    prepare_fixture_project_cocoapods_environment("CarteFixtureApp")
    project = fixture_project("CarteFixtureApp")
    target = project.targets.find { |t| t.name == "CarteFixtureApp" }
    pre_script_phases = target.build_phases.select { |p|
      p.kind_of? PBXShellScriptBuildPhase and p.name == "[Carte] Pre Script"
    }
    post_script_phases = target.build_phases.select { |p|
      p.kind_of? PBXShellScriptBuildPhase and p.name == "[Carte] Post Script"
    }
    assert_equal pre_script_phases.length, 1
    assert_equal post_script_phases.length, 1
  end
end
