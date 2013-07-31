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

local forgotField
local backBtn
local navHeader,headertext,lbltxt
local navBar
local  forgotText
         forgotText = 0;
local alert 

local function forgotCallback(event)
   -- perform basic error handling

    if ( event.isError ) then
        print( "Network error!")
    else
        local json = event.response ;
        print (" event.response :- " ..event.response ) ;
          local length=string.len ( json );
           jsonTable = JSON.decode( json ) ;
            local error =jsonTable.error;
          print (" error:- " ..error ) 
           if  error  == 0 then
          	storyboard.gotoScene(  "secene1", "fade", 800)
               alert = native.showAlert( "Appkeyz Sample Application says:", "user account retrevied successfully. ", { "OK" }, onComplete )
        
             elseif  jsonTable.error  == 1 then
               alert = native.showAlert( "The email you created is not formatted properly", "please try again. ", { "OK" }, onComplete )
                 elseif   error   == 2 then
               alert = native.showAlert( "This Email does not does exist in our system", "please Register or log in using a different email", { "OK" }, onComplete )
        end
         native.cancelAlert( alert )	
    end

    return true
end


--buttonHandlersendEmail
local buttonHandlerBackBTN = function( event )
    print("back button released")
storyboard.gotoScene( "scene2","slideLeft", 1000 )
end

local buttonHandlersendEmail = function( event )
	if forgotText==0 or forgotText==1 then
      alert = native.showAlert( "Error !", "Please file the email. ", { "OK" }, onComplete )
	 else
   local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=forgotpassword&apptoken=ci48xk6m&email=" ..(forgotField.text)
   -- DEBUG: Show constructed url
       print ( "Remote URL: " .. URL )
       network.request( URL, "GET", forgotCallback ) 
	end
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
     navHeader = display.newText(" FOROGOT PASSWORD ", 0, 0, native.systemFontBold, 16)
     navHeader.isVisible = true
    navHeader:setTextColor(255, 255, 255) 
navHeader.x = display.contentWidth*.5
navHeader.y = navBar.y
 screenGroup:insert( navBar )
 screenGroup:insert( navHeader )
 
headertext = display.newText(" Forgot Password ? ", 0, 0, native.systemFontBold, 16)
headertext.isVisible = true
headertext:setTextColor(255, 255, 255) 
headertext.x = display.contentWidth*.5
headertext.y = 60
screenGroup:insert( headertext )

 
lbltxt = display.newText(" Enter email to recieve  password  reset instructions ",20,75,300,150, native.systemFontBold, 16)
lbltxt.isVisible = true
lbltxt:setTextColor(255, 255, 255) 
--headertext.x = display.contentWidth*.5
--headertext.y = 90
screenGroup:insert( lbltxt )

 backBtn = widget.newButton{ 
        
        	defaultFile = "backButton.png",
	      overFile = "backButton.png",
	      emboss = true,
   onRelease = buttonHandlerBackBTN,
}


 OkBtn = widget.newButton
{
	defaultFile = "OkBtn.png",
	overFile = "OkBtn.png",
	--label = "Button 1 Label",
	emboss = true,
    onRelease = buttonHandlersendEmail,
}
backBtn.x =29; backBtn.y = navBar.y
screenGroup:insert( backBtn )
OkBtn.x = 160; OkBtn.y = 230
screenGroup:insert( OkBtn )

----Create our Text Field 
forgotField= native.newTextField(20,140,280,30)
forgotField.font = native.newFont( native.systemFontBold, inputFontSize )
forgotField.inputType= "default "
forgotField:addEventListener( "userInput", forgotField )

screenGroup:insert( forgotField )

---function of password text listener & email text field 
function forgotField :userInput( e )
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
        forgotText =e.startPosition
     

    end
end
end





-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "4: enterScene event" )

	
	--text3.isVisible = true
	-- remove previous scene's view
storyboard.purgeScene( "scene2" )
	storyboard.purgeScene( "scene3" )
	
end

function scene:exitScene()
	-- navHeader.isVisible = false
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