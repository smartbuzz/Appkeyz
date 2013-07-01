package com.smartbuzz.appkeyz;

import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.text.Html;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class MainActivity  extends Activity implements OnClickListener {
	
	public static boolean  noThanks_yes =false;
	TextView helpTextView;
	Button helpButton,btnLogin,btnRegister;
	RelativeLayout helpReltaiveView;
	String Tag = "MainActivity";
	Dialog type_dilog;
	TextView body_dialog;
	Button close,noThanks;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_main);
		Log.e(Tag, "onCreate---");
		
		helpTextView = (TextView) findViewById(R.id.helpTextView);
		helpButton = (Button) findViewById(R.id.btnSignUpHelp);
		btnLogin = (Button) findViewById(R.id.btnLogin);
		btnRegister = (Button)findViewById(R.id.btnRegister);
		helpReltaiveView = (RelativeLayout) findViewById(R.id.helpReltaiveView);
		noThanks = (Button)findViewById(R.id.btnNoThanks);
		helpButton.setOnClickListener(this);
		btnRegister.setOnClickListener(this);
		btnLogin.setOnClickListener(this);
		noThanks.setOnClickListener(this);
	}
	public void onClick(View v) {
		// TODO Auto-generated method stub
		Log.i("Event =", "Button Pressed");

		switch (v.getId()) {
			case R.id.btnSignUpHelp:
				 type_dilog = new Dialog(MainActivity.this);
				 
				 type_dilog.setContentView(R.layout.customdialog1);
				 type_dilog.setTitle(" Why Should I sign up? ");
				 
			    		    
			     body_dialog = (TextView) type_dilog.findViewById(R.id.capture);
		         close = (Button) type_dilog.findViewById(R.id.no_thanks);
		       			       			        
		         body_dialog.setLayoutParams(new LinearLayout.LayoutParams(
		          LinearLayout.LayoutParams.FILL_PARENT,
		          LinearLayout.LayoutParams.WRAP_CONTENT));
		         
		         close.setLayoutParams(new LinearLayout.LayoutParams(
		          LinearLayout.LayoutParams.FILL_PARENT,
		          LinearLayout.LayoutParams.WRAP_CONTENT));
		            
		         body_dialog.setText(R.string.sign_up_help);
		         close.setText("Close");
		     
		        type_dilog.show();
				close.setOnClickListener(new OnClickListener() {
					
					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
					type_dilog.dismiss();	
					}
				});
								
		//	helpReltaiveView.setVisibility(View.VISIBLE);
			break;
			case R.id.btnRegister:
				startActivity(new Intent(MainActivity.this,RegisterActivity.class));
			break;
			case R.id.btnLogin:
				startActivity(new Intent(MainActivity.this,LoginActivity.class));
			break;
			case R.id.btnNoThanks:
				buildAlertMessageNoGps();
		}
	}
	public void buildAlertMessageNoGps() {
    final AlertDialog.Builder builder = new AlertDialog.Builder(this);
    builder.setMessage(Html.fromHtml("<b>"+"Are you sure cancel sign up?"+"</b>"))
    //Html.fromHtml("Are you sure "+"<b>"+"\nCancle sign up?"+"</b>")   
    .setCancelable(false)
           .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
               public void onClick(@SuppressWarnings("unused") final DialogInterface dialog, @SuppressWarnings("unused") final int id) {
                  // startActivity(new Intent(android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS));
            	   noThanks_yes = true;
            	   startActivity(new Intent(MainActivity.this,AppkeyzActivity.class));
               
               }
           })
           .setNegativeButton("No", new DialogInterface.OnClickListener() {
               public void onClick(final DialogInterface dialog, @SuppressWarnings("unused") final int id) {
                    dialog.cancel();
               }
           });
    final AlertDialog alert = builder.create();
    alert.show();
}
}
