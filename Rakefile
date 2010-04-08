require 'rake/clean'
require 'rake/testtask'

task :default => :test

CLEAN.include %w< doc >
CLOBBER.include %w< dist >

# TESTS #######################################################################

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/symboltable.rb']
end

# DOCS ########################################################################

desc "Generate API documentation (in doc)"
task :doc => FileList['lib/**/*.rb'] do |t|
  rm_rf 'doc'
  sh((<<-SH).gsub(/[\s\n]+/, ' ').strip)
  hanna
    --op doc
    --promiscuous
    --charset utf8
    --fmt html
    --inline-source
    --line-numbers
    --accessor option_accessor=RW
    --main SymbolTable
    --title 'SymbolTable API Documentation'
    #{t.prerequisites.join(' ')}
  SH
end

# PACKAGING & INSTALLATION ####################################################

if defined?(Gem)
  $spec = eval("#{File.read('symboltable.gemspec')}")

  directory 'dist'

  def package(ext='')
    "dist/#{$spec.name}-#{$spec.version}" + ext
  end

  file package('.gem') => %w< dist > + $spec.files do |f|
    sh "gem build symboltable.gemspec"
    mv File.basename(f.name), f.name
  end

  file package('.tar.gz') => %w< dist > + $spec.files do |f|
    sh "git archive --format=tar HEAD | gzip > #{f.name}"
  end

  desc "Build packages"
  task :package => %w< .gem .tar.gz >.map {|e| package(e) }

  desc "Build and install as local gem"
  task :install => package('.gem') do |t|
    sh "gem install #{package('.gem')}"
  end

  desc "Upload gem to rubygems.org"
  task :release => package('.gem') do |t|
    sh "gem push #{package('.gem')}"
  end
end
