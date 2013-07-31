---------------------------------------------------------------------------------
--
-- scene4.lua
--Create Account 
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
local firstNameField 
local lastNameField
local emailField
local passwordField
local agefield
local genderfield
local FirstNameLbl , LastNameLbl , EmailLbl , PasswordLbl , ageLbl, genderLbl  
local backBtn
local navHeader
local navBar
local createAC
 local alert
local  firstnametxt ,lastnametxt,emailtxt,passwordtxt;
firstnametxt = 0
lastnametxt=0 
emailtxt=0 
passwordtxt=0
local FirstNameTxt,LastNameTxt,EmailTxt,PasswordTxt,AgeTxt,GenderTxt;


local function onAlert( event )
	print("pressed button 1")
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
        	print("pressed button "..i)
        	native.cancelAlert( alert )
            -- Do nothing; dialog will simply dismiss
        elseif 2 == i then
            -- Open URL if "Learn More" (the 2nd button) was clicked
            
        end
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
          print (" Error " ..jsonTable.error) ;
          local error =jsonTable.error;
          print (" error:- " ..error ) ;
          if  error  == 0 then
          	
          	  alert  = native.showAlert( "Appkeyz Sample Application says:", "user account retrevied successfully. ", { "OK" })
          	    _G.email=EmailTxt;
           _G.password=PasswordTxt;
          	  storyboard.gotoScene( "groupTable", "slideLeft", 800)
           elseif error  == 1 then
              alert  = native.showAlert( "The email you created is not formatted properly", "please try again. ", { "OK" } )
          elseif error  == 3 then
               alert = native.showAlert( "Uniqueid has already been taken within the scope of this app", "please try again. ", { "OK" } )   
        elseif error  == 3 then
               alert = native.showAlert( "This username already exists", "please try again. ", { "OK" }  )  
        end
         
       
          
    end

    return true
end
  
------------------------**********************************************------------------






local buttonHandlerBackBTN = function( event )
      print("back button released")
      
    --storyboard.gotoScene( "scene2", "slideUp", 800  )
storyboard.gotoScene( "scene1","slideLeft", 1000 )
end
  
local buttonHandlercreatAC = function( event )
	
    if firstnametxt  == 1  or  lastnametxt ==1 or emailtxt  == 1   or passwordtxt ==1 and firstnametxt  == 0  or  lastnametxt == 0 or emailtxt  == 0  or  passwordtxt == 0 then
    	--elseif event.phase == "ended" or event.phase == "submitted" then
          alert = native.showAlert( "Invalid ? ", "Please file all field . ", { "OK" } );
        timer.performWithDelay( 10000, cancelAlert )
      elseif passwordtxt < 6 then  
      alert  = native.showAlert( "Passwords Too Short", "Password must be at least 6 characters. ", { "OK" } )
  
    else
    --
    local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=createuser&apptoken=ci48xk6m&email="..(emailField.text).."&password="..(passwordField.text).."&firstname="..(firstNameField.text).."&lastname="..(lastNameField.text).."&age="..(agefield.text).."&sex="..(genderfield.text).."&uniqueid="..(_G.newUdId)
   
   -- DEBUG: Show constructed url
       print ( "Remote URL: " .. URL )
       	                native.setActivityIndicator( true )
       timer.performWithDelay( 1000, 
		function() native.setActivityIndicator( false ) end 
	)
       network.request( URL, "GET", loginCallback ) 
   
    end
   
end





-- Called when the scene's view does not exist:
function scene:createScene( event )
local screenGroup =self.view
	  --display.setDefault( "background", 158, 158, 158 )
	image = display.newImage( "Default.png" )
	screenGroup:insert( image )
	
image.touch = onSceneTouch
    navBar = display.newImage("navBar.png", 0, 0, true)
   navBar.x = display.contentWidth*.5
    navBar.y = math.floor(display.screenOriginY + navBar.height*0.5)
     navHeader = display.newText(" Create Account ", 0, 0, native.systemFontBold, 16)
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
 createAC = widget.newButton
{
	defaultFile = "createAC.png",
	overFile = "createAC.png",
	--label = "Button 1 Label",
	--emboss = true,
	 top = 305,
    left = 10,
    onRelease = buttonHandlercreatAC,
}


backBtn.x =29; backBtn.y = navBar.y
screenGroup:insert( backBtn )


screenGroup:insert( createAC )
-- Create our Text Field
     FirstNameLbl = display.newText(" First Name :", 0, 0, native.systemFontBold, 14)
     FirstNameLbl.isVisible = true
    FirstNameLbl:setTextColor(255, 255, 255) 
     FirstNameLbl.x = 50
     FirstNameLbl.y =62
	screenGroup:insert( FirstNameLbl )

firstNameField = native.newTextField( 100, 49, 200, 25 )
firstNameField.inputType= "default "
firstNameField.font = native.newFont( native.systemFontBold, inputFontSize )
firstNameField:addEventListener( "userInput", firstNameField )
screenGroup:insert( firstNameField )

----Create our Text Field 
     LastNameLbl = display.newText(" Last Name :", 0, 0, native.systemFontBold, 14)
     LastNameLbl.isVisible = true
    LastNameLbl:setTextColor(255, 255, 255) 
     LastNameLbl.x = 50
     LastNameLbl.y = 95
	screenGroup:insert( LastNameLbl )
lastNameField= native.newTextField(100,85,200,25)
lastNameField.inputType= "default "
lastNameField.font = native.newFont( native.systemFontBold, inputFontSize )
lastNameField:addEventListener( "userInput", lastNameField )
screenGroup:insert( lastNameField )
----Create our Text Field 
     EmailLbl = display.newText(" Email :", 0, 0, native.systemFontBold, 14)
     EmailLbl.isVisible = true
    EmailLbl:setTextColor(255, 255, 255) 
     EmailLbl.x = 50
     EmailLbl.y = 134
	screenGroup:insert( EmailLbl )

emailField= native.newTextField(100,123,200,25)
emailField.inputType= "default "
emailField.font = native.newFont( native.systemFontBold, inputFontSize )
emailField:addEventListener( "userInput", emailField )
screenGroup:insert( emailField )
----Create our Text Field 
     PasswordLbl = display.newText("Password :", 0, 0, native.systemFontBold, 14)
     PasswordLbl.isVisible = true
    PasswordLbl:setTextColor(255, 255, 255) 
     PasswordLbl.x = 50
     PasswordLbl.y = 170
	screenGroup:insert( PasswordLbl )
	
passwordField= native.newTextField(100,160,200,25)
passwordField.inputType= "default "
passwordField.font = native.newFont( native.systemFontBold, inputFontSize )
passwordField:addEventListener( "userInput", passwordField )
 passwordField.isSecure = true
screenGroup:insert( passwordField )

----Create our Text Field 
     ageLbl = display.newText("Age :", 0, 0, native.systemFontBold, 14)
     ageLbl.isVisible = true
    ageLbl:setTextColor(255, 255, 255) 
     ageLbl.x = 50
     ageLbl.y = 210
	screenGroup:insert( ageLbl )

agefield= native.newTextField(100,200,200,25)
agefield.inputType= "number "

agefield.font = native.newFont( native.systemFontBold, inputFontSize )
agefield:addEventListener( "userInput", agefield )
 ---agefield.isSecure = true
screenGroup:insert( agefield )

----Create our Text Field 
     genderLbl = display.newText("Gender :", 0, 0, native.systemFontBold, 14)
     genderLbl.isVisible = true
    genderLbl:setTextColor(255, 255, 255) 
     genderLbl.x = 50
     genderLbl.y = 252
	screenGroup:insert(genderLbl )
	
genderfield= native.newTextField(100,237,200,25)
genderfield.inputType= "default "
genderfield.font = native.newFont( native.systemFontBold, inputFontSize )
genderfield:addEventListener( "userInput", genderfield )
 --agefield.isSecure = true
screenGroup:insert( genderfield )
---function of firstname text password text listener & email text field 
function firstNameField :userInput( e )
    if e.phase == "began" then

        -- user begins editing textField
        print( e.text )
     

    elseif e.phase == "ended" then
    
        -- textField/Box loses focus

    elseif  e.phase == "submitted" then
        
          native.setKeyboardFocus( lastNameField )
        -- do something with defaulField's text

    elseif e.phase == "editing" then
     
        print( e.newCharacters )
        print( e.oldText )
        print( e.startPosition )
        print( " last text".. e.text )
        firstnametxt =e.startPosition
    

    end
end
function lastNameField :userInput( e )
    if e.phase == "began" then

        -- user begins editing textField
        print( e.text )
     

    elseif e.phase == "ended" then
    
        -- textField/Box loses focus

    elseif  e.phase == "submitted" then
        
         native.setKeyboardFocus( emailField )
        -- do something with defaulField's text

    elseif e.phase == "editing" then
     
        print( e.newCharacters )
        print( e.oldText )
        print( e.startPosition )
        print( " last text".. e.text )
        lastnametxt =e.startPosition
      

    end
end
function emailField :userInput( e )
    if e.phase == "began" then

        -- user begins editing textField
        print( e.text )
                       

    elseif e.phase == "ended" then
    
        -- textField/Box loses focus

    elseif  e.phase == "submitted" then
        
       native.setKeyboardFocus( passwordField )
        -- do something with defaulField's text

    elseif e.phase == "editing" then
     
        print( e.newCharacters )
        print( e.oldText )
        print( e.startPosition )
        print( " last text".. e.text )
        emailtxt =e.startPosition
              EmailTxt =  emailField.text

    end
end
function passwordField :userInput( e )
    if e.phase == "began" then

        -- user begins editing textField
        print( e.text )
   -- screenGroup  = display.newRect( 0, 0, display.contentWidth, display.contentHeight+250-50 )

    elseif e.phase == "ended" then
    
        -- textField/Box loses focus

    elseif  e.phase == "submitted" then
        
         native.setKeyboardFocus( agefield )
        -- do something with defaulField's text

    elseif e.phase == "editing" then
     
        print( e.newCharacters )
        print( e.oldText )
        print( e.startPosition )
        print( " last text".. e.text )
        passwordtxt =e.startPosition
        PasswordTxt =  passwordField.text


    end
end
function agefield :userInput( e )
    if e.phase == "began" then

        -- user begins editing textField
        print( e.text )
     

    elseif e.phase == "ended" then
    
        -- textField/Box loses focus

    elseif  e.phase == "submitted" then
        
         
        -- do something with defaulField's text

    elseif e.phase == "editing" then
     
        print( e.newCharacters )
        print( e.oldText )
        print( e.startPosition )
        print( " last text".. e.text )
      
      


    end
end
function genderfield :userInput( e )
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
  
          --GenderTxt =  genderfield.text


    end
end
end
local listener = function( event )
	-- Hide keyboard  
	print("tap pressed")
	native.setKeyboardFocus( nil )

	
	return true
end




-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "4: enterScene event" )

	
	--text3.isVisible = true
	-- remove previous scene's view
	--storyboard.purgeScene( "scene1" )
	
end

function scene:exitScene()
	-- navHeader.isVisible = false
image:removeEventListener( "touch", image )
image:addEventListener( "tap", listener )
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