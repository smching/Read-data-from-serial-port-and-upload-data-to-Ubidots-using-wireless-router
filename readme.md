This is part of the source code for my timeDuino project (code for router only, no Arduino source code), it uses a wireless router to read data from serial port, the data is then uploading to Ubidots.


Instruction: Upload all files and folders to the router.

etc folder: a file used to run the program on router startup.

www folder: display information on a webpage, additionally it is used to update data to Arduino.

root folder: application program running on router.

usr folder: some basic lua functions such as read/write serial port, save/load configuration, etc.



Run the program on router starup
SSH to router and run the following command in order to make the file (autorun_timeDuino) executable.

chmod a+x /etc/init.d/autorun_timeDuino

Then run the following command to creates a link to the script in the /etc/rc.d directory.
/etc/init.d/autorun_timeDuino enable



Message string receiving from serial port (/root/timeDuino line 44 to line 53) 
There are only two command at the moment, @SND and @LST
Eg. @SND1000 will upload the value of 1000 to Ubidots
Eg. @LST794,15,3600,ON will write 794,15,3600,ON to the "/tmp/ubidots.log" file.

By: http://ediy.com.my



