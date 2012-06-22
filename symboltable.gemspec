Gem::Specification.new do |s|
  s.name = 'symboltable'
  s.version = '1.0.2'
  s.date = Time.now.strftime('%Y-%m-%d')

  s.summary = 'A Symbols-only Hash for Ruby'
  s.description = 'A Symbols-only Hash for Ruby'

  s.author = 'Michael Jackson'
  s.email = 'mjijackson@gmail.com'

  s.require_paths = %w< lib >

  s.files = Dir['lib/**/*.rb'] +
    Dir['test/*.rb'] +
    %w< symboltable.gemspec Rakefile README.md >

  s.test_files = s.files.select {|path| path =~ /^test\/.*.rb/ }

  s.add_development_dependency('rake')

  s.has_rdoc = true
  s.rdoc_options = %w< --line-numbers --inline-source --title SymbolTable --main SymbolTable >
  s.extra_rdoc_files = %w< README.md >

  s.homepage = 'http://mjijackson.github.com/symboltable'
end
