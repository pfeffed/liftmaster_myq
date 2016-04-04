#!/usr/bin/env ruby
# test application for liftmaster_myq

require 'liftmaster_myq'

def printList(prefix, list)
  if list.nil?
    puts "#{prefix}: nil"
  elsif list.respond_to?("each")
    # @names is a list of some kind, iterate!
    puts "#{prefix} list has #{list.count} items:"
    list.each do |listItem|
      puts "- #{listItem}"
    end
  else
    puts "#{prefix}: #{list}"
  end
end

class Gdo
  attr_accessor :system

  # Create the object
  def initialize()
      @system = LiftmasterMyq::System.new('xxx@gmail.com','xxx')
      printList(".gateways", @system.gateways)
      printList(".garage_doors", @system.garage_doors)
      printList(".lights", @system.lights)
      puts "\n"
  end

  def getDoorStatus()
    if @system.garage_doors.respond_to?("each")
        @system.garage_doors.each do |door|
            puts "door status: #{door.status}"
        end
    end
  end

  def toggle()
    door = @system.garage_doors[0]
    statusStr = "   " + door.status
    if door.status == 'closed'
        statusStr += " => open"
        door.open
    elsif door.status == 'open'
        statusStr += " => closed"
        door.close
    else
        # ignore other states
        statusStr += "..."
    end
    puts statusStr
  end

end

if __FILE__ == $0
  gdo = Gdo.new
  param1 = ARGV[0]

  if param1.nil?
      gdo.getDoorStatus
      exit
  end

  gdo.toggle
end
