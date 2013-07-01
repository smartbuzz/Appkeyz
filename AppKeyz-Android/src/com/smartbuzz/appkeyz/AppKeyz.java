package com.smartbuzz.appkeyz;
import java.util.HashMap;

import org.json.JSONObject;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.util.Log;
import com.loopj.android.http.*;
import com.loopj.android.http.JsonHttpResponseHandler;
import com.loopj.android.http.RequestParams;

public class AppKeyz {
	static ProgressDialog pdia;
	static Activity c;
	static String callFrom;

	private static AsyncHttpClient client = new AsyncHttpClient();
	public static void get(String url, RequestParams params,
			AsyncHttpResponseHandler responseHandler) {
		Log.e("App Keys Response", "=AA " + params);
		Log.e("go hit responseHandler", "===" + responseHandler);
		Log.e("go hit url", "===" + url);
		
		client.get(getAbsoluteUrl(url), params, responseHandler);
	}

	public static void post(String url, RequestParams params,
			AsyncHttpResponseHandler responseHandler) {
		client.post(getAbsoluteUrl(url), params, responseHandler);
	}

	private static String getAbsoluteUrl(String relativeUrl) {
		Log.e("Relative _Url----","Relative = "+relativeUrl);
		Log.e("Base_Url----","Base_Url = "+AppUtils.BASE_URL +relativeUrl);
		return AppUtils.BASE_URL + relativeUrl;
	}

	public static void postData(HashMap paramMap, Activity ca,
			String calling, String dialogMessage) {
		RequestParams params = new RequestParams(paramMap);
		c = ca;
		callFrom = calling;
		
		pdia = new ProgressDialog(ca);
		pdia.setMessage(dialogMessage);
		AppKeyz.get("", params, new JsonHttpResponseHandler() {
			@Override
			public void onStart() {
				// TODO Auto-generated method stub
		
				pdia.show();
				super.onStart();

			}
			@Override
			public void onSuccess(JSONObject timeline) {
				Log.e("Check Response", "==onSuccess" + timeline);
				response(timeline);
				
			}

			@Override
			public void onFailure(Throwable arg0) {
				// TODO Auto-generated method stub
				Log.e("Check Response", "==onFailure");
			}

			@Override
			public void onFinish() {
				// TODO Auto-generated method stub
				pdia.dismiss();
				super.onFinish();
			}
		});
	}

	public static void response(JSONObject response) {
		if (callFrom == "RG") {
			RegisterActivity.callback(response, c);
		}
		else if (callFrom == "LN") {
			LoginActivity.callback(response, c);
		}
		else if (callFrom == "LP") {
			AppkeyzActivity.listPurchaseCallback(response, c);
		}
		else if (callFrom == "UP") {
			AppkeyzActivity.updatepurchaseCallback(response, c);
		}
		else if (callFrom == "DP") {
			AppkeyzActivity.deactivatePurchaseCallback(response, c);
		}
		else if (callFrom == "LC") {
			AppkeyzActivity.listconsumablesCallback(response, c);
		}
		else if (callFrom == "RC") {
			AppkeyzActivity.readconsuableCallback(response, c);
		}
		//**********Create Device **************Arun***************
		
		else if (callFrom == "CD") {
			AppkeyzActivity.createDeviceCallback(response, c);
		}
		else if (callFrom == "LD") {
			AppkeyzActivity.listDeviceCallback(response, c);
		}
		else if (callFrom == "RD") {
			AppkeyzActivity.readDeviceCallback(response, c);
		}
		else if (callFrom == "UD") {
			AppkeyzActivity.updateDeviceCallback(response, c);
		}
		else if (callFrom == "DD") {
			AppkeyzActivity.deleteDeviceCallback(response, c);
		}
		
	}
	public static void alert(String message) {
		AlertDialog.Builder bld = new AlertDialog.Builder(c);
		bld.setMessage(message);
		bld.setNeutralButton("OK", null);	
		bld.create().show();
	}
}
