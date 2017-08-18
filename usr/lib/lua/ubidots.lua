#!/usr/bin/lua
require "ediy_functions"


local Api_URL = " http://things.ubidots.com/api/v1.6/"
local Head1 = "\"Accept: application/json; indent=4\""
local Head2 = "\"Content-Type: application/json\""
local setting_filename = "/tmp/settings.txt"


--obtain a token based on a given api_key
function get_token(api_Key)
   local URL = Api_URL .. "auth/token"
   local api_String = "\"X-Ubidots-ApiKey: " .. api_Key .. "\""
   local dataURL = URL
   local cmd =  "curl -v -XPOST -H " ..  api_String .. dataURL
   my_token = read_data_from_program(cmd)

   if string.sub(my_token,3,7)=="token" then
      my_token = string.sub(my_token,12,string.len(my_token)-2) --trim unwanted text
      return true  --valid token
   else
      return false --invalid token
   end
end


--post data to Ubidots deviceID variable
function post_value(deviceID, data)
   local URL = Api_URL .. "variables/"
   local dataURL = URL .. deviceID .. "/values"
   local api_token = "\"X-Auth-Token: " .. my_token .. "\""
   local value = "\'{\"value\":".. data .."}\'"
   local cmd =  "curl -i --header ".. Head1 .. " --header " .. Head2 .. " --header " .. api_token .. " -X POST -d " .. value .. dataURL
   os.execute(cmd)	--update sensor datapoint
   return true
end


--get data from Ubidots deviceID variable
--get all data from an Ubidots deviceID if get_method=all
--otherwise, get the last value only
function get_value(deviceID, get_method, filename)
   local dataURL = Api_URL .. "variables/" .. deviceID 
   local api_token = "\"X-Auth-Token: " .. my_token .. "\""
   local cmd = "curl -i --header ".. Head1 .. " --header " .. api_token .. " -X GET " .. dataURL
   if get_method=="all" then cmd = cmd .. "/values" end
   my_data = read_data_from_program(cmd)
   if filename~=nil then
     writeData_toFile(filename, my_data) 
   end 
   return true
end


--write data to a file
function writeData_toFile(filename, my_data)
   filename ="/tmp/" .. filename --always save file to tmp folder
   os.remove(filename)
   write_file(filename, my_data)
   return true
end



my_token=""


data=""
function addLog(data)
	data=data.."\n" -- add new line at the end
	write_file("/tmp/ubidots.log", data);
	--local file=io.open(filename, 'w')
	--file:write(data)
	--file:close()
end


