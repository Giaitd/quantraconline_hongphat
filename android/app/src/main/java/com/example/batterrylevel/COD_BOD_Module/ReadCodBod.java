package com.example.batterrylevel.COD_BOD_Module;

import android.content.Context;
import android.os.Handler;

import com.example.batterrylevel.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadCodBod {

    public static TimerTask getCodBodTask(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {

                    SdkCodBodModule codBodSDK = new SdkCodBodModule();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                    for (DeviceInfo each : devices) {
                        boolean connect = codBodSDK.connect(context, each, 9600);
                        if (connect) {

                            Globals.getCodBodData = codBodSDK.getCodBodData();
                            if (SdkCodBodModule.checkReadCod.equals("010308") && SdkCodBodModule.checkReadBod.equals("010304") && SdkCodBodModule.checkReadTss.equals("010318")) {
                                Globals.bod = Globals.getCodBodData.bod;
                                Globals.cod = Globals.getCodBodData.cod;
                                Globals.tss = Globals.getCodBodData.tss;

                            } else {
                                Globals.bod = -1.0;
                                Globals.cod = -1.0;
                                Globals.tss = -1.0;
                            }
                        }
                    }
                });
            }
        };
    }


}