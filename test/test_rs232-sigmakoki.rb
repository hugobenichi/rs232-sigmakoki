require 'rs232-sigmakoki'

# A simple test program to confirm the good communication with the 
# plate rotator over serial port.
#
# By default the port name used is 'COM1'

plate = SigmaKoki.new 'COM1'

plate.home

puts plate.status

20.times do
 puts plate.position
 puts plate.busy? 
 sleep 0.2
end

plate.move 10000

while plate.busy?
 print '..' 
 sleep 0.2
end
puts ""

plate.move! 20000
plate.home


puts "ok"
