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
import android.widget.EditText;
import android.widget.Toast;

public class FlutterChannelActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter_channel);

        FragmentTransaction tx = getSupportFragmentManager().beginTransaction();
        tx.replace(R.id.someContainer, Flutter.createFragment("{name:'devio',dataList:['aa', 'bb', 'cc']}"));
        tx.commit();
    }
}



