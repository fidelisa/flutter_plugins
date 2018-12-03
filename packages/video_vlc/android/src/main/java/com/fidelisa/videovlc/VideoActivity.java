package com.fidelisa.videovlc;

import android.content.Intent;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;
import java.util.ArrayList;
import org.videolan.libvlc.IVLCVout;
import org.videolan.libvlc.LibVLC;
import org.videolan.libvlc.Media;
import org.videolan.libvlc.MediaPlayer;

public class VideoActivity extends AppCompatActivity implements IVLCVout.Callback {
  public static final String TAG = "VideoActivity";

  public static final String LOCATION = "location";

  // display surface
  private SurfaceView mSurface;
  private SurfaceHolder holder;

  // media player
  private LibVLC libvlc;
  private MediaPlayer mMediaPlayer = null;
  private int mVideoWidth;
  private int mVideoHeight;
  private static final int VideoSizeChanged = -1;

  private MediaPlayer.EventListener mPlayerListener = new VlcPlayerListener(this);

  private String rtspUrl;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.video);

    // Get URL
    Intent intent = getIntent();
    rtspUrl = intent.getExtras().getString(LOCATION);
    Log.d(TAG, "Playing back " + rtspUrl);

    mSurface = (SurfaceView) findViewById(R.id.surface);
    holder = mSurface.getHolder();

    mSurface.setOnClickListener(
        new View.OnClickListener() {
          @Override
          public void onClick(View v) {
            if (mMediaPlayer.isPlaying()) {
              mMediaPlayer.pause();
            } else {
              mMediaPlayer.play();
            }
          }
        });
    //holder.addCallback(this);

    Toolbar myToolbar = handleToolbar(intent);

    ArrayList<String> options = new ArrayList<String>();
    //options.add("--aout=opensles");
    //options.add("--audio-time-stretch"); // time stretching
    //options.add("-vvv"); // verbosity
    //options.add("--aout=opensles");
    //options.add("--avcodec-codec=h264");
    //options.add("--file-logging");
    //options.add("--logfile=vlc-log.txt");

    libvlc = new LibVLC(getApplicationContext(), options);
    holder.setKeepScreenOn(true);

    // Create media player
    mMediaPlayer = new MediaPlayer(libvlc);
    mMediaPlayer.setEventListener(mPlayerListener);

    // Set up video output
    final IVLCVout vout = mMediaPlayer.getVLCVout();
    vout.setVideoView(mSurface);
    //vout.setSubtitlesView(mSurfaceSubtitles);
    vout.addCallback(this);
    vout.attachViews();

    Media m = new Media(libvlc, Uri.parse(rtspUrl));

    mMediaPlayer.setMedia(m);
    mMediaPlayer.play();

    mSurface.setTop(myToolbar.getHeight());
    mSurface.setLayoutParams(
        new FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
    mMediaPlayer
        .getVLCVout()
        .setWindowSize(
            getResources().getDisplayMetrics().widthPixels,
            getResources().getDisplayMetrics().heightPixels);
  }

  @NonNull
  private Toolbar handleToolbar(Intent intent) {
    Toolbar myToolbar = (Toolbar) findViewById(R.id.toolbar);
    String title = intent.getExtras().getString("title");
    if (title == null) title = "";
    myToolbar.setTitle(title);

    setSupportActionBar(myToolbar);

    //getSupportActionBar().setHomeButtonEnabled(true);
    //getSupportActionBar().setDisplayHomeAsUpEnabled(true);

    TextView toolbarOK = (TextView) findViewById(R.id.toolbar_ok);
    toolbarOK.setOnClickListener(
        new View.OnClickListener() {
          @Override
          public void onClick(View v) {
            finish();
          }
        });
    return myToolbar;
  }

  @Override
  protected void onResume() {
    super.onResume();
    // createPlayer(mFilePath);
  }

  @Override
  protected void onPause() {
    super.onPause();
    //releasePlayer();
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    releasePlayer();
  }

  @Override
  public void onSurfacesCreated(IVLCVout vlcVout) {
    //setSize(vlcVout)

  }

  @Override
  public void onSurfacesDestroyed(IVLCVout vlcVout) {}

  @Override
  public void onConfigurationChanged(Configuration newConfig) {
    super.onConfigurationChanged(newConfig);
    if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
      mSurface.setLayoutParams(
          new FrameLayout.LayoutParams(
              ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
      mMediaPlayer
          .getVLCVout()
          .setWindowSize(
              getResources().getDisplayMetrics().widthPixels,
              getResources().getDisplayMetrics().heightPixels);
    } else {
      mSurface.setLayoutParams(
          new FrameLayout.LayoutParams(
              ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
      mMediaPlayer
          .getVLCVout()
          .setWindowSize(
              getResources().getDisplayMetrics().widthPixels,
              getResources().getDisplayMetrics().heightPixels);
    }
  }

  public void releasePlayer() {
    if (libvlc == null) return;
    mMediaPlayer.stop();
    final IVLCVout vout = mMediaPlayer.getVLCVout();
    vout.removeCallback(this);
    vout.detachViews();
    holder = null;
    libvlc.release();
    libvlc = null;

    mVideoWidth = 0;
    mVideoHeight = 0;
  }

  private void setSize(int width, int height) {
    mVideoWidth = width;
    mVideoHeight = height;
    if (mVideoWidth * mVideoHeight <= 1) return;

    if (holder == null || mSurface == null) return;

    // get screen size
    int w = getWindow().getDecorView().getWidth();
    int h = getWindow().getDecorView().getHeight();

    // getWindow().getDecorView() doesn't always take orientation into
    // account, we have to correct the values
    boolean isPortrait =
        getResources().getConfiguration().orientation == Configuration.ORIENTATION_PORTRAIT;
    if (w > h && isPortrait || w < h && !isPortrait) {
      int i = w;
      w = h;
      h = i;
    }

    float videoAR = (float) mVideoWidth / (float) mVideoHeight;
    float screenAR = (float) w / (float) h;

    if (screenAR < videoAR) h = (int) (w / videoAR);
    else w = (int) (h * videoAR);

    // force surface buffer size
    holder.setFixedSize(mVideoWidth, mVideoHeight);

    // set display size
    ViewGroup.LayoutParams lp = mSurface.getLayoutParams();
    lp.width = w;
    lp.height = h;
    mSurface.setLayoutParams(lp);
    mSurface.invalidate();
  }
}
