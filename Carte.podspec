Pod::Spec.new do |s|
  s.name             = "Carte"
  s.version          = "2.2.1"
  s.summary          = "Open source notice generator for Cocoa."
  s.homepage         = "https://github.com/devxoul/Carte"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Suyeol Jeon" => "devxoul@gmail.com" }
  s.source           = { :git => "https://github.com/devxoul/Carte.git",
                         :tag => s.version.to_s }
  s.source_files     = "Sources/Carte/*.swift"
  s.preserve_paths   = "Sources/Carte/**/*"
  s.requires_arc     = true
  s.swift_version    = "5.0"

  s.ios.deployment_target = "8.0"
end
