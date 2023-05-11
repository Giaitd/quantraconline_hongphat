package com.example.batterrylevel;
//package com.example.batterrylevel;
//
//import io.flutter.embedding.android.FlutterActivity;
//
//public class MainActivity extends FlutterActivity {
//}

import androidx.annotation.NonNull;

import com.example.batterrylevel.COD_BOD_Module.ReadCodBod;
import com.example.batterrylevel.DIDOModule.ReadDIDO;
import com.example.batterrylevel.PHModule.ReadPH;
import com.example.batterrylevel.Program.ControlOutput;
import com.example.batterrylevel.Program.Globals;
import com.example.batterrylevel.Program.SetID;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "giaitd.com/data";

    Timer timerControlOutput = new Timer();
    Timer timerGetPH1 = new Timer();
    Timer timerGetCodBod = new Timer();
    Timer timerGetNH4 = new Timer();
    Timer timerGetDIDO = new Timer();
    Timer timerSetID = new Timer();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        timerGetPH1.schedule(ReadPH.getPHTask(getApplicationContext()), 0, 3000);
        timerGetCodBod.schedule(ReadCodBod.getCodBodTask(getApplicationContext()), 100, 3000);
        timerGetDIDO.schedule(ReadDIDO.getDIDOTask(getApplicationContext()), 300, 2000);
        timerControlOutput.schedule(ControlOutput.controlOutputTask(getApplicationContext()), 400, 2000);
        // timerSetID.schedule(SetID.changeID(getApplicationContext()),300,1000);


        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    //TODO

                    final Map<String, Object> arg = call.arguments();
                    final HashMap<String, Object> arg2 = new HashMap<String, Object>();

                    //channel
                    if (call.method.equals("dataToNative")) {

                        Globals.pHMinSet = (double) arg.get("pHMinSet");
                        Globals.pHMaxSet = (double) arg.get("pHMaxSet");
                        Globals.codSet = (double) arg.get("codSet");
                        Globals.bodSet = (double) arg.get("bodSet");
                        Globals.nh4Set = (double) arg.get("nh4Set");
                        Globals.tssSet = (double) arg.get("tssSet");

//                    } else if (call.method.equals("dataToNative9")) {
//                        //id
//                        Globals.idOld = (int) arg.get("idOld");
//                        Globals.idNew = (int) arg.get("idNew");
//                        Globals.btnSetId = (boolean) arg.get("btnSetId");

                    } else if (call.method.equals("getData")) {
                        arg2.put("getpH", Globals.pH);
                        arg2.put("getTemp", Globals.temp);
                        arg2.put("getCod", Globals.cod);
                        arg2.put("getBod", Globals.bod);
                        arg2.put("getTss", Globals.tss);
                        arg2.put("getNh4", Globals.nh4);

                        arg2.put("getDO0", Globals.dOData.valueDO0);
                        arg2.put("getDO1", Globals.dOData.valueDO1);
                        arg2.put("getDO2", Globals.dOData.valueDO2);

                        result.success(arg2);
                    } else {
                        result.notImplemented();
                    }
                });

    }


}