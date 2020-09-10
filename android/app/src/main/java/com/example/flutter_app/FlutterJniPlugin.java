package com.example.flutter_app;

import android.app.Activity;
import android.content.Context;
import android.util.Log;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FlutterJniPlugin implements MethodChannel.MethodCallHandler {

    public static final String CHANNEL = "FlutterJniPlugin";
    private Context context;

    public FlutterJniPlugin(Activity activity){
        context = activity.getApplicationContext();
        Log.e(CHANNEL, "CacheDir = " + activity.getCacheDir());
        Log.e(CHANNEL, "FilesDir = " + activity.getFilesDir());
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterJniPlugin flutterJniPlugin = new FlutterJniPlugin(registrar.activity());
        channel.setMethodCallHandler(flutterJniPlugin);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("get_encrypt")) {
            //String encrypt = ProtectUtil.getDataFromCP(context);
            result.success("encrypt");
        }
    }
}
