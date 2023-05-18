package com.example.batterrylevel.Program;

import android.content.Context;
import android.os.Handler;
import android.util.Log;

import com.example.batterrylevel.COD_BOD_Module.SdkCodBodModule;
import com.example.batterrylevel.Nh4module.SdkNh4Module;
import com.example.batterrylevel.PHModule.SdkPHModule;

import java.util.List;
import java.util.TimerTask;
import java.util.logging.LogRecord;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class Calibration {

    public Calibration() {
        super();
    }

    public static TimerTask CalibrationSensor(Context context) {
        return new TimerTask() {
            Handler mTimerHandler = new Handler();

            public void run() {
                mTimerHandler.post(new Runnable() {
                    @Override
                    public void run() {

                        //calibration pH zero
                        if(Globals.pHZero){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
//                                    PHSdk.calibrationZero();
//                                    Log.d("aaa===----","runnnnnn");
                                }
                            }
                        }

                        //calibration pH slope low
                        if(Globals.pHSlopeLo){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
//                                    PHSdk.calibrationSlopeLow();
//                                    Log.d("aaa===1----","runnnnnn");
                                }
                            }
                        }

                        //calibration pH slope hi
                        if(Globals.pHSlopeHi){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
//                                    PHSdk.calibrationSlopeHigh();
//                                    Log.d("aaa===2----","runnnnnn");
                                }
                            }
                        }

                        //calibration nh4 zero
                        if(Globals.nh4Zero){
                            SdkNh4Module NH4Sdk = new SdkNh4Module();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = NH4Sdk.connect(context, each, 9600);
                                if (connect) {
//                                    NH4Sdk.calibrationNH4Zero();
                                }
                            }
                        }

                        //calibration nh4 slope
                        if(Globals.nh4Slope){
                            SdkNh4Module NH4Sdk = new SdkNh4Module();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = NH4Sdk.connect(context, each, 9600);
                                if (connect) {
//                                    NH4Sdk.calibrationNH4Slope();
                                }
                            }
                        }

                        //calibration cod sensor to default factory
                        if(Globals.codDefault){
                            SdkCodBodModule CODSdk = new SdkCodBodModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
//                                    CODSdk.calibrationCODDefault();
//                                    Log.d("aaa===1----","runnnnnn");
                                }
                            }
                        }

                        //turn on the brush
                        if(Globals.turnOnBrush){
                            SdkCodBodModule CODSdk = new SdkCodBodModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
                                    CODSdk.turnOnTheBrush();
                                }
                            }
                        }
                    }
                });
            }


        };
    }
}
