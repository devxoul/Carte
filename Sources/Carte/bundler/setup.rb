require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/CFPropertyList-2.3.5/lib"
$:.unshift "#{path}/"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/claide-1.0.2/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/colored2-3.1.2/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/nanaimo-0.2.3/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/xcodeproj-1.5.2/lib"
