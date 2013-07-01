package com.smartbuzz.appkeyz;

public class AKUser {
	protected  String userNameFirst,userNameLast,userEmail,userPassword,latitude,longitude,uniqueId,deviceId,gender,age,custom1,custom2,
	custom3,custom4,custom5,custom6	;

	protected Boolean active,didNotRegister,isLoggedIn;
	
	public void AKUser() {
	    this.userNameFirst = "";
	    this.userNameLast = "";
	    this.userEmail = "";
	    this.userPassword = "";
	    this.uniqueId = "";
	    this.isLoggedIn = false;
	    this.latitude = "";
	    this.longitude = "";
	    this.active = false;
	    this.didNotRegister = false;
	    this.deviceId = "";
	    this.gender = "";
	    this.age = "";
	    this.custom1 = this.custom2 = this.custom3 = this.custom4 = this.custom5 = this.custom6 = "";
	}

}
