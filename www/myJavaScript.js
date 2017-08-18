//var myVar = setInterval(myTimer ,1000); 
//var autoReresh="ON";
////////////////////////////////////////////////////////////////////////////////////
function myTimer() {
    xmlhttpPost("@D");
}


////////////////////////////////////////////////////////////////////////////////////
//////////////////////////// run this function when webpage start load /////////////
////////////////////////////////////////////////////////////////////////////////////
function autoRun() {
	xmlhttpPost("@D");
	var loc ="https://app.ubidots.com/ubi/getchart/"
	loc = loc + "k9lBXzYe0r0_EeYT5-vaNnHhH8U"
	document.getElementById('ubidots').src = loc;
}

//function myTimerRun() {
//    myVar = setInterval(myTimer, 1000);
//	autoReresh="ON";
//}

//function myTimerStop() {
//    clearInterval(myVar)
//autoReresh="OFF";
//}




//function AutoReflesh() {
//	if (autoReresh=="ON") {
//		myTimerStop();
//	} else {
//		myTimerRun();
//	}
//}


function time_update() {
	var value = Number(document.getElementById("time").value);
	if (isInt(value)) {
		if ((value<0) || (value>2147483647)) {
			alert("Integer ranged from 0 to 2147483647");
		} else {		
			var cmd="@T" + document.getElementById("time").value;
			xmlhttpPost(cmd);
			//location.reload();
		}
	} else {
		alert("Please enter an integer");
	}
}

function interval_update() {
	var value = Number(document.getElementById("interval").value);

	if (isInt(value)) {
		if ((value<15) || (value>3600)) {
			alert("Integer ranged from 15 to 3600");
		} else {
		var cmd="@I" + document.getElementById("interval").value;

		xmlhttpPost(cmd);
		//location.reload();
		}
	} else {
		alert("Please enter an integer");
	}
}

function upload() {
		xmlhttpPost("@U");
		//location.reload();
}

/////////////////////////////////////// Ajax
function xmlhttpPost(action) {
    var xmlHttpReq = false;
    var self = this;
    strURL = "/cgi-bin/control";
	var serialMessage = "";
   
    // Mozilla/Safari
    if (window.XMLHttpRequest) {
        self.xmlHttpReq = new XMLHttpRequest();
    }
    // IE
    else if (window.ActiveXObject) {
        self.xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    //an example of message sent to url --> @00TG1
    //complete message sent to url may look like this --> /cgi-bin/luaSerial?@00TG1
	 cmd= strURL + "?" + action;
    self.xmlHttpReq.open('POST', cmd, true);
    self.xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    self.xmlHttpReq.onreadystatechange = function() {
        if (self.xmlHttpReq.readyState == 4) {
			if (action="@D") {
            			serialMessage = self.xmlHttpReq.responseText;
				process_command(serialMessage);
			}	
		}
    }
    self.xmlHttpReq.send();
}

function process_command(serialMessage) {
	var arduinoMessage = serialMessage.split(',');
	var myTable = document.getElementById('table1');	
	for (rowNum=0; rowNum <4 ; rowNum++) {
		myTable.rows[rowNum+5].cells[1].innerHTML = arduinoMessage[rowNum];
	}
	document.getElementById("time").value = arduinoMessage[1];
	document.getElementById("interval").value = arduinoMessage[2];
}


function isInt(data) {
if (data === parseInt(data, 10))
    return true;
else
    return false;
}

// only accept numeric input
function isNumber(obj) { 
    allowedCharacters = /^[0-9-'.'-',']*$/; 
    if (!allowedCharacters.test(obj.value)) { 
            obj.value = obj.value.replace(/[^0-9-'.'-',']/g,""); 
        } 
}


//enter as tab
function enterAsTab(obj,e) { 
   e=(typeof event!='undefined')?window.event:e;// IE : Moz 
   if(e.keyCode==13){ 
	currrenctTabIndex = obj.tabIndex;
	nextTabIndex = currrenctTabIndex + 1;
	if (nextTabIndex > CurrencyCount*2) {
		nextTabIndex = 1;
	}
	nextTextBoxID = "textBox" + nextTabIndex;
	currentElement = document.getElementById(nextTextBoxID);
	currentElement.focus();
	currentElement.select();
   } 
}


// focus a control
function setFocus(element) {
	currentElement = document.getElementById(element);
	currentElement.focus();

}

