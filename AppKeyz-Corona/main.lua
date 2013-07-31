--
-- Abstract: Storyboard Sample
--
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2011 Corona Labs Inc. All Rights Reserved.
--
-- Demonstrates use of the Storyboard API (scene events, transitioning, etc.)
--

-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
local storyboard = require "storyboard"
local widget = require "widget"

 
-- load first scene
storyboard.gotoScene( "scene1", "fade", 800 )
   print (  "Device model"..system.getInfo( "model") ,"Device name "..system.getInfo( "model")," Device Version"..system.getInfo("platformName"));
   print( "Device name "..system.getInfo("platformVersion" ));
   print(" Device Version"..system.getInfo("platformName"));
   _G.DeviceName=system.getInfo( "model");
   print(" Device name".._G.DeviceName);
   _G.DeviceId=system.getInfo( "deviceID" );
   local letters={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"};
  local newUdId= { }
   local function displayWords(letters)   
	for i = 1, 10 do
		     local randN = math.random(1,50)
	        newUd  = (letters[randN] );
	 table.insert(newUdId ,i,newUd);

	end   
	  print( " storybord.purchaseid--->".. table.concat( newUdId ));
	  _G.newUdId=table.concat( newUdId )
	   print( " storybord.newUdId--->".._G.newUdId)
end
displayWords(letters)
            --local randN = math.random(1,30)
     -- _G.newUdId = (letters[randN] );
   


--[[ Uncomment to monitor app's lua memory/texture memory usage in terminal...

local function garbagePrinting()
	collectgarbage("collect")
    local memUsage_str = string.format( "memUsage = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str )
    local texMemUsage_str = system.getInfo( "textureMemoryUsed" )
    texMemUsage_str = texMemUsage_str/1000
    texMemUsage_str = string.format( "texMemUsage = %.3f MB", texMemUsage_str )
    print( texMemUsage_str )
end

Runtime:addEventListener( "enterFrame", garbagePrinting )
--]]