Gem::Specification.new do |s|
  s.name        = "jsStilt"
  s.version     = '0.1.0'
  s.authors     = ["Jesse Stuart"]
  s.email       = ["jessestuart@gmail.com"]
  s.homepage    = "http://jvatic.github.com/jsStilt"
  s.summary     = %q{jsStilt preloads your asset pipline and runs your Jasmine specs through node.js.}
  s.description = s.summary << %q{
    The real advantage to using jsStilt is running your Jasmine specs in isolation from Rails (3.1+), completely avoiding having to preload your whole application. Sinon.JS and Jasmine are automatically loaded into your test environment. The only assumptions are that your using an asset pipeline (`jsStilt serve /path/to/pipline /path/to/other/pipline ...`) and that for every script.js file there is a coresponding script_spec.js file. NOTE: You may also use CoffeeScript (it's already required to be present on the system to use jsStilt, take advantage of it.)}

  s.executables   = ['jsStilt']
end
