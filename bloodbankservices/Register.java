package beacon.comlocate.bloodbankservices;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;
import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;
import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Torus on 3/21/2017.
 */


public class Register extends AppCompatActivity implements View.OnClickListener {

    EditText username, password, Address, Phonenum, emailid;
    Spinner bloodgroup;
    RadioGroup status;
    RadioButton radioButton;
    Button register;
    Spinner bloodgrp;
    String uname, paswrd, addrs, phnum, emmail, bldgrp, stats;
    SharedPreferences sharedPreferences;
    String IP;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.register);


        sharedPreferences = getSharedPreferences(Constant.PREF_IP, MODE_PRIVATE);
        IP = sharedPreferences.getString(Constant.IP_KEY, "");


        bloodgrp = (Spinner) findViewById(R.id.bloodgroup);
        radioButton = (RadioButton) findViewById(R.id.both);
        username = (EditText) findViewById(R.id.username);
        password = (EditText) findViewById(R.id.password);
        Address = (EditText) findViewById(R.id.address);
        Phonenum = (EditText) findViewById(R.id.phonenum);
        emailid = (EditText) findViewById(R.id.emailid);
        bloodgroup = (Spinner) findViewById(R.id.bloodgroup);
        status = (RadioGroup) findViewById(R.id.status);
        register = (Button) findViewById(R.id.register);

        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this, R.array.bloodgroup, android.R.layout.simple_spinner_item);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        bloodgroup.setAdapter(adapter);

        register.setOnClickListener(this);
    }


    private boolean isUsername(String name) {
        if (name != null && name.length() > 5) {
            return true;
        }
        return false;
    }

    private boolean isPassword(String passwrd) {
        if (passwrd != null && passwrd.length() > 5) {
            return true;
        }
        return false;
    }

    private boolean isAddress(String addrs) {
        if (addrs != null && addrs.length() > 5) {
            return true;
        }
        return false;
    }


    private boolean isPhonenum(String phone) {
        boolean check = false;
        if (!Pattern.matches("[a-zA-Z]+", phone)) {
            if (phone.length() < 6 || phone.length() > 13) {
                check = false;
            } else {
                check = true;
            }
        } else {
            check = false;
        }
        return check;
    }

    private boolean isEmail(String email) {
        String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    private boolean isBloodGroup() {
        int pos = bloodgrp.getSelectedItemPosition();
        if (pos <= 0) {
            return false;
        }
        return true;
    }

    @Override
    public void onClick(View v) {

        uname = username.getText().toString();
        paswrd = password.getText().toString();
        addrs = Address.getText().toString();
        phnum = Phonenum.getText().toString();
        emmail = emailid.getText().toString();
        bldgrp = bloodgroup.getSelectedItem().toString();
        radioButton = (RadioButton) findViewById(status.getCheckedRadioButtonId());
        stats = radioButton.getText().toString();

        if (!isUsername(uname)) {
            username.setError("Enter Username");
        } else if (!isPassword(paswrd)) {
            password.setError("Enter Password");

        } else if (!isAddress(addrs)) {
            Address.setError("Enter Address");
        } else if (!isEmail(emmail)) {
            emailid.setError("Enter Valid Email");
        } else if (!isPhonenum(phnum)) {
            Phonenum.setError("Enter PhoneNumber");
        } else if (!isBloodGroup()) {
            Toast.makeText(Register.this, "Please Select BloodGroup !!", Toast.LENGTH_LONG).show();
        } else {
            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject.put("username", uname);
                jsonObject.put("password", paswrd);
                jsonObject.put("address", addrs);
                jsonObject.put("phonenum", phnum);
                jsonObject.put("emailid", emmail);
                jsonObject.put("bloodgroup", bldgrp);
                jsonObject.put("status", stats);

            } catch (JSONException jsonex) {
                Log.e("---------------",jsonex.getMessage());
            }
            String result = jsonObject.toString();
            Toast.makeText(getApplicationContext(),result,Toast.LENGTH_SHORT).show();
            new userregister().execute(result);
        }
    }

    class userregister extends AsyncTask<String, Void, String> {
        String URL = Constant.URL.replace("IP", IP);
        String pkg = Constant.NAMESPACE;
        String method = "register";
        String SOAPACTION = pkg + "/" + method;

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            Toast.makeText(getApplicationContext(), "inside userregister", Toast.LENGTH_SHORT).show();
            Toast.makeText(getApplicationContext(), URL, Toast.LENGTH_SHORT).show();
            Toast.makeText(getApplicationContext(), SOAPACTION, Toast.LENGTH_SHORT).show();
        }

        @Override
        protected String doInBackground(String... params) {
            String result = "";

            try {
                SoapObject soapObject = new SoapObject(pkg, method);
                soapObject.addProperty("data", params[0]);
                SoapSerializationEnvelope soapSerializationEnvelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
                soapSerializationEnvelope.setOutputSoapObject(soapObject);
                HttpTransportSE httpTransportSE = new HttpTransportSE(URL);
                httpTransportSE.call(SOAPACTION, soapSerializationEnvelope);
                soapObject = (SoapObject) soapSerializationEnvelope.bodyIn;
                result = soapObject.getProperty(0).toString();
                return result;
            } catch (Exception e) {
                return e.getMessage();
            }
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            String result = s;

            if (result != null) {
                //Toast.makeText(getApplicationContext(), s, Toast.LENGTH_SHORT).show();
                try {
                    JSONObject jsonObject = new JSONObject(result);
                    int i = jsonObject.getInt("error");
                    if (i == 1) {
                        Toast.makeText(getApplicationContext(), "USER SUCESSFULLY REGISTERED", Toast.LENGTH_LONG).show();
                        Intent intent = new Intent(getApplicationContext(),Login.class);
                        startActivity(intent);
                    } else if (i == 0) {
                        Toast.makeText(getApplicationContext(), "USER ALREADY REGISTERED", Toast.LENGTH_LONG).show();
                    } else {
                        Toast.makeText(getApplicationContext(), "TRY AGAIN..", Toast.LENGTH_LONG).show();
                    }
                } catch (Exception e) {
                    e.getMessage();
                }
            }
        }
    }
}
