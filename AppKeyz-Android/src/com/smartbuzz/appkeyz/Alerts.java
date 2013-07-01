package com.smartbuzz.appkeyz;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

/**This class used for single option alerts i.e. 
 * there is only one button available.
 * This helps to reduce redundancy of code
*/

public class Alerts {
Context context;
AlertDialog.Builder alert;

//Constructor to get current object 
//of class and message to display
public Alerts(Context cxt, String message)
{
	this.context = cxt;
	
	alert=new AlertDialog.Builder(context);
	alert.setMessage(message)
		 .setNeutralButton("OK", new DialogInterface.OnClickListener() {
				
				@Override
				public void onClick(DialogInterface dialog, int which) {
								     
				}
	}).show();
	
}
	
}
