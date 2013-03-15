class SigmaKoki

  require 'rs232'
  
  # programatically define commands
  [
    [:home,     'H:W--'],
    [:stop,     'L:W'],
    [:stop!,    'L:E'],
    [:go,       'G'],
  ].each{ |meth,c| define_method(meth){ @comm.write c} }
  
  # programatically define queries
  [
    [:status,   'Q:'],
    [:rom,      '?:V'],
    [:busy,     '!:'],
  ].each{ |meth,c| define_method(meth){ @comm.query c} }

  # checks if the device is idle 
  def ready?
    'R' == self.busy[0] #gsub(' ','').split(',')[-1]
  end
  
  # checks if the device is currently bury rotating 
  def busy?
    'B' == self.busy[0] #gsub(' ','').split(',')[-1]
  end  

  # blocking wait until the device is free to execute command again
  def wait
    sleep 0.2 while busy?
  end
 
  # initiates a continuous and slow rotation 
  def jog *args
    @comm.write "J:W%s%s" % args[0..1]
    go
  end

  # main command to rotate the plates (non-blocking)
  # step1 and step2 are the number of angle units to move (relative move)
  def move step1, step2 = 0
    step1 = 0 if step1.nil?
    s1, s2 = step1 > 0 ? "+" : "-", step2 > 0 ? "+" : "-"
    command = "M:W%sP%i%sP%i" % [s1,step1.abs,s2,step2.abs]
    @comm.write command
    go
  end  
 
  # main command to rotate the plates (blocking)
  # step1 and step2 are the number of angle units to move (relative move)
  def move! step1, step2 = 0
    move step1, step2
    wait
  end
  
  # main command to rotate the plates (non-blocking)
  # step1 and step2 are the final angular position (absolute move)
  def amove *step_args
    move *self.position.map { |x|
      y = step_args.shift
      (y.is_a? Fixnum) ? y-x : 0
    }
  end

  # main command to rotate the plates (blocking)
  # step1 and step2 are the final angular position (absolute move)
  def amove! *step_args
    amove *step_args
    wait
  end
 
  # pulls back the rotating plates to mechanical origin (blocking) 
  def home!
    home
    wait
  end
 
  # gets current position of plates (length 2 array) 
  def position
    self.status.gsub(' ','').split(',').map{|x| x.to_i}[0..1]
  end  
 
  # gets current position of plate 1 or 2 
  def position_of chan
    self.status.gsub(' ','').split(',')[chan-1].to_i
  end
  
  def initialize address, params = {}
    @comm = RS232.new address, params
  end

  attr_reader :comm
  
end
