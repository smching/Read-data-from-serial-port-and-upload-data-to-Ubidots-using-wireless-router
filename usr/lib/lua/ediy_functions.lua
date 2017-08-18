#!/usr/bin/lua

port= "/dev/ttyATH0"


function save_config(conf_file, conf)
        local content = ''
        for k,v in pairs(conf) do
                content = content..k..' '..tostring(v)..'\n'
        end
	write_file(conf_file, content)
end



function load_config(conf_file)
	if file_exists(conf_file) then
		local conf={}
  		for line in io.lines(conf_file) do 
			line = line:match( "%s*(.+)" )
 			local key = line:match( "%S+" ):lower()
			local value  = line:match( "%S*%s*(.*)" )
			conf[key]= value
  		end
  		return conf,  io.close
	end
end


-- check if the file exists
function file_exists(filename)
  local f = io.open(filename, "rb")
  if f then f:close() end
  return f ~= nil
end


--write data to a file
function write_file(filename, data)
   file = io.open(filename, "w")
   file:write(data)
   file:close()
end


serialout= io.open(port,"w")  --open serial port and prepare to write data
serialin= io.open(port,"r")   --open serial port and prepare to read data

function writeSerial(serialData)
	serialout:write(serialData.."\r")
	serialout:flush()
end


function readSerial()
	while true do
		local serialData= serialin:read();serialin:flush() -- read data from serial port
		if string.len(serialData)>0 then
			return serialData
		else
			return ""
		end
	end
end



--check internet connection
function internet_up()
  local f = io.popen("ping -c1 google.com | grep ttl")
  local l = f:read("*a")
  f:close()
  if l == '' then
    return false --internet down
  else
    return true --internet up
  end
end


--Starts program prog in a separated process and returns a file handle 
--that you can use to read data from this program
function read_data_from_program(cmd)
   file=io.popen(cmd)
   result= file:read("*all")
   file:close()
   return result
end



-- return true if string is emptied or nil
function isempty(s)
  return s == nil or s == ''
end


----- Pauses the program for the amount of time (in seconds)
function delay(second)
	os.execute("sleep " .. tonumber(second))
end