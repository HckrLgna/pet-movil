package io.flutter.app;

import android.content.Context;
import android.content.res.Configuration;

import androidx.multidex.MultiDex;
import io.flutter.app.FlutterApplication;

public class FlutterMultiDexApplication extends FlutterApplication {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
    }
}
