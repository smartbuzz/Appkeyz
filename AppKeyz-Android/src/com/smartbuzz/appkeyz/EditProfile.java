package com.smartbuzz.appkeyz;

import java.util.HashMap;
import java.util.UUID;

import org.json.JSONException;
import org.json.JSONObject;

import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class EditProfile extends Activity implements OnClickListener {
	EditText fName,lName,age,gender,password,email;
	Button btnRegister;
	String Tag = "EditProfile";
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.edit_account);

		Log.e(Tag, "onCreate--");
		btnRegister = (Button) findViewById(R.id.btnRegister_edit);

		btnRegister.setOnClickListener(this);
		
		fName = (EditText) findViewById(R.id.fieldFirstName_edit);
		lName = (EditText) findViewById(R.id.fieldLastName_edit);
		age = (EditText) findViewById(R.id.fieldAge_edit);
		gender = (EditText) findViewById(R.id.fieldGender_edit);
		email = (EditText) findViewById(R.id.fieldEmail_edit);
		password = (EditText) findViewById(R.id.fieldPassword_edit);
			
		fName.setText(LoginActivity.firstName);
		lName.setText(LoginActivity.lastName);
		age.setText(LoginActivity.age);
		email.setText(LoginActivity.email_Id);
		gender.setText(LoginActivity.sex);
		password.setText(LoginActivity.password_response);
	}
	public void registerAction() {

		UUID uniqueKey = UUID.randomUUID();
		LocationManager lm = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
		Location location = lm
				.getLastKnownLocation(LocationManager.GPS_PROVIDER);
		if (location != null) {
			Log.e("Location", "Lat= " + location.getLatitude() + "undiw="
					+ uniqueKey);
		}
		
		Log.e("uniqueKey", "uniqueKey= " + uniqueKey);
		LocationManager lm1 = (LocationManager)getSystemService(Context.LOCATION_SERVICE); 
        Location location1 = lm1.getLastKnownLocation(LocationManager.GPS_PROVIDER);
//        double longitude = location1.getLongitude();
//        double latitude = location1.getLatitude();
//				
		
		double longitude = 1.2222;// location.getLongitude();
		double latitude = 2.33333;// location.getLatitude();

		Log.e("Longitude=",""+longitude);
		Log.e("Longitude=",""+latitude);
		
		
		HashMap<String, String>paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "updateuser");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email.getText().toString());
		paramMap.put("password", password.getText().toString());
		paramMap.put("firstname", fName.getText().toString());
		paramMap.put("lastname", lName.getText().toString());
		paramMap.put("latitude", "" + latitude);
		paramMap.put("longitude", "" + longitude);
		paramMap.put("age", age.getText().toString());
		paramMap.put("sex", gender.getText().toString());
		paramMap.put("custom1", "");
		paramMap.put("custom1", "");
		paramMap.put("custom1", "");
		paramMap.put("custom1", "");
		paramMap.put("custom1", "");
		paramMap.put("custom1", "");
		paramMap.put("active", "");
		paramMap.put("uniqueid", "" + uniqueKey);
	//	AppKeyz.postData(paramMap,this,"RG","Validating...");
		AppKeyz.postData(paramMap,this,"UU","Updating user...");	
	}
	
	public static  void callback(JSONObject response,Context c) {
		try {
			Log.e("Callback Register","Response :" + response.get("error"));
			int error = Integer.parseInt(response.getString("error"));
			
			if( error == 0) {
				//AppKeyz.alert("User created successfully.");
				//
				//todo
			} else {
				AppKeyz.alert(response.getString("debug"));
				
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Intent it = new Intent(c, AppkeyzActivity.class);
		c.startActivity(it);
		
	}
	
	
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		
		switch (v.getId()) {
		case R.id.btnRegister_edit:
			registerAction();
			break;
		}
	}

}
