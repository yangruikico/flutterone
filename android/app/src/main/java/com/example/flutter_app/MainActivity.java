package com.example.flutter_app;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

    //channel的名称，由于app中可能会有多个channel，这个名称需要在app内是唯一的。
    private static final String CHANNEL = "samples.flutter.io/battery";
    private static final String EVENT_CHANNEL = "com.womai.flutter/receive";
    private static final String METHOD_CHANNEL = "com.womai.flutter/fetch";
    private static final String METHOD_CHANNELNTF = "com.womai.flutter/fetchntf";



    String data = "{\n" +
            "\t\"animals\":{\n" +
            "\t\"dog\":[\n" +
            "\t\t{\"name\":\"Rufus\",\"breed\":\"labrador\",\"count\":1,\"twoFeet\":false},\n" +
            "\t\t{\"name\":\"Marty\",\"breed\":\"whippet\",\"count\":1,\"twoFeet\":false}\n" +
            "\t],\n" +
            "\t\"cat\":{\"name\":\"Matilda\"}\n" +
            "}\n" +
            "}";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        GeneratedPluginRegistrant.registerWith(Objects.requireNonNull(getFlutterEngine()));

        // 直接 new MethodChannel，然后设置一个Callback来处理Flutter端调用
        MethodChannel methodChannel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);
        methodChannel.setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("getBatteryLevel")) {
                            int batteryLevel = getBatteryLevel();

                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }



                            methodChannel.invokeMethod("getData", "123466789", new MethodChannel.Result() {
                                public void success(@Nullable Object o) {
                                    Log.e("yangrui", "success="+o);
                                }

                                @Override
                                public void error(String s, @Nullable String s1, @Nullable Object o) {
                                    Log.e("yangrui", "error="+s);
                                }

                                @Override
                                public void notImplemented() {
                                    Log.e("yangrui", "notImplemented");
                                }
                            });

                        } else {
                            result.notImplemented();
                        }
                    }
                });







        native2Dart();
        responseDart();





      /*  MethodChannel methodChannel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), METHOD_CHANNELNTF);


        methodChannel.invokeMethod("getData", "123466789", new MethodChannel.Result() {
            public void success(@Nullable Object o) {
                Log.e("yangrui", "success="+o);
            }

            @Override
            public void error(String s, @Nullable String s1, @Nullable Object o) {
                Log.e("yangrui", "error="+s);
            }

            @Override
            public void notImplemented() {
                Log.e("yangrui", "notImplemented");
            }
        });
*/


    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();

    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }

    /**
     * native data to  dart
     */
    private void native2Dart() {
        /**
         * 数据流的通信（event streams）
         */
        EventChannel eventChannel = new EventChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), EVENT_CHANNEL);
        EventChannel.StreamHandler streamHandler = new EventChannel.StreamHandler() {


            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                Log.e("plateform_channel", "arguments: " + arguments.toString());
                events.success(data);
            }

            @Override
            public void onCancel(Object arguments) {
                Log.e("plateform_channel", "arguments: " + arguments.toString());
            }
        };
        eventChannel.setStreamHandler(streamHandler);
    }


    private void responseDart() {
        MethodChannel methodChannel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), METHOD_CHANNEL);
        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("customMethodName")) {
                    result.success(data);


                    methodChannel.invokeMethod("getData", "123466789", new MethodChannel.Result() {
                        public void success(@Nullable Object o) {
                            Log.e("yangrui", "success="+o);
                        }

                        @Override
                        public void error(String s, @Nullable String s1, @Nullable Object o) {
                            Log.e("yangrui", "error="+s);
                        }

                        @Override
                        public void notImplemented() {
                            Log.e("yangrui", "notImplemented");
                        }
                    });

                } else {
                    result.notImplemented();
                }
            }
        });
    }
}





























