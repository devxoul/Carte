# -*- encoding: utf-8 -*-
# stub: nanaimo 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "nanaimo"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Danielle Tomlinson", "Samuel Giddins"]
  s.bindir = "exe"
  s.date = "2016-11-30"
  s.email = ["dan@tomlinson.io", "segiddins@segiddins.me"]
  s.homepage = "https://github.com/CocoaPods/Nanaimo"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "A library for (de)serialization of ASCII Plists."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.12"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.12"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.12"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
  end
end
