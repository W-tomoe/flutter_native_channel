package com.wujiyunhe.flutterhybridandroid;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentTransaction;
import io.flutter.facade.Flutter;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.view.FlutterView;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.Toast;

import static android.provider.AlarmClock.EXTRA_MESSAGE;

public class MainActivity extends AppCompatActivity {
    public static final String EXTRA_MESSAGE = "com.wujiyunhe.androiddemo01.MESSAGE";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        // or
//        View flutterView = Flutter.createView(
//                MainActivity.this,
//                getLifecycle(),
//                "route1"
//        );
//
//        FrameLayout.LayoutParams layout = new FrameLayout.LayoutParams(600,800);
//        layout.leftMargin = 100;
//        layout.topMargin = 200;
//        addContentView(flutterView,layout);



    }

    public void sendMessage(View view) {
        Intent intent = new Intent(this, FlutterChannelActivity.class);
        EditText editText = (EditText) findViewById(R.id.editText);
        String message = editText.getText().toString();
        intent.putExtra(EXTRA_MESSAGE, message);
        startActivity(intent);
    }
}



