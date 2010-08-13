# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{less}
  s.version = "2.0.0.pre"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charles Lowell"]
  s.date = %q{2010-08-13}
  s.default_executable = %q{lessc}
  s.description = %q{Invoke the Less CSS compiler from Ruby (http://lesscss.org)}
  s.email = %q{cowboyd@thefrontside.net}
  s.executables = ["lessc"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["bin", "bin/lessc", "deps", "deps/less.js", "deps/less.js/benchmark", "deps/less.js/benchmark/benchmark.less", "deps/less.js/benchmark/less-benchmark.js", "deps/less.js/bin", "deps/less.js/bin/lessc", "deps/less.js/build", "deps/less.js/build/ecma-5.js", "deps/less.js/build/header.js", "deps/less.js/build/require.js", "deps/less.js/dist", "deps/less.js/dist/less-1.0.33.js", "deps/less.js/dist/less-1.0.33.min.js", "deps/less.js/lib", "deps/less.js/lib/less", "deps/less.js/lib/less/browser.js", "deps/less.js/lib/less/functions.js", "deps/less.js/lib/less/index.js", "deps/less.js/lib/less/parser.js", "deps/less.js/lib/less/tree", "deps/less.js/lib/less/tree/alpha.js", "deps/less.js/lib/less/tree/anonymous.js", "deps/less.js/lib/less/tree/call.js", "deps/less.js/lib/less/tree/color.js", "deps/less.js/lib/less/tree/comment.js", "deps/less.js/lib/less/tree/dimension.js", "deps/less.js/lib/less/tree/directive.js", "deps/less.js/lib/less/tree/element.js", "deps/less.js/lib/less/tree/expression.js", "deps/less.js/lib/less/tree/import.js", "deps/less.js/lib/less/tree/javascript.js", "deps/less.js/lib/less/tree/keyword.js", "deps/less.js/lib/less/tree/mixin.js", "deps/less.js/lib/less/tree/operation.js", "deps/less.js/lib/less/tree/quoted.js", "deps/less.js/lib/less/tree/rule.js", "deps/less.js/lib/less/tree/ruleset.js", "deps/less.js/lib/less/tree/selector.js", "deps/less.js/lib/less/tree/url.js", "deps/less.js/lib/less/tree/value.js", "deps/less.js/lib/less/tree/variable.js", "deps/less.js/lib/less/tree.js", "deps/less.js/LICENSE", "deps/less.js/Makefile", "deps/less.js/package.json", "deps/less.js/README.md", "deps/less.js/test", "deps/less.js/test/css", "deps/less.js/test/css/colors.css", "deps/less.js/test/css/comments.css", "deps/less.js/test/css/css-3.css", "deps/less.js/test/css/css.css", "deps/less.js/test/css/functions.css", "deps/less.js/test/css/import.css", "deps/less.js/test/css/javascript.css", "deps/less.js/test/css/lazy-eval.css", "deps/less.js/test/css/media.css", "deps/less.js/test/css/mixins-args.css", "deps/less.js/test/css/mixins-closure.css", "deps/less.js/test/css/mixins-nested.css", "deps/less.js/test/css/mixins-pattern.css", "deps/less.js/test/css/mixins.css", "deps/less.js/test/css/operations.css", "deps/less.js/test/css/parens.css", "deps/less.js/test/css/rulesets.css", "deps/less.js/test/css/scope.css", "deps/less.js/test/css/selectors.css", "deps/less.js/test/css/strings.css", "deps/less.js/test/css/variables.css", "deps/less.js/test/css/whitespace.css", "deps/less.js/test/less", "deps/less.js/test/less/colors.less", "deps/less.js/test/less/comments.less", "deps/less.js/test/less/css-3.less", "deps/less.js/test/less/css.less", "deps/less.js/test/less/functions.less", "deps/less.js/test/less/import", "deps/less.js/test/less/import/import-test-a.less", "deps/less.js/test/less/import/import-test-b.less", "deps/less.js/test/less/import/import-test-c.less", "deps/less.js/test/less/import/import-test-d.css", "deps/less.js/test/less/import.less", "deps/less.js/test/less/javascript.less", "deps/less.js/test/less/lazy-eval.less", "deps/less.js/test/less/media.less", "deps/less.js/test/less/mixins-args.less", "deps/less.js/test/less/mixins-closure.less", "deps/less.js/test/less/mixins-nested.less", "deps/less.js/test/less/mixins-pattern.less", "deps/less.js/test/less/mixins.less", "deps/less.js/test/less/operations.less", "deps/less.js/test/less/parens.less", "deps/less.js/test/less/rulesets.less", "deps/less.js/test/less/scope.less", "deps/less.js/test/less/selectors.less", "deps/less.js/test/less/strings.less", "deps/less.js/test/less/variables.less", "deps/less.js/test/less/whitespace.less", "deps/less.js/test/less-test.js", "less.rb.gemspec", "lib", "lib/less", "lib/less/parser.rb", "lib/less.rb", "Rakefile", "README.md"]
  s.homepage = %q{http://github.com/cowboyd/less.rb}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{less}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Leaner CSS, in your browser or Ruby (via less.js)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<therubyracer>, [">= 0.7.5"])
    else
      s.add_dependency(%q<therubyracer>, [">= 0.7.5"])
    end
  else
    s.add_dependency(%q<therubyracer>, [">= 0.7.5"])
  end
end
