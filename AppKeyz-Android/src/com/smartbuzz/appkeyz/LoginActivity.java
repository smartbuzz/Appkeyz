package com.smartbuzz.appkeyz;

import java.util.HashMap;

import org.json.*;
import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class LoginActivity extends Activity implements OnClickListener {
	Button btnLogin, btnForgetpassword,btnlogin_app;
	EditText email, password;
	String Tag = "LoginActivity";
	Context context = LoginActivity.this;
	public static String firstName, lastName, sex, age, email_Id,
			password_response;
	JSONObject rr;
//	public static boolean or_b = false;
	//TextView or;
  Context cc;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.login);
		Log.e(Tag, "onCreate---");
		btnLogin = (Button) findViewById(R.id.btnLogin);
		btnLogin.setOnClickListener(this);

		btnForgetpassword = (Button) findViewById(R.id.btnForgetpassword);
	//	btnlogin_app = (Button)findViewById(R.id.btnlogin_app);
	//	btnlogin_app.setOnClickListener(this);
		btnForgetpassword.setOnClickListener(this);
		email = (EditText) findViewById(R.id.fieldEmail);
		password = (EditText) findViewById(R.id.fieldPassword);
	//	or =(TextView)findViewById(R.id.or);
	/*	if(or_b)
		{
			or.setVisibility(View.GONE);
			or_b = false;
		}*/
		
	}

	public void loginAction() {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "readuser");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email.getText().toString());
		paramMap.put("password", password.getText().toString());
		AppKeyz.postData(paramMap, this, "LN", "Validating...");
		
	}

	public static void callback(JSONObject response, Context c) {

		try {

			Log.e(" Login", "Response AA--- :" + response);
			Log.e("Callback Login", "Response :" + response.get("error"));
			int error = Integer.parseInt(response.getString("error"));
			Log.e("WWWWW","SSS error = "+error);
		
			if (error == 0) {
				// AppKeyz.alert("User account retreived successfully.");
				// todo
				firstName = response.get("firstname").toString();
				lastName = response.get("lastname").toString();
				age = response.get("age").toString();
				sex = response.get("sex").toString();
				email_Id = response.get("email").toString();
				password_response = response.get("password").toString();

				Log.e(" Login", "firstName :" + firstName);

				Intent it = new Intent(c, AppkeyzActivity.class);
				c.startActivity(it);

			}
			else if(error == 2)
			{
				AppKeyz.alert("Email id is Not Registered login with valid id");
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
		case R.id.btnLogin:
			if (email.getText().toString()
					.matches("[a-zA-Z0-9._-]+@[a-z]+.[a-z]+")
					|| email.getText().toString()
							.matches("[a-zA-Z0-9._-]+@[a-z]+.[a-z]+.[a-z]+")) {
				if (password.getText().toString().length() != 0) {
					loginAction();
				} else {
					new Alerts(context, "Please Enter Password");
				}
			} else {
				new Alerts(context, "Please Enter Valid Email id");
			}

			break;
		case R.id.btnForgetpassword:
			forgetPassword();
			break;
//		case R.id.btnlogin_app:
//			or_b = true;
//			startActivity(new Intent(LoginActivity.this,LoginActivity.class));
		}
	}
	public void forgetPassword() {
		final AlertDialog.Builder alert = new AlertDialog.Builder(this);
		final EditText input = new EditText(this);
		input.setHint("Email");
		alert.setView(input);
		alert.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int whichButton) {
				String value = input.getText().toString().trim();
				if (value.matches("[a-zA-Z0-9._-]+@[a-z]+.[a-z]+")
						|| email.getText()
								.toString()
								.matches("[a-zA-Z0-9._-]+@[a-z]+.[a-z]+.[a-z]+")) {
					Intent email = new Intent(android.content.Intent.ACTION_SEND);
					email.putExtra(Intent.EXTRA_EMAIL, new String[] { value });
					email.putExtra(Intent.EXTRA_SUBJECT,
							"A message from the App key ");
					email.putExtra(Intent.EXTRA_TEXT, "Message Text");
					email.setType("message/rfc822");
					startActivity(Intent.createChooser(email,
							"Choose an Email client :"));
					Toast.makeText(getApplicationContext(), "Mail send to:-"+value,
							Toast.LENGTH_SHORT).show();
				} else {
					new Alerts(context, "Please fill valid Email Id");
				}

			}
		});

		alert.setNegativeButton("Cancel",
				new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int whichButton) {
						dialog.cancel();
					}
				});
		alert.show();
	}
}
