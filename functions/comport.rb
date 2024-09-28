## put out the source line without buffering when use "ruby -rdebug" since ruby2.6.3p62 on mingw64
$stdout.sync = true
## change the directory in which script is and execute
Dir.chdir(__dir__)

require 'win32ole'

def ports
    locator = WIN32OLE.new("WbemScripting.SWbemLocator")
    services = locator.ConnectServer(".","root/cimv2")
    ports = services.ExecQuery "Select * From Win32_SerialPort"
    ports.each do |port|
        p port.Caption
        # p port.Description
        # print "\n"
    end
end

def ports_pnp
    ps = []
    locator = WIN32OLE.new("WbemScripting.SWbemLocator")
    services = locator.ConnectServer(".","root/cimv2")
    ports = services.ExecQuery "Select * From Win32_PnPEntity"
    ports.each do |port|
      if /\(COM\d+\)$/ =~ port.Caption
            p port.Caption
            # p port.Description
            # p port.Manufacturer
            #print "\n"
       end
    end
end

# print "Select * From Win32_SerialPort\n"
# ports

print "Select * From Win32_PnPEntity\n"
ports_pnp
