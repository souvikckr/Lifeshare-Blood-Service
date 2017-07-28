package beacon.comlocate.bloodbankservices;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;
import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class Login extends AppCompatActivity implements View.OnClickListener{

    SharedPreferences sharedPreferences;
    String IP;
    Button login, register;
    EditText email,password;
    String emailid,pswd;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_activity);

        sharedPreferences = getSharedPreferences(Constant.PREF_IP, MODE_PRIVATE);
        IP = sharedPreferences.getString(Constant.IP_KEY, "");

        email = (EditText) findViewById(R.id.editText_email);
        password = (EditText) findViewById(R.id.editText_password);

        login = (Button) findViewById(R.id.signin);
        register = (Button) findViewById(R.id.register);



        if (IP.equals("")) {
            showAlert();
        }

        login.setOnClickListener(this);

        register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(), Register.class);
                startActivity(intent);
            }
        });
    }

    private void showAlert() {
        AlertDialog.Builder builder = new AlertDialog.Builder(Login.this);
        final EditText editText = new EditText(Login.this);
        editText.setText(IP);
        editText.setHint("192.168.1.100");
        builder.setView(editText);
        builder.setPositiveButton("SET", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                IP = editText.getText().toString();
                SharedPreferences.Editor editor = sharedPreferences.edit();
                editor.putString(Constant.IP_KEY, IP);
                editor.commit();
            }
        });
        builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
            }
        });
        builder.show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        showAlert();
        return true;
    }

    private boolean isEmail(String email) {
        String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }


    private boolean isPassword(String passwrd) {
        if (passwrd != null && passwrd.length() > 5) {
            return true;
        }
        return false;
    }

    @Override
    public void onClick(View v) {
        emailid = email.getText().toString();
        pswd  = password.getText().toString();

        if (!isEmail(emailid)) {
            email.setError("Enter Username");
        } else if (!isPassword(pswd)) {
            password.setError("Enter Password");
        } else {
            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject.put("email", emailid);
                jsonObject.put("password", pswd);
                String result = jsonObject.toString();
                if (CommonClass.test_internet(Login.this) == true) {
                    new userlogin().execute(result);
                } else {
                    Toast.makeText(getApplicationContext(), "PLEASE CHECK YOUR INTERNET CONNECTION", Toast.LENGTH_SHORT).show();
                }

            } catch (JSONException jsonex) {
                jsonex.getMessage();
            }

        }
    }

    class userlogin extends AsyncTask<String, Void, String> {
        String URL = Constant.URL.replace("IP", IP);
        String pkg = Constant.NAMESPACE;
        String method = "login";
        String SOAPACTION = pkg + "/" + method;

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
           // Toast.makeText(getApplicationContext(), "inside URL", Toast.LENGTH_SHORT).show();
           // Toast.makeText(getApplicationContext(),URL,Toast.LENGTH_SHORT).show();
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

            } catch (Exception e) {
                e.printStackTrace();
                result = e.getMessage();
            }
            return result;
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            String result = s;
            // Toast.makeText(getApplicationContext(),s,Toast.LENGTH_SHORT).show();
            if (s != null) {
                try {
                    JSONObject jsonObject = new JSONObject(s);
                    int i = jsonObject.getInt("error");
                    //Toast.makeText(getApplicationContext(),i + "",Toast.LENGTH_SHORT).show();
                    if (i == 0) {
                        Intent intent = new Intent(getApplicationContext(), Homepage.class);
                        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                    } else {
                        Toast.makeText(getApplicationContext(), "Invalid EmailID and Password", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    e.getMessage();
                }
            }
        }
    }

}
