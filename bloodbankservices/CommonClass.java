package beacon.comlocate.bloodbankservices;

import android.content.Context;
import android.net.ConnectivityManager;

/**
 * Created by Torus on 3/15/2017.
 */

public class CommonClass {

    public static  String imageurl = "http://localhost:8080/MobileReviewReccomendationSystem/imageuploads/";

    public static boolean test_internet(Context cxt) {
        boolean int_test;
        ConnectivityManager manager = (ConnectivityManager) cxt
                .getSystemService(Context.CONNECTIVITY_SERVICE);
        boolean is3g = manager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE)
                .isConnectedOrConnecting();
        boolean isWifi = manager.getNetworkInfo(ConnectivityManager.TYPE_WIFI)
                .isConnectedOrConnecting();

        if (!is3g && !isWifi) {
            int_test = false;
        } else {
            int_test = true;
        }
        return int_test;
    }
}
