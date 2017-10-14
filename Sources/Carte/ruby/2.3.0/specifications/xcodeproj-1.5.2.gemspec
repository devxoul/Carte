# -*- encoding: utf-8 -*-
# stub: xcodeproj 1.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "xcodeproj"
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Eloy Duran"]
  s.date = "2017-09-24"
  s.description = "Xcodeproj lets you create and modify Xcode projects from Ruby. Script boring management tasks or build Xcode-friendly libraries. Also includes support for Xcode workspaces (.xcworkspace) and configuration files (.xcconfig)."
  s.email = "eloy.de.enige@gmail.com"
  s.executables = ["xcodeproj"]
  s.files = ["bin/xcodeproj"]
  s.homepage = "https://github.com/cocoapods/xcodeproj"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Create and modify Xcode projects from Ruby."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<CFPropertyList>, ["~> 2.3.3"])
      s.add_runtime_dependency(%q<claide>, ["< 2.0", ">= 1.0.2"])
      s.add_runtime_dependency(%q<colored2>, ["~> 3.1"])
      s.add_runtime_dependency(%q<nanaimo>, ["~> 0.2.3"])
    else
      s.add_dependency(%q<CFPropertyList>, ["~> 2.3.3"])
      s.add_dependency(%q<claide>, ["< 2.0", ">= 1.0.2"])
      s.add_dependency(%q<colored2>, ["~> 3.1"])
      s.add_dependency(%q<nanaimo>, ["~> 0.2.3"])
    end
  else
    s.add_dependency(%q<CFPropertyList>, ["~> 2.3.3"])
    s.add_dependency(%q<claide>, ["< 2.0", ">= 1.0.2"])
    s.add_dependency(%q<colored2>, ["~> 3.1"])
    s.add_dependency(%q<nanaimo>, ["~> 0.2.3"])
  end
end
