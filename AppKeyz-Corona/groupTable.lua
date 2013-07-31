---------------------------------------------------------------------------------
--
-- scene5.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local JSON = require("json")
local mime = require("mime")
---------------------------------------------------------------------------------
-- RESPONSE OF  WEBSERVICE 
-----------------*************************local scene2 = require("scene2")**********************---------------------------------
local jsonTable={ };
local productId={};
local alert ;
_G.DeviceIP=0;
_G.DeviceToken=0;
-- Handler that gets notified when the alert closes
local function onComplete( event )
	print( "index => ".. event.index .. "    action => " .. event.action )

	local action = event.action
	if "clicked" == event.action then
		if 2 == event.index then
			-- Open url if "Learn More" was clicked by the user
         native.cancelAlert( alert )
		end
	elseif "cancelled" == event.action then
	native.cancelAlert( alert )
		-- our cancelAlert timer function dismissed the alert so do nothing
	end
end

	       


local function createPurchase(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response createPurchase :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json) ;
         -- print (" purchaseid " ..jsonTable.purchaseid ) ;

          --print("productId" ..table )
                      if jsonTable.error  == 0 then
               alert = native.showAlert( " ", " Purchase process successfully.", { "OK" } ) 
              elseif jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" }) 
                          elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Invalid Purchase.", " Please try again.", { "OK" })
            end

          -- _G.firstname = jsonTable.firstname;
  
    end

    return true
end

local function listpurchases(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response listpurchases :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;
         -- print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
                        
                      if jsonTable.error  == 0 then
            
              elseif jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" } ) 
                          elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Invalid Purchase.", " Please try again.", { "OK" } )
            end

      end

    return true
end
local function purchaseid(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response purchaseid :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          
          print (" error:- " ..error ) ;
                 if jsonTable.error  == 0 then
           _G.productsku=jsonTable.productsku;
            _G.purchaseprice=jsonTable.purchaseprice;
            _G.productname=jsonTable.productname;
            _G.active=jsonTable.active;
            _G.consumableid=jsonTable.consumableid;
            _G.expiration=jsonTable.expiration;
              elseif jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" }) 
                          elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Invalid Purchase.", " Please try again.", { "OK" } )
            end

 
          -- _G.firstname = jsonTable.firstname;
  
    end

    return true
end

local function updatePurchase(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response updatePurchase :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;

          print (" error:- " ..error ) ;
          -- _G.firstname = jsonTable.firstname;
                if jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" } ) 
                          elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Invalid Purchase.", " Please try again.", { "OK" } )
            end
    end

    return true
end
local function deletepurchaseWithEmail(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
                           if jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" } ) 
                          elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Purchase Not Found.", " Please try again.", { "OK" }, onComplete )
            end
          -- _G.firstname = jsonTable.firstname;
  
    end

    return true
end


local function createDeviceID(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
                          if jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 2 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "Duplicate Device ID.", " Please try again.", { "OK" } )
                 elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Device not found.", " Please try again.", { "OK" } )
             elseif jsonTable.error  == 5 then
               alert = native.showAlert( "Too many devices.", " Please try again.", { "OK" })
            end
    end

    return true
end
local function createDeviceID ( event )
   -- perform basic error handling

    -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
                          if jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 2 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "Duplicate Device ID.", " Please try again.", { "OK" } )
                 elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Device not found.", " Please try again.", { "OK" } )
             elseif jsonTable.error  == 5 then
               alert = native.showAlert( "Too many devices.", " Please try again.", { "OK" })
            end
    end

    return true
end

local function listdevices(event)
   -- perform basic error handling
 
    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
            _G.deviceids = jsonTable.deviceids;
             if( error == 1)then
          alert = native.showAlert("Bad Parameters.","Usually means you're missing apiaction or apptoken ", { "OK" } );
            elseif( error == 2)then
          alert = native.showAlert("This Email does not does exist in our system","please Register or log in using a different email ", { "OK" } );
             end
  
    end

    return true
end

local function readDevice(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
         _G.deviceid = jsonTable.deviceid;
         _G.devicetype = jsonTable.devicetype;
         _G.deviceip = jsonTable.deviceip;
           _G.devicetoken = jsonTable.devicetoken;
               if( error == 1)then
          alert = native.showAlert("Bad Parameters.","Usually means you're missing apiaction or apptoken ", { "OK" } );
            elseif( error == 2)then
          alert = native.showAlert("This Email does not does exist in our system","please Register or log in using a different email ", { "OK" } );
               end
    end

    return true
end

local function updatedevice(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
                          if jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 2 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "Duplicate Device ID.", " Please try again.", { "OK" } )
                 elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Device not found.", " Please try again.", { "OK" } )
             elseif jsonTable.error  == 5 then
               alert = native.showAlert( "Too many devices.", " Please try again.", { "OK" })
            end
    end

    return true
end

local function deletedevice(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
                          if jsonTable.error  == 1 then
               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } ) 
              elseif jsonTable.error  == 2 then
               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" } ) 
              elseif jsonTable.error  == 3 then
               alert = native.showAlert( "Duplicate Device ID.", " Please try again.", { "OK" } )
                 elseif jsonTable.error  == 4 then
               alert = native.showAlert( "Device not found.", " Please try again.", { "OK" } )
             elseif jsonTable.error  == 5 then
               alert = native.showAlert( "Too many devices.", " Please try again.", { "OK" })
            end
    end

    return true
end

local function listconsumables(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
          _G.consumables = jsonTable.consumables;
                  if( error == 1)then
          alert = native.showAlert("Bad Parameters.","Usually means you're missing apiaction or apptoken ", { "OK" } );
            elseif( error == 2)then
          alert = native.showAlert("This Email does not does exist in our system","please Register or log in using a different email ", { "OK" } );
        
    end
  
    end

    return true
end
local function readconsumable(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
         _G.nameTxt = jsonTable.name;
         _G.balance = jsonTable.balance;
          if( error == 1) then
          alert = native.showAlert("Bad Parameters.","Usually means you're missing apiaction or apptoken ", { "OK" } );
            elseif( error == 2) then
          alert = native.showAlert("This Email does not does exist in our system","please Register or log in using a different email ", { "OK" } );
        
          end
    end

    return true
end
local function updateconsumable(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response deletepurchaseWithEmail :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;   
        --  print (" FirstName " ..jsonTable.firstname ) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
           if( error == 1) then
          alert = native.showAlert("Bad Parameters.","Usually means you're missing apiaction or apptoken ", { "OK" } );
            elseif( error == 2) then
          alert = native.showAlert("This Email does not does exist in our system","please Register or log in using a different email ", { "OK" } );
                    elseif( error == 4) then
          alert = native.showAlert("Invalid Consumable","please try again ", { "OK" } );
          end
  
    end

    return true
end
---------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar ) 

--import the widget library
local widget = require( "widget" )
local listItems
-- create a constant for the left spacing of the row content
local LEFT_PADDING = 10

--Set the background to white
display.setDefault( "background", 255, 255, 255 )
 


local image, list
local rowTitles = {}


-- Handle row rendering
local function onRowRender( event )
	local phase = event.phase
	local row = event.row
	local isCategory = row.isCategory
	
	--print( rowTitles[1] )
	
	local rowTitle = display.newText( row, rowTitles[row.index], 0, 0, native.systemFontBold, 16 )
	rowTitle.x = row.x - ( row.contentWidth * 0.5 ) + ( rowTitle.contentWidth * 0.5 ) + LEFT_PADDING
	rowTitle.y = row.contentHeight * 0.5
	rowTitle:setTextColor( 0, 0, 0 )
	
	if not isCategory then
		local rowArrow = display.newImage( row, "rowArrow.png", false )
		rowArrow.x = row.x + ( row.contentWidth * 0.5 ) - rowArrow.contentWidth
		rowArrow.y = row.contentHeight * 0.5
	end
end

-- Hande row touch event ***
local function onRowTouch( event )
	local phase = event.phase
	local row = event.target
	---For Edit A/c Row
	if row.index== 2 then
		print( "Pressed row: " .. row.index )
		
      storyboard.gotoScene( "scene6", "slideLeft", 800 , parameters )
      ----for  logout  row
	elseif row.index == 3 then
	storyboard.gotoScene( "scene1", "slideLeft", 800  )
	    ----for  Create Purchase  row
	  elseif row.index==5 then
	   print( " random number " ..math.random(3)) 
	   local randomNO
	   randomNO=math.random(3)
	   print( " random number " ..randomNO);
	      if randomNO ==1 then
	      	local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=createpurchase&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&productsku=appkeyztest1&purchaseprice=0&balance=0&expiration="
	      	print( URL);
	      	         native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	      	 network.request( URL, "GET", createPurchase ) 
	      	elseif randomNO==2 then
	      	local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=createpurchase&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&productsku=appkeyztest2&purchaseprice=0&balance=0&expiration="
	          print( URL);
	                  native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	      	 network.request( URL, "GET", createPurchase ) 
	      	elseif randomNO ==3 then
	      	local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=createpurchase&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&productsku=appkeyztest3&purchaseprice=0&balance=0&expiration="
	          print( URL);
	                  native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	         network.request( URL, "GET", createPurchase ) 
	      end
      	      ---for  listpurchasese  row
	  elseif row.index==6 then
           local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=listpurchases&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password)
	        print(url);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", listpurchases )

     ----for  readpurchase row 
	     elseif row.index==7 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=readpurchase&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&purchaseid="..(_G.purchaseid)
	        print(url);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", purchaseid )--createDevice purchaseid
     
     ----for  updatePurchase row 
	     elseif row.index==8 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=updatepurchase&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&purchaseid="..(_G.purchaseid).."&expiration=2020-12-31&active=true"
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", updatePurchase )  
	        
  ----for  deletepurchaseWithEmail row 
	     elseif row.index==9 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=deletepurchase&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&purchaseid="..(_G.purchaseid)
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", deletepurchaseWithEmail )
	       
	       ---Device Actions
	         ----for  createdevice  row
	     	       elseif row.index==11 then
  -- local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=createdevice&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&deviceid="..(_G.DeviceId).."&devicetype="..(_G.Device).."&deviceip=0&devicetoken=0"
	          local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=createdevice&apptoken=ci48xk6m&email="..(_G.email) .. "&password="..(_G.password).."&deviceid="..(_G.DeviceId).."&devicetype="..(_G.DeviceName).."&deviceip=&devicetoken="    
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", createDeviceID )   
	        
         	 ----for  listdevices  row
            elseif row.index==12 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=listdevices&apptoken=ci48xk6m&email="..(_G.email) .. "&password="..(_G.password)
	        print(URL);
	        	        native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", listdevices )
	        
	                 	 ----for  readDevice  row
            elseif row.index==13 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=readdevice&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&deviceid="..(_G.DeviceId)
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", readDevice )  
	         
	         ----for  updatedevice  row
	       elseif row.index ==14 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=updatedevice&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&deviceid="..(_G.DeviceId).."&newdeviceid="..(_G.newUdId).."&devicetype="..(_G.DeviceName) .."&deviceip=0&devicetoken=0"
	         print(URL);
	       native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	     network.request( URL, "GET", updatedevice )
	        
	        ----for  deletedevice  row
	       elseif row.index==15 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=deletedevice&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&deviceid="..(_G.DeviceId)
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", deletedevice )--createDeviceID deletedevice
	        
	       ---**User Consumable Interface**--
     ----for  listconsumables  row
           elseif row.index==17 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=listconsumables&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password)
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", listconsumables )
	         ----for  readconsumable  row
	         elseif row.index==18 then
	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=readconsumable&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&consumableid=1"
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", readconsumable )
	         
	           ----for  updateconsumable  row
	       elseif row.index==19 then
	       local setbalance,adjustbalance
             local x=math.random(1,10);
		      x=x%2;
	        local y=math.random(1,100);
	         y=y%2;
	          print ( " print y"..y);
	        if (y ==0) then
	        	setbalance=x;
	        	adjustbalance=-1;
                else 
	        	 setbalance=-1;
	        	adjustbalance=x;
	        end
	      -- updateConsumableCheck ( t);
	       if adjustbalance ==-1 then
	       	
	       	else
	       	
           	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=updateconsumable&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&consumableid=1&adjustbalance="..(x)
	        print(URL);
	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
	        network.request( URL, "GET", updateconsumable )
	       end
	         if setbalance ==-1 then
	         	else
	        	          local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=updateconsumable&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&consumableid=1&setbalance="..(x)
	           network.request( URL, "GET", updateconsumable )
	         end     
	end   
		  
		print( "Tapped and/or Released row: " .. row.index )
	
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
local screenGroup = self.view

-- create a constant for the left spacing of the row content
local LEFT_PADDING = 10

--Set the background to white
	local screenGroup = self.view
	image = display.newImage( "Default.png" )
	screenGroup:insert( image )
	image.touch = onSceneTouch
---display.setDefault( "background", 255, 255, 255 )
 
--Create a group to hold our widgets & images
--local widgetGroup = display.newGroup()

-- The gradient used by the title bar
local titleGradient = graphics.newGradient( 
	{ 189, 203, 220, 255 }, 
	{ 89, 116, 152, 255 }, "down" )

-- Create a tableView
list = widget.newTableView
{
	top =0,
	width = 320, 
	height = 448,
	maskFile = "mask-320x448.png",
	onRowRender = onRowRender,
	onRowTouch = onRowTouch,

}
--Insert widgets/images into a group
--widgetGroup:insert( list )
screenGroup:insert( list )


--Items to show in our list
 listItems = {
	{ title = "User Action", items = { "Edit Account", "Logout" } },
	{ title = "Purchase Action", items = { "Create Purchase", "List Purchases", "Read Purchase", "Update Purchase", "Deactivate Purchase" } },
	{ title = "Device Action", items = { "Create Device", "List Devices", "Read Device", "Update Device", "Delete Device" } },
	{ title = "Consumable Action", items = { "List Consumables", "Read Consumble", "Update Consumble" } },
}


for i = 1, #listItems do
	--Add the rows category title
	rowTitles[ #rowTitles + 1 ] = listItems[i].title
	
	--Insert the category
	list:insertRow{
		rowHeight = 24,
		rowColor = 
		{ 
			default = { 150, 160, 180, 200 },
		},
		isCategory = true,
	}

	--Insert the item
	for j = 1, #listItems[i].items do
		--Add the rows item title
		rowTitles[ #rowTitles + 1 ] = listItems[i].items[j]
		
		--Insert the item
		list:insertRow{
			rowHeight = 40,
			isCategory = false,
			listener = onRowTouch
		}
	end
end

end


 

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "4: enterScene event" )

	
	--text3.isVisible = true
	-- remove previous scene's view
	storyboard.purgeScene( "scene4" )
	storyboard.purgeScene( "scene6" )
	storyboard.purgeScene( "scene2" )
	storyboard.purgeScene( "scene5" )
	storyboard.purgeScene( "scene3" )
	
	
end

function scene:exitScene()

image:removeEventListener( "touch", image )
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 4's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------




return scene