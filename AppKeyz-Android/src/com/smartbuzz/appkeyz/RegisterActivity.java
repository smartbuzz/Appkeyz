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
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class RegisterActivity extends Activity implements OnClickListener {
	Button btnRegister;
	EditText fName,lName,age,gender,password,email;
    String Tag = "Registeractivity";
	Context context = RegisterActivity.this;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.register);
		Log.e(Tag, "onCreate---");
		
		btnRegister = (Button) findViewById(R.id.btnRegister);

		btnRegister.setOnClickListener(this);
		fName = (EditText) findViewById(R.id.fieldFirstName);
		lName = (EditText) findViewById(R.id.fieldLastName);
		age = (EditText) findViewById(R.id.fieldAge);
		gender = (EditText) findViewById(R.id.fieldGender);
		email = (EditText) findViewById(R.id.fieldEmail);
		password = (EditText) findViewById(R.id.fieldPassword);
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
		double longitude = 1.2222;// location.getLongitude();
		double latitude = 2.33333;// location.getLatitude();
		
		if (fName.getText().toString().length()!=0){
			
		if (email.getText().toString().matches("[a-zA-Z0-9._-]+@[a-z]+.[a-z]+")
				|| email.getText()
						.toString()
						.matches("[a-zA-Z0-9._-]+@[a-z]+.[a-z]+.[a-z]+"))
		{
			if(password.getText().toString().length()!=0)
			{
				HashMap<String, String> paramMap = new HashMap<String, String>();
				
				paramMap.put("apiaction", "createuser");
				paramMap.put("apptoken",AppUtils.APP_TOKEN);
				paramMap.put("email", email.getText().toString());
				paramMap.put("password",password.getText().toString());
				paramMap.put("firstname",fName.getText().toString());
				paramMap.put("lastname",lName.getText().toString());
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
				AppKeyz.postData(paramMap,this,"RG","Validating...");	
			
			}
			else
			{
				new Alerts(context, "Please Fill Password ");
			}
			
		}
		else 
		{
			new Alerts(context, "Fill Email id ");
		}
		}else 
		{
			new Alerts(context, "Enter First Name ");
		}
	}
	public void editUserAction() {

		LocationManager lm = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
		Location location = lm
				.getLastKnownLocation(LocationManager.GPS_PROVIDER);
		if (location != null) {
			Log.e("Location", "Lat= " + location.getLatitude() );
		}
		
		double longitude = 1.2222;// location.getLongitude();
		double latitude = 2.33333;// location.getLatitude();

		HashMap<String, String> paramMap = new HashMap<String, String>();
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
				Intent it = new Intent(c, AppkeyzActivity.class);
				c.startActivity(it);
			}
			else if(error ==1)
			{
				AppKeyz.alert("Password is not well formated--");
			}
			else {
				AppKeyz.alert(response.getString("debug"));
				
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
	}
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()) {
		case R.id.btnRegister:
			registerAction();
			break;
		}
	}
}
