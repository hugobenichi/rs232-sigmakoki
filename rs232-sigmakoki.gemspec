

Gem::Specification.new do |spec|

  spec.name        = 'rs232-sigmakoki'
  spec.version     = '0.1.2'
  spec.date        = '2012-07-10'
  spec.summary     = "Ruby interface to SigmaKoki step motor controllers over the serial interface"
  spec.description = "Allows to script usage of the SigmaKoki step motor controllers with simple commands and without serial port troubles"
  spec.authors     = ["Hugo Benichi"]
  spec.email       = 'hugo.benichi@m4x.org'
  spec.homepage    = "http://github.com/hugobenichi/rs232-sigmakoki"
  
  spec.files       = ['lib/rs232-sigmakoki.rb', 'test/test_rs232-sigmakoki.rb'] 
  spec.files      << 'rakefile.rb'
  spec.files      << 'README'
  
  spec.add_dependency 'rs232'
  
end
  


