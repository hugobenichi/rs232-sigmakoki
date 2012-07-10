class SigmaKoki

  require 'rs232'
  
  [
    [:home,     'H:W--'],
    [:stop,     'L:W'],
    [:stop!,    'L:E'],
    [:go,       'G'],
  ].each{ |meth,c| define_method(meth){ @comm.write c} }
  
  [
    [:status,   'Q:'],
    [:rom,      '?:V'],
    [:busy,     '!:'],
  ].each{ |meth,c| define_method(meth){ @comm.query c} }

  
  def ready?
    'R' == self.busy[0] #gsub(' ','').split(',')[-1]
  end
  
  def busy?
    'B' == self.busy[0] #gsub(' ','').split(',')[-1]
  end  

	def wait
    sleep 0.2 while busy?
  end
  
  def jog *args
    @comm.write "J:W%s%s" % args[0..1]
    go
  end

      #main command to rotate the plates
  def move step1, step2 = 0
    s1, s2 = step1 > 0 ? "+" : "-", step2 > 0 ? "+" : "-"
    command = "M:W%sP%i%sP%i" % [s1,step1.abs,s2,step2.abs]
    @comm.write command
    go
  end  
  
  def move! step1, step2 = 0
    move step1, step2
    wait
  end
  
  def position_of chan
    self.status.gsub(' ','').split(',')[chan-1].to_i
  end

  def position
    self.status.gsub(' ','').split(',').map{|x| x.to_i}[0..1]
  end  
  
  def initialize address, params = {}
    @comm = RS232.new address, params
  end

  attr_reader :comm
  
end