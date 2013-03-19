Gem::Specification.new do |spec|

  spec.name        = 'rs232-sigmakoki'
  spec.version     = '0.1.4'
  spec.date        = '2013-03-19'
  spec.summary     = "Ruby interface to SigmaKoki step motor controllers over the serial interface"
  spec.description = "Allows to script the control of SigmaKoki step motor controllers with simple command without directly dealing with the serial port"
  spec.authors     = ["Hugo Benichi"]
  spec.email       = 'hugo[dot]benichi[at]m4x[dot]org'
  spec.homepage    = "http://github.com/hugobenichi/rs232-sigmakoki"

  spec.files       = ['lib/rs232-sigmakoki.rb', 'test/test_rs232-sigmakoki.rb']
  spec.files      << 'rakefile.rb'
  spec.files      << 'README'

  spec.add_dependency 'rs232'

end
