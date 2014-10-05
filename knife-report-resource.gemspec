require File.dirname(__FILE__) + '/lib/knife-report-resource'
Gem::Specification.new do |s|
  s.name = 'knife-report-resource'
  s.version = Knife::ReportResource::VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.summary = 'Queries a Chef Reporting API for information about a resource in recent runs'
  s.description = s.summary
  s.author = 'Joshua Timberman'
  s.email = 'joshua@getchef.com'
  s.homepage = 'http://github.com/jtimberman/knife-report-resource'
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md) + Dir.glob('lib/**/*')
  # Reporting requires this version of Chef
  s.add_dependency('chef', '>= 11.8.2')
end
