# encoding: utf-8

require 'base64'


def help
  puts "Usage: ruby carte.rb {pre|post}"
  exit 1
end


class Generator

  # @return [Hash{Sting => String}] license text by library name
  #
  attr_accessor :cartes

  def initialize
    self.cartes = {}
  end

  def generate
    self.cocoapods
  end

  def cocoapods
    files = []
    filenames = `find .. -name "LICENSE*"`.split("\n")
    filenames.each do |filename|
      begin
        name = filename.split("/Pods/")[1].split("/")[0]
        self.cartes[name] = Base64.strict_encode64(File.read(filename))
      rescue
      end
    end
  end

  # TODO: cocoaseeds, carthage, manually added libraries...

end


def delete
  `/usr/libexec/PlistBuddy -c "Delete :Carte" $SRCROOT/$INFOPLIST_FILE || true`
end


case ARGV[0]
when "pre"
  delete
  `/usr/libexec/PlistBuddy\
    -c "Add :Carte array"\
    $SRCROOT/$INFOPLIST_FILE || true`

  generator = Generator.new
  generator.generate
  generator.cartes.sort.each_with_index do |(name, text), index|
    `/usr/libexec/PlistBuddy\
      -c "Add :Carte:#{index}:name string #{name}"\
      $SRCROOT/$INFOPLIST_FILE || true`
    `/usr/libexec/PlistBuddy\
      -c "Add :Carte:#{index}:text string #{text}"\
      $SRCROOT/$INFOPLIST_FILE || true`
  end

when "post"
  delete

else
  help
end
