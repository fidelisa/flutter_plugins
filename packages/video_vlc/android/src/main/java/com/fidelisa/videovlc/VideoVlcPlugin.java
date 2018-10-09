package com.fidelisa.videovlc;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/** VideoVlcPlugin */
public class VideoVlcPlugin implements MethodCallHandler {
    private static Context context;

    /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "video_vlc");
    channel.setMethodCallHandler(new VideoVlcPlugin());
    context = registrar.activeContext();
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String url = call.argument("url");
    if (call.method.equals("play")) {
      Intent launchIntent;

      Intent i = new Intent(context, VideoActivity.class);
      i.putExtra(VideoActivity.LOCATION, url);
      context.startActivity(i);

      result.success(null);
    } else {
      result.notImplemented();
    }
  }
}
