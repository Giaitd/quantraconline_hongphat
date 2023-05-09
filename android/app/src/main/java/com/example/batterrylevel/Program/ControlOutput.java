package com.example.batterrylevel.Program;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.Nullable;

import com.example.batterrylevel.DIDOModule.SetDO;

import java.util.Arrays;
import java.util.TimerTask;

public class ControlOutput extends android.app.Service {


    public ControlOutput() {
        super();
    }

    public static TimerTask controlOutputTask(Context context) {
        return new TimerTask() {
            Handler mTimerHandler = new Handler();

            public void run() {
                mTimerHandler.post(new Runnable() {
                    @Override
                    public void run() {

                    }
                });
            }
        };
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}

