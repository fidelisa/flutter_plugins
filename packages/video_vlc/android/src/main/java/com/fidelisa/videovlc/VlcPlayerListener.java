package com.fidelisa.videovlc;

import android.util.Log;
import org.videolan.libvlc.MediaPlayer;
import java.lang.ref.WeakReference;

class VlcPlayerListener implements MediaPlayer.EventListener {

    private static String TAG = "VlcPlayerListener";
    private WeakReference<VideoActivity> mOwner;


    public VlcPlayerListener(VideoActivity owner) {
        mOwner = new WeakReference<VideoActivity>(owner);
    }

    @Override
    public void onEvent(MediaPlayer.Event event) {
        VideoActivity player = mOwner.get();

        switch(event.type) {
            case MediaPlayer.Event.EndReached:
                Log.d(TAG, "MediaPlayerEndReached");
                player.releasePlayer();
                break;
            case MediaPlayer.Event.Playing:
            case MediaPlayer.Event.Paused:
            case MediaPlayer.Event.Stopped:
            default:
                break;
        }
    }
}