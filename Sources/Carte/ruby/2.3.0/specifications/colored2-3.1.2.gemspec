# -*- encoding: utf-8 -*-
# stub: colored2 3.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "colored2"
  s.version = "3.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Wanstrath", "Konstantin Gredeskoul"]
  s.date = "2017-02-14"
  s.description = "This is a heavily modified fork of http://github.com/defunkt/colored gem, with many\nsensible pull requests combined. Since the authors of the original gem no longer support it,\nthis might, perhaps, be considered a good alternative.\n\nSimple gem that adds various color methods to String class, and can be used as follows:\n\n  require 'colored2'\n\n  puts 'this is red'.red\n  puts 'this is red with a yellow background'.red.on.yellow\n  puts 'this is red with and italic'.red.italic\n  puts 'this is green bold'.green.bold << ' and regular'.green\n  puts 'this is really bold blue on white but reversed'.bold.blue.on.white.reversed\n  puts 'this is regular, but '.red! << 'this is red '.yellow! << ' and yellow.'.no_color!\n  puts ('this is regular, but '.red! do\n    'this is red '.yellow! do\n      ' and yellow.'.no_color!\n    end\n  end)\n\n"
  s.email = "kigster@gmail.com"
  s.homepage = "http://github.com/kigster/colored2"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Add even more color to your life."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.4"])
      s.add_development_dependency(%q<codeclimate-test-reporter>, [">= 0"])
    else
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, ["~> 3.4"])
      s.add_dependency(%q<codeclimate-test-reporter>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, ["~> 3.4"])
    s.add_dependency(%q<codeclimate-test-reporter>, [">= 0"])
  end
end
