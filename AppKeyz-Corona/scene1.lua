---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-- Require the widget library
local widget = require( "widget" )
---Declare  Button 
local loginBTN
local createAC
local alert

-- Handler that gets notified when the alert closes
local function onComplete( event )
	print( "index => ".. event.index .. "    action => " .. event.action )

	local action = event.action
	if "clicked" == event.action then
		if 2 == event.index then
			-- Open url if "Learn More" was clicked by the user
			
			storyboard.gotoScene( "groupTable", "fade", 800  )
		end
	elseif "cancelled" == event.action then

   
		-- our cancelAlert timer function dismissed the alert so do nothing
	end
end

-- Touch event listener for background image


local buttonHandlerLogin = function( event )
storyboard.gotoScene( "scene2", "slideLeft", 800  )

end
local buttonHandlercreatAC = function( event )
storyboard.gotoScene( "scene4", "slideLeft", 800  )
	--loginBTN:removeSelf()  
	
end

local  buttonHandlersignUP = function( event )
storyboard.gotoScene( "scene5", "fade", 800  )
end

local  buttonHandlernoThankSBTN = function( event )
	alert = native.showAlert( "Are you sure?", "Cancel sign up?", { "NO", "YES" }, onComplete )

end
-- Dismisses alert after 10 seconds
local function cancelAlert()
	native.cancelAlert( alert )
end
--timer.performWithDelay( 10000, cancelAlert )

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	image = display.newImage( "Default.png" )
	screenGroup:insert( image )
	--image.touch = onSceneTouch
	
loginBTN = widget.newButton
{
	defaultFile = "login1.png",
	overFile = "login1.png",
	label = " ",
	emboss = true,
   onEvent = buttonHandlerLogin,
}
 createAC = widget.newButton
{
	defaultFile = "createAC.png",
	overFile = "createAC.png",
	--label = "Button 1 Label",
	emboss = true,
    onEvent = buttonHandlercreatAC,
}

local signUPBtn = widget.newButton
{
	defaultFile = "signUP.png",
	overFile = "signUP.png",
	--label = "Button 1 Label",
	emboss = true,
    onEvent = buttonHandlersignUP,
}

local noThankSBTN = widget.newButton
{
	defaultFile = "thanks.png",
	overFile = "thanks.png",
	--label = "Button 1 Label",
	emboss = true,
   onRelease = buttonHandlernoThankSBTN,
}
 screenGroup:insert( loginBTN )
 screenGroup:insert( createAC )
 screenGroup:insert( signUPBtn )
 screenGroup:insert( noThankSBTN )
 loginBTN.x = 160; loginBTN.y = 296
 createAC.x = 160; createAC.y = 340
 signUPBtn.x = 160; signUPBtn.y = 400
 noThankSBTN.x = 160; noThankSBTN.y = 430
	print( "\n1: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "1: enterScene event" )
		--image:removeEventListener( "touch", image )
	-- remove previous scene's view
    storyboard.purgeScene( "scene2" )
	storyboard.purgeScene( "scene4" )
	--storyboard.purgeScene( "scene6" )

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 1's view))" )
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