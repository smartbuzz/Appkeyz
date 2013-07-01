package com.smartbuzz.appkeyz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.Bundle;
import android.provider.Settings.Secure;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;

public class AppkeyzActivity extends Activity implements OnClickListener {
	Button createPurchase, listPurchase, listConsuable, readPurchase,
			updatePurchase, deactivatePurchase, readConsuable,
			udpdateConsuable, logout, edit_Profil, createDevice, listDevice,
			readDevice, updateDevice, deleteDevice;
	String email = "testuser@test.com";
	String password = "test";
	Context contaxt = AppkeyzActivity.this;
	String device_id;
	int deviceIndex;
	String Tag = "AppkeyzActivity";

	Dialog type_dilog;
	
	AlertDialog.Builder builder;
	AlertDialog alertDialog;

	
	TextView body_dialog;
	Button login_dialog, cAccount_dialog, noThanks_dialog;
	String deviceId, deviceIp, deviceToken;

	static ArrayList<Map> productList = new ArrayList<Map>();
	static ArrayList<Map> consuableList = new ArrayList<Map>();
	static ArrayList<Map> deviceList = new ArrayList<Map>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.appkeys);
		Log.e(Tag, "onCreate---");
		
		//********Hiding Title Bar in Dialog ***********************
		type_dilog = new Dialog(contaxt);
		type_dilog.requestWindowFeature(Window.FEATURE_NO_TITLE);
		//**************************************************************
				
		// ********Getting Device ID**********
		device_id = Secure.getString(contaxt.getContentResolver(),
				Secure.ANDROID_ID);
		Log.e(Tag, "Device ID = " + device_id);
		/*********************************************************************/

		createPurchase = (Button) findViewById(R.id.createPurchase);
		createPurchase.setOnClickListener(this);

		listPurchase = (Button) findViewById(R.id.listPurchase);
		listPurchase.setOnClickListener(this);

		listConsuable = (Button) findViewById(R.id.listConsuable);
		listConsuable.setOnClickListener(this);

		readPurchase = (Button) findViewById(R.id.readPurchase);
		readPurchase.setOnClickListener(this);

		updatePurchase = (Button) findViewById(R.id.updatePurchase);
		updatePurchase.setOnClickListener(this);

		deactivatePurchase = (Button) findViewById(R.id.deactivatePurchase);
		deactivatePurchase.setOnClickListener(this);

		readConsuable = (Button) findViewById(R.id.readConsuable);
		readConsuable.setOnClickListener(this);

		udpdateConsuable = (Button) findViewById(R.id.udpdateConsuable);
		udpdateConsuable.setOnClickListener(this);

		logout = (Button) findViewById(R.id.logout);
		logout.setOnClickListener(this);

		edit_Profil = (Button) findViewById(R.id.btnEditProfil);
		edit_Profil.setOnClickListener(this);

		/******************************************************************************************************/
		// ********Device Action ***********Created by **Arun************
		// ****Create Device**********
		createDevice = (Button) findViewById(R.id.createDevice);
		createDevice.setOnClickListener(this);
		// ******List Device***********
		listDevice = (Button) findViewById(R.id.listDevice);
		listDevice.setOnClickListener(this);
		// ****Read Device**********
		readDevice = (Button) findViewById(R.id.readDevice);
		readDevice.setOnClickListener(this);
		// ****Update Device************
		updateDevice = (Button) findViewById(R.id.updateDevice);
		updateDevice.setOnClickListener(this);
		// *****Delete Device************
		deleteDevice = (Button) findViewById(R.id.deleteDevice);
		deleteDevice.setOnClickListener(this);

		/******************************************************************************************************/
	}

	public void createPurchaserWithEmail() {
		Random r = new Random();
		int x = r.nextInt(3 - 0);
		Log.e("NUM", "=" + x);
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "createpurchase");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);

		switch (x) {
		case 0:

			paramMap.put("productsku", "appkeyztest1");
			paramMap.put("purchaseprice", String.valueOf(-1));
			paramMap.put("balance", String.valueOf(-1));
			paramMap.put("expiration", "");

			break;
		case 1:

			paramMap.put("productsku", "appkeyztest2");
			paramMap.put("purchaseprice", String.valueOf(-1));
			paramMap.put("balance", String.valueOf(-1));
			paramMap.put("expiration", "");

			break;
		case 2:

			paramMap.put("productsku", "appkeyztest3");
			paramMap.put("purchaseprice", String.valueOf(-1));
			paramMap.put("balance", String.valueOf(-1));
			paramMap.put("expiration", "");

			// /[appKeyz createPurchaseWithEmail:testEmail password:testPassword
			// productSku:@"appkeyztest3" purchasePrice:-1 balance:-1
			// expiration:@""];
			break;
		}

		AppKeyz.postData(paramMap, this, "CP", "Creating Purchase...");

	}

	public void listpurchasesWithEmail() {

		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "listpurchases");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		AppKeyz.postData(paramMap, this, "LP", "Fetching Lists...");
	}

	public void readpurchaseWithEmail(int purAtIndex) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "readpurchase");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("purchaseid",
				"" + productList.get(purAtIndex).get("purchaseid"));
		AppKeyz.postData(paramMap, this, "RP", "Fetching Purchase...");
	}

	public void updatePurchase(int purAtIndex) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "updatepurchase");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("purchaseid",
				"" + productList.get(purAtIndex).get("purchaseid"));
		paramMap.put("expiration", "2020-12-31");
		paramMap.put("active", "true");
		AppKeyz.postData(paramMap, this, "UP", "Updating Purchase...");
	}

	public void deactivatePurchase(int purAtIndex) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "deletepurchase");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("purchaseid",
				"" + productList.get(purAtIndex).get("purchaseid"));
		AppKeyz.postData(paramMap, this, "DP", "Deavtivating Purchase...");

	}

	// *************List Consumable *************************************
	public void listconsumablesWithEmail() {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "listconsumables");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		AppKeyz.postData(paramMap, this, "LC", "Fetching List...");
	}

	// ***************read Consumable*************************************
	private void readConsuable(int consuableAtIndex) {
		HashMap<String, String> paramMap = new HashMap<String, String>();

		paramMap.put("apiaction", "readconsumable");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("consumableid", ""
				+ consuableList.get(consuableAtIndex).get("consumableid"));
		AppKeyz.postData(paramMap, this, "RC", "Fetching Lists...");
	}

	// *****************Update Consumable***********************************
	private void udpateConsuable(int consuableAtIndex, float addToBalance,
			float setBalance) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "updateconsumable");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("consumableid", ""
				+ consuableList.get(consuableAtIndex).get("consumableid"));
		if (addToBalance != -1)
			paramMap.put("adjustbalance", "" + addToBalance);
		if (setBalance != -1)
			paramMap.put("setbalance", "" + setBalance);
		AppKeyz.postData(paramMap, this, "UC", "Fetching Lists...");

	}

	// ****************Create Device **********************************
	public void createdeviceWithEmail(String deviceId, String deviceIp,
			String deviceToken) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "createdevice");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("deviceid", device_id);// device_id

		paramMap.put("devicetype", deviceType());
		paramMap.put("devicetoken", deviceToken);
		paramMap.put("deviceip", deviceIp);
		AppKeyz.postData(paramMap, this, "CD", "Creating Device...");
	}

	/*
	 * apiaction = createdevice; apptoken = ci48xk6m; deviceid =
	 * a127f7e2fcc3611e6d2a8844ed7c4cb7; deviceip = ""; devicetoken = "";
	 * devicetype = "iPhone Simulator iPhone OS6.1"; email =
	 * "testuser@test.com"; password = test;
	 */

	private String deviceType() {
		// TODO Auto-generated method stub
		return null;
	}

	public void listdevicesWithEmail() {
		// if(deviceList.size()==0){
		// // new Alerts(contaxt, "You need to create device first ");
		// Log.e(Tag, "Update device if condition--");
		// }else{
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "listdevices");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		AppKeyz.postData(paramMap, this, "LD", "Fetching List...");
	}

	// }
	public void readdeviceWithEmail(int deviceAtIndex) {
		// if(deviceList.size()==0){
		// // new Alerts(contaxt, "You need to create device first ");
		// Log.e(Tag, "Update device if condition--");
		// }else{
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "readdevice");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("deviceid", "" + device_id);//
		AppKeyz.postData(paramMap, this, "RD", "Fetching Device...");
		// }
	}

	public void updatedevice(int deviceAtIndex) {

		// if(deviceList.size()==0){
		// // new Alerts(contaxt, "You need to create device first ");
		// Log.e(Tag, "Update device if condition--");
		// }
		// else
		// {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "updatedevice");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);
		paramMap.put("deviceid", "" + device_id);// deviceList.get(deviceAtIndex).get("deviceid")
		paramMap.put("newdeviceid", deviceType());
		paramMap.put("devicetype", deviceType());
		paramMap.put("devicetoken", "");
		paramMap.put("deviceip", "");
		AppKeyz.postData(paramMap, this, "UD", "Updating Device...");
		// }
	}

	public void deletedeviceWithEmail(int deviceAtIndex) {
		// if(deviceList.size()==0){
		// // new Alerts(contaxt, "You need to create device first ");
		// Log.e(Tag, s"Update device if condition--");
		// }else{
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apiaction", "deletedevice");
		paramMap.put("apptoken", AppUtils.APP_TOKEN);
		paramMap.put("email", email);
		paramMap.put("password", password);

		Log.e(Tag, "Device List = " + deviceList);
		paramMap.put("deviceid", "" + device_id);// deviceList.get(deviceIndex).get("deviceid")
		AppKeyz.postData(paramMap, this, "DD", "Deleting Device...");
	}

	// }
	// callback functions
	public static void createPurchaseCallback(JSONObject response, Context c) {

		Log.e("RESPONSE = ", "AAAA" + response);
		try {
			Log.e("Callback createPurchaseCallback", "Response Error :"
					+ response.get("error"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void listPurchaseCallback(JSONObject response, Context c) {
		try {

			Log.e("RESPONSE = ", "AAAA" + response);
			Log.e("Callback listPurchaseCallback", "Response Error :"
					+ response.get("error"));
			int error = Integer.parseInt(response.getString("error"));

			if (error == 0) {

				JSONArray purchasesArray = response.getJSONArray("purchases");

				if (productList.size() > 0) {
					productList.clear();
				}
				for (int i = 0; i < purchasesArray.length(); i++) {
					Map<String, String> prodcut = new HashMap<String, String>();

					prodcut.put("productsku", purchasesArray.getJSONObject(i)
							.getString("productsku"));
					prodcut.put("consumableid", purchasesArray.getJSONObject(i)
							.getString("consumableid"));
					prodcut.put("purchaseid", purchasesArray.getJSONObject(i)
							.getString("purchaseid"));
					prodcut.put("price", purchasesArray.getJSONObject(i)
							.getString("price"));
					prodcut.put("expiration", purchasesArray.getJSONObject(i)
							.getString("expiration"));
					prodcut.put("productname", purchasesArray.getJSONObject(i)
							.getString("productname"));

					productList.add(prodcut);
				}
				Log.e("Callback listPurchaseCallback", "Response productList :"
						+ productList);
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void readpurchaseCallback(JSONObject response, Context c) {
		try {
			Log.e("RESPONSE = ", "AAAA" + response);
			Log.e("Callback readpurchaseCallback", "Response Error :"
					+ response.get("error"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void updatepurchaseCallback(JSONObject response, Context c) {
		try {
			Log.e("RESPONSE = ", "AAAA" + response);
			Log.e("Callback updatepurchaseCallback", "Response Error :"
					+ response.get("error"));
			int error = Integer.parseInt(response.getString("error"));

			Log.e("RESPONSE UPDATE Arun = ", "Update =" + response);
			if (error == 0) {
				AppKeyz.alert("Purchase updated successfully.");
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void deactivatePurchaseCallback(JSONObject response, Context c) {
		try {
			Log.e("RESPONSE = ", "AAAA" + response);
			Log.e("Callback deactivatePurchaseCallback", "Response Error :"
					+ response.get("error"));
			int error = Integer.parseInt(response.getString("error"));
			if (error == 0) {
				AppKeyz.alert("Purchase deactivated successfully.");
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void listconsumablesCallback(JSONObject response, Context c) {
		try {
			Log.e("RESPONSE = ", "AAAA" + response);
			Log.e("Callback listPurchaseCallback", "Response Error :"
					+ response.get("error"));
			int error = Integer.parseInt(response.getString("error"));

			if (error == 0) {

				JSONArray reponseArray = response.getJSONArray("consumables");

				if (productList.size() > 0) {
					productList.clear();
				}
				for (int i = 0; i < reponseArray.length(); i++) {
					Map<String, String> obj = new HashMap<String, String>();

					obj.put("consumableid", reponseArray.getJSONObject(i)
							.getString("consumableid"));
					/*
					 * obj.put("consumableid", reponseArray.getJSONObject(i)
					 * .getString("consumableid"));
					 */
					obj.put("balance",
							reponseArray.getJSONObject(i).getString("balance"));
					obj.put("name",
							reponseArray.getJSONObject(i).getString("name"));

					consuableList.add(obj);
				}
				Log.e("Callback listconsumablesCallback",
						"Response consumables :" + consuableList);
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void readconsuableCallback(JSONObject response, Context c) {
		try {
			Log.e("Callback readconsuableCallback", "Response Error :"
					+ response.get("error"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// *******************createDeviceCallback***************************
	public static void createDeviceCallback(JSONObject response, Context c) {
		try {
			Log.e("createDeviceCallback",
					"Response Error :" + response.get("error"));
			AppKeyz.alert("Device  Created successfully.");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// *********************List Device**********************
	public static void listDeviceCallback(JSONObject response, Context c) {
		try {
			Log.e("listDeviceCallback PATHANIA!!!!! ", "Response Error :"
					+ response.get("error"));
			Log.e("listDeviceCallback PATHANIA!!!!! ", "Response :" + response);

			int error = Integer.parseInt(response.getString("error"));

			if (error == 0) {

				JSONArray reponseArray = response.getJSONArray("deviceids");

				Log.e("reponseArray PATHANIA!!!!! ", "reponseArray :"
						+ reponseArray);

				if (deviceList.size() > 0) {
					deviceList.clear();
				}
				for (int i = 0; i < reponseArray.length(); i++) {
					Map<String, String> obj = new HashMap<String, String>();
					obj.put("deviceID", reponseArray.getString(i));
					deviceList.add(obj);
				}
				Log.e("Callback List device Callback", "Response List device :"
						+ deviceList);
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void readDeviceCallback(JSONObject response, Context c) {
		try {
			Log.e("readDeviceCallback ",
					"Response Error :" + response.get("error"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void updateDeviceCallback(JSONObject response, Context c) {
		try {
			Log.e("updateDeviceCallback ",
					"Response Error :" + response.get("error"));
			AppKeyz.alert("Device Updated successfully.");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void deleteDeviceCallback(JSONObject response, Context c) {
		try {
			Log.e("deleteDeviceCallback ",
					"Response Error :" + response.get("error"));
			AppKeyz.alert("Device Deleted successfully.");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()) {
		case R.id.logout:
			Intent it = new Intent(this, MainActivity.class);
			this.startActivity(it);
			break;
		case R.id.createPurchase:
			Log.e(Tag, "Create Purchase clicked---");

			if (MainActivity.noThanks_yes) {
				type_dilog = new Dialog(AppkeyzActivity.this);
				type_dilog.requestWindowFeature(Window.FEATURE_NO_TITLE);

				type_dilog.setContentView(R.layout.customdialog);
				// type_dilog.setTitle(R.string.Without_Login_Dialog);

				body_dialog = (TextView) type_dilog.findViewById(R.id.capture);
				
				login_dialog = (Button) type_dilog.findViewById(R.id.login);
				cAccount_dialog = (Button) type_dilog
						.findViewById(R.id.createaccount);
				noThanks_dialog = (Button) type_dilog
						.findViewById(R.id.no_thanks);

				body_dialog.setLayoutParams(new LinearLayout.LayoutParams(
						LinearLayout.LayoutParams.FILL_PARENT,
						LinearLayout.LayoutParams.WRAP_CONTENT));

				login_dialog.setLayoutParams(new LinearLayout.LayoutParams(
						LinearLayout.LayoutParams.FILL_PARENT,
						LinearLayout.LayoutParams.WRAP_CONTENT));

				cAccount_dialog.setLayoutParams(new LinearLayout.LayoutParams(
						LinearLayout.LayoutParams.FILL_PARENT,
						LinearLayout.LayoutParams.WRAP_CONTENT));

				noThanks_dialog.setLayoutParams(new LinearLayout.LayoutParams(
						LinearLayout.LayoutParams.FILL_PARENT,
						LinearLayout.LayoutParams.WRAP_CONTENT));

				body_dialog.setText(R.string.Without_Login_Dialog);

				login_dialog.setText("Login In ");
				cAccount_dialog.setText("Create Account ");
				noThanks_dialog.setText("No Thanks ");

				type_dilog.show();
				noThanks_dialog.setOnClickListener(new OnClickListener() {

					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						MainActivity.noThanks_yes = false;
						type_dilog.dismiss();
					}
				});

				login_dialog.setOnClickListener(new OnClickListener() {

					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						MainActivity.noThanks_yes = false;
						startActivity(new Intent(AppkeyzActivity.this,
								LoginActivity.class));
						type_dilog.dismiss();
					}
				});

				cAccount_dialog.setOnClickListener(new OnClickListener() {
					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						MainActivity.noThanks_yes = false;
						startActivity(new Intent(AppkeyzActivity.this,RegisterActivity.class));
						type_dilog.dismiss();
					}
				});
				MainActivity.noThanks_yes = false;
			}
			else
			{
				createPurchaserWithEmail();
			}
			break;
		case R.id.listPurchase:
			listpurchasesWithEmail();
			break;
		case R.id.listConsuable:
			listconsumablesWithEmail();
			break;
		case R.id.readPurchase:
			if (productList.size() > 0) {
				Log.e("Product List Size = ", "Product  lIst = " + productList);
				readpurchaseWithEmail(randomPurchase());
			} else {
				alert("No Product in your List, please tap on List Purchases to create purchases");
			}
			break;
		case R.id.updatePurchase:
			Log.e("Product List Size = ", "Product  lIst = " + productList);
			if (productList.size() > 0) {
				updatePurchase(randomPurchase());
			} else {
				alert("No Product in your List, please tap on List Purchases to create purchases");
			}
			break;
		case R.id.deactivatePurchase:
			Log.e("Product List Size = ", "Product  lIst = " + productList);
			if (productList.size() > 0) {
				deactivatePurchase(randomPurchase());
			} else {
				alert("No Product in your List, please tap on List Purchases to create purchases");
			}
			break;
		case R.id.readConsuable:
			readConsuable(randomConsubale());
			break;
		case R.id.udpdateConsuable:
			Random r = new Random();

			int y = r.nextInt(21 - 0) % 2;
			int x = r.nextInt(2000 - 0) % 200;
			if (y == 0) {
				udpateConsuable(randomConsubale(), -1, x);
			} else if (y == 1) {
				udpateConsuable(randomConsubale(), x, -1);
			}
			break;
		case R.id.createDevice:
			Log.e(Tag, "Create device clicked---");
			createdeviceWithEmail(deviceId, deviceIp, deviceToken);
			break;
		case R.id.listDevice:
			Log.e(Tag, "List Device clicked---");
			listdevicesWithEmail();
			break;
		case R.id.readDevice:
			Log.e(Tag, "Read device clicked---");
			readdeviceWithEmail(deviceIndex);
			// readdeviceWithEmail(randomDevice());
			break;
		case R.id.updateDevice:
			Log.e(Tag, "Update device clicked---");
			updatedevice(deviceIndex);
			// updatedevice(randomDevice());
			break;
		case R.id.deleteDevice:
			Log.e(Tag, "Delete device clicked---");
			deletedeviceWithEmail(deviceIndex);
			// deletedeviceWithEmail(randomDevice());
			break;
		case R.id.btnEditProfil:
			startActivity(new Intent(AppkeyzActivity.this, EditProfile.class));
		}
	}

	public int randomPurchase() {
		Random r = new Random();
		int x = r.nextInt(productList.size() - 0);
		return x;
	}

	public int randomConsubale() {
		Random r = new Random();
		int x = r.nextInt(consuableList.size() - 0);
		return x;
	}

	public int randomDevice() {
		Random r = new Random();
		int x = r.nextInt(deviceList.size() - 0);
		Log.e("Randam device = ", "@@@@@" + x);
		return x;
	}

	public void alert(String message) {
		AlertDialog.Builder bld = new AlertDialog.Builder(this);
		bld.setMessage(message);
		bld.setNeutralButton("OK", null);
		bld.create().show();
	}
}
