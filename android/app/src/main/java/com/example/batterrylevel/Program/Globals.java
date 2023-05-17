package com.example.batterrylevel.Program;

import com.example.batterrylevel.COD_BOD_Module.CodBodData;
import com.example.batterrylevel.DIDOModule.DIData;
import com.example.batterrylevel.DIDOModule.DOData;
import com.example.batterrylevel.Nh4module.Nh4Data;
import com.example.batterrylevel.PHModule.PHData;

import java.util.Timer;
import java.util.TimerTask;

public class Globals {

    public static Integer idOld = 6;
    public static Integer idNew = 10;
    public static Boolean btnSetId = false;


    // module di-do
    public static DIData dIData = null;
    public static DOData dOData = null;
    public static byte[] bufferAll = null;

    public static PHData getPHData = null;
    public static CodBodData getCodBodData = null;
    public static Nh4Data getNH4Data = null;

    public static Timer timerReadDIDOData;
    public static TimerTask timerReadDIDODataTask;


    //data realtime
    public static Double pH = -0.01;
    public static Double temp = -0.01;
    public static Double cod = -0.01;
    public static Double bod = -0.01;
    public static Double tss = -0.01;
    public static Double nh4 = -0.01;

    //offset data
    public static Double offsetpH = 0.0;
    public static Double offsetCOD = 0.0;
    public static Double offsetNH4 = 0.0;

    //data setup from UI
    public static Double pHMinSet = 6.5;
    public static Double pHMaxSet = 8.5;
    public static Double codSet = 100.0;
    public static Double bodSet = 50.0;
    public static Double tssSet = 100.0;
    public static Double nh4Set = 10.0;


}
