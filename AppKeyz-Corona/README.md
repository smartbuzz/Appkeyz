AppKeyz SDK for Corona SDK
============

This SDK is designed to allow a developer to easily add either the AppKeyz API by itself, or a suite also containing a "drop-in" authentication module.

This repository is a sample app that demonstrates all API calls as well as the authentication. Authentication module works on Android Device & iPhone in potrait.

The AppKeyz SDK requires  Corona 

Installation
------------

###Installing ONLY the API Library
------
Add main.lua  to your <Application Name>- scene1.lua file:scene1.lua is home view in Appkeyz



String apptoken == "ci48xk6m"; //REPLACE WITH YOUR APP TOKEN
```


### Installing the AppKeyz Suite with authentication module
------

```

In order to use the authentication module, add this code inside the 'Create User' method of your scene4.lua controller:

String firstName, lastName, sex, age, email_Id,
String BASE_URL = "https://www.appkeyz.com/mobileapp/appkeyzapi/";`

The 'setRegisterFields' method sets optional registeration fields (Age, Gender and six custom fields). The method is required but can be set as an empty array:



``
------ scene4.lua 

    local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=createuser&apptoken=ci48xk6m&email="..(emailField.text).."&password="..(passwordField.text).."&firstname="..(firstNameField.text).."&lastname="..(lastNameField.text).."&age="..(agefield.text).."&sex="..(genderfield.text).."&uniqueid="..(_G.newUdId) ```

You can capture callbacks from the API inside 'consumeResponse':

`lua'
          if  error  == 0 then          	          	  alert  = native.showAlert( "Appkeyz Sample Application says:", "user account retrevied successfully. ", { "OK" })          	    _G.email=EmailTxt;           _G.password=PasswordTxt;          	  storyboard.gotoScene( "groupTable", "slideLeft", 800)           elseif error  == 1 then              alert  = native.showAlert( "The email you created is not formatted properly", "please try again. ", { "OK" } )          elseif error  == 3 then               alert = native.showAlert( "Uniqueid has already been taken within the scope of this app", "please try again. ", { "OK" } )           elseif error  == 3 then               alert = native.showAlert( "This username already exists", "please try again. ", { "OK" }  )          end
```

####A Note about AlertViews:
In the consumeResponse method, each command has a place for the developer to capture returned values (in the if of error ==0) and set AlertView messages. By default, you must set the success message (0). The server returns it's own message for error ==1,2,3,4,5 of 100. Feel free to set your own message. You may set 'message' to nil to prevent the AlertView from showing at all.

##Using Grouptable.lua 
it is show  the table 
  when tapped any row  function we called 
     ----for  readpurchase row 	     elseif row.index==7 then	       local URL = "https://www.appkeyz.com/mobileapp/appkeyzapi?apiaction=readpurchase&apptoken=ci48xk6m&email="..(_G.email) .. "&password=" ..(_G.password).."&purchaseid="..(_G.purchaseid)	        print(url);	                native.setActivityIndicator( true )       timer.performWithDelay( 1000, 		function() native.setActivityIndicator( false ) end 	)
----show alert message 
local function purchaseid(event)   -- perform basic error handling    if ( event.isError ) then        print( "Network error!")    else        local json = event.response ;        print (" event.response purchaseid :- " ..event.response ) ;          local length=string.len ( json );           jsonTable = JSON.decode( json ) ;        --  print (" FirstName " ..jsonTable.firstname ) ;          local error =jsonTable.error;                    print (" error:- " ..error ) ;                 if jsonTable.error  == 0 then           _G.productsku=jsonTable.productsku;            _G.purchaseprice=jsonTable.purchaseprice;            _G.productname=jsonTable.productname;            _G.active=jsonTable.active;            _G.consumableid=jsonTable.consumableid;            _G.expiration=jsonTable.expiration;              elseif jsonTable.error  == 1 then               alert = native.showAlert( "Bad Parameters.", " Usually means you are missing apiaction or apptoken", { "OK" } )               elseif jsonTable.error  == 3 then               alert = native.showAlert( "This Email does not does exist in our system.", " please Register or log in using a different email", { "OK" })                           elseif jsonTable.error  == 4 then               alert = native.showAlert( "Invalid Purchase.", " Please try again.", { "OK" } )            end           -- _G.firstname = jsonTable.firstname;      end    return trueend
###Using the scene2.lua ,secen3.lua and secen4.lua  
------


If you follow the setup steps, your activity will present a set of 'login or register' screens that will capture login or register details from the user and register them with the AppKeyz server, then save the details to an  Global variable .

The login screen will work for any iPhone && Android device. However, it is recommended that the screens only be used in one orientation, as the background image will distort when the screen rotates.

#### Note: We've recently added an alertview to popup if a user isn't already registered or logged in, to give the user a chance to login or register before a potential purchase. You may choose whether or not to use it. It can simply be removed from createPurchase.

------
This document &copy; 2013 AppKeyz, Inc.
