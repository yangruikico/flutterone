package com.example.flutter_app;

import android.app.Application;
import android.content.Context;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {
    private static Context mContext;
    @Override
    public void onCreate() {
        super.onCreate();
        mContext=getApplicationContext();
    }
    public static Context getMyContext() {
        return mContext;
    }
}
