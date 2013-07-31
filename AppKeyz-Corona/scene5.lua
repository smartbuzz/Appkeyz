---------------------------------------------------------------------------------
--
-- scene5.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
-- Require the widget library
local widget = require( "widget" )

local image
local closeBtn

local buttonHandlerClose = function( event )
storyboard.gotoScene( "scene1", "fade", 800  )

end

-- Called when the scene's view does not exist:
function scene:createScene( event )
local screenGroup = self.view
 
	image = display.newImage( "signupImage.png" )
	screenGroup:insert( image )
	image.touch = onSceneTouch
   
   closeBtn = widget.newButton
{
	defaultFile = "closeBtn.png",
	overFile = "closeBtn.png",
	label = " ",
	emboss = true,
   onRelease = buttonHandlerClose,
}
closeBtn.x = 160; closeBtn.y = 360
screenGroup:insert( closeBtn )
end





-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "4: enterScene event" )

	
	--text3.isVisible = true
	-- remove previous scene's view
	--storyboard.purgeScene( "scene1" )
	
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