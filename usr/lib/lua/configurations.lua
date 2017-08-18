#!/usr/bin/lua

require "ediy_functions"

conf = { 
	conf_file = "/root/configurations.txt",
	ubidots_api_key = "a76b6cf457beff1961063154950a720f8de40e92",
	ubidots_deviceID = "55607469762542144ef3bfd6",
	com_port = "/dev/ttyATH0",
	baud_rate = "9600"

}

if file_exists(conf.conf_file) then
	conf=load_config(conf.conf_file)
else
	--save_config(conf.conf_file, conf)
end

