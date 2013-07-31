---------------------------------------------------------------------------------
--
-- scene3.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local mime = require("mime")
local JSON = require("json")
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
-- Require the widget library
local widget = require( "widget" )

-- forward declarations
local titleField
local loginField 
local passwordField
local backBtn
local navHeader
local navBar
local emailLbl
local passwordLbl
local screenGroup
 local userid
local password 
local alert
local  loginText  ,passwordText
  loginText = 0
  passwordText = 0

local function onComplete( event )
	print( "index => ".. event.index .. "    action => " .. event.action )

	local action = event.action
	if "clicked" == event.action then
		if 2 == event.index then
			-- Open url if "Learn More" was clicked by the user
			storyboard.gotoScene( "groupTable", "slideLeft", 800  )
		end
	elseif "cancelled" == event.action then
	    native.cancelAlert( alert )
		-- our cancelAlert timer function dismissed the alert so do nothing
	end
end
-----------------***********************************************---------------------------------
local jsonTable={ };
local function loginCallback(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;
          print (" error  " ..jsonTable.error ) ;
                    _G.firstname = jsonTable.firstname;
            _G.lastname=   jsonTable.lastname;
           _G.email= jsonTable.email;
           _G.password=jsonTable.password;
           _G.sex=jsonTable.sex ; 
             _G.age = jsonTable.age ;   
          

          print( " storybord.frstname--->" .._G.firstname);
          print( " storybord.lastname--->" .._G.lastname);
 print( " storybord.email--->" .._G.email);
 print( " storybord.password--->" .._G.password);
 print( " storybord.sex--->" .._G.sex);
 print( " storybord.sex--->" .._G.age);  
            local randN = math.random(1,50)
      _G.purchaseid = ( jsonTable.purchaseids[randN] )
     print( " storybord.purchaseid--->" .._G.purchaseid);
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
          if  error  == 0 then
          	storyboard.gotoScene( "groupTable", "slideLeft", 800  )
          	 alert = native.showAlert( "Appkeyz Sample Application says:", "user account retrevied successfully. ", { "OK" } )
           elseif  jsonTable.error  == 1 then
               alert = native.showAlert( "The email you created is not formatted properly", "please try again. ", { "OK" } )
           elseif  jsonTable.error  == 2 then
               alert = native.showAlert( "This Email does not does exist in our system", "please Register or log in using a different email. ", { "OK" } )
        end
        
       
        --  local path =system.pathForFile(" UserInformation.txt ",system.DocumentDirectory);
         --- local file =io.open(path, "w")
        --  local data =JSON.encode( jsonTable);
        --  file:write(data);
         -- io.close(file);
  
          
    end

    return true
end
  
------------------------**********************************************------------------
local buttonHandlerBackBTN = function( event )
      print("back button released")
    --storyboard.gotoScene( "scene2", "slideUp", 800  )
    
storyboard.gotoScene( "scene2","slideLeft", 1000 )
end
  local buttonHandlerForgetPassword = function( event )
      print("back button released")
    storyboard.gotoScene( "forgotpassword", "slideLeft", 800  )
   
end

local buttonHandlerLogineWtihAppKye = function( event )
    print(" login button ")
    print( " last text Button ".. loginText )
   
    if  loginText  == 1  and  passwordText ==1 or loginText  == 0  and  passwordText == 0 then
    	--elseif event.phase == "ended" or event.phase == "submitted" then
   alert = native.showAlert( "Invalid Email or Password", "Please enter something here. ", { "OK" })
   elseif  passwordText < 6 then
     alert = native.showAlert( "Passwords Too Short", "Password must be at least 6 characters. ", { "OK" })
         else
   local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=readuser&apptoken=ci48xk6m&email="..(userid) .. "&password=" ..(password)
    --local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=readuser&apptoken=ci48xk6m&email=vijay.singh@smartbuzz.net&password=123456" 
   -- DEBUG: Show constructed url
       print ( "Remote URL: " .. URL )
       network.request( URL, "GET", loginCallback ) 
   
    
 
     end
end

  local function cancelAlert( )
	native.cancelAlert( alert )
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
local screenGroup = self.view
image = display.newImage( "Default.png" )
	screenGroup:insert( image )
	image.touch = onSceneTouch
    navBar = display.newImage("navBar.png", 0, 0, true)
   navBar.x = display.contentWidth*.5
    navBar.y = math.floor(display.screenOriginY + navBar.height*0.5)
     navHeader = display.newText(" LOGIN ", 0, 0, native.systemFontBold, 16)
     navHeader.isVisible = true
    navHeader:setTextColor(255, 255, 255) 
navHeader.x = display.contentWidth*.5
navHeader.y = navBar.y
     screenGroup:insert( navBar )
	screenGroup:insert( navHeader )
 backBtn = widget.newButton{ 
        
        	defaultFile = "backButton.png",
	      overFile = "backButton.png",
	      emboss = true,
   onRelease = buttonHandlerBackBTN,
}

loginAppkeyBtn = widget.newButton
{
	defaultFile = "loginwithAppkeyz.png",
	overFile = "loginwithAppkeyz.png",
	--label = "Button 1 Label",
	emboss = true,
    onRelease = buttonHandlerLogineWtihAppKye,
}
 ForgetBtn = widget.newButton
{
	defaultFile = "forgetbtn.png",
	overFile = "forgetbtn.png",
	--label = "Button 1 Label",
	emboss = true,
    onRelease = buttonHandlerForgetPassword,
}
backBtn.x =29; backBtn.y = navBar.y
screenGroup:insert( backBtn )
loginAppkeyBtn.x = 160; loginAppkeyBtn.y = 230
screenGroup:insert( loginAppkeyBtn )
ForgetBtn.x = 160; ForgetBtn.y = 280
screenGroup:insert( ForgetBtn )

-- Create our Text Field
emailLbl = display.newText(" Email :", 0, 0, native.systemFontBold, 16)
emailLbl.isVisible = true
emailLbl:setTextColor(255, 255, 255) 
emailLbl.x = display.contentWidth*.5
emailLbl.y = 80
screenGroup:insert( emailLbl )

loginField = native.newTextField( 20, 90, 280, 30 )
loginField.inputType= "default "
loginField.font = native.newFont( native.systemFontBold, inputFontSize )
loginField:addEventListener( "userInput", loginField )
screenGroup:insert( loginField )

----Create our Text Field 
passwordLbl = display.newText("Password :", 0, 0, native.systemFontBold, 16)
passwordLbl.isVisible = true
passwordLbl:setTextColor(255, 255, 255) 
passwordLbl.x = display.contentWidth*.5
passwordLbl.y = 145
screenGroup:insert( passwordLbl )

passwordField= native.newTextField(20,155,280,30)
passwordField.font = native.newFont( native.systemFontBold, inputFontSize )
passwordField.inputType= "default "
passwordField:addEventListener( "userInput", passwordField )
 passwordField.isSecure = true
screenGroup:insert( passwordField )
---function of password text listener & email text field 
function loginField :userInput( e )
    if e.phase == "began" then

        -- user begins editing textField
        print( e.text )
     

    elseif e.phase == "ended" then
    
        -- textField/Box loses focus

    elseif  e.phase == "submitted" then
        
         native.setKeyboardFocus( nil )
        -- do something with defaulField's text

    elseif e.phase == "editing" then
     
        print( e.newCharacters )
        print( e.oldText )
        print( e.startPosition )
        print( " last text".. e.text )
        loginText =e.startPosition
        userid =  loginField.text;

    end
end

function passwordField :userInput(event)
    if event.phase == "began" then

        -- user begins editing textField
        print( event.text )
     

    elseif event.phase == "ended" then
    
        -- textField/Box loses focus

    elseif  event.phase == "submitted" then
         
         native.setKeyboardFocus( nil )
        -- do something with defaulField's text

    elseif event.phase == "editing" then
     
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( " last text".. event.text )
      passwordText=event.startPosition
            password = passwordField.text
      
    end
end
end





-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "4: enterScene event" )

	storyboard.purgeScene( "forgotpassword" )
	--text3.isVisible = true
	-- remove previous scene's view
	--storyboard.purgeScene( "scene3" )
	
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