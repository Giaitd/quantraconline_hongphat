package com.example.batterrylevel.Program;

import android.content.Context;
import android.os.Handler;

import java.util.TimerTask;

public class ProgressAndStatus {
    public ProgressAndStatus() {
        super();
    }
    public static TimerTask progressStatusTask(Context context) {
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



}
