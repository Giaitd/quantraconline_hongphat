package com.example.batterrylevel.COD_BOD_Module;

import android.content.Context;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.util.Log;

import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;

import java.io.IOException;

import asim.sdk.common.Utils;
import asim.sdk.locker.DeviceInfo;


public class SdkCodBodModule {
    public UsbSerialPort usbSerialPort;
    public boolean connected = false;
    public int READ_WAIT_MILLIS = 500;
    public int WRITE_WAIT_MILLIS = 500;
    public static String checkReadCod, checkReadBod, checkReadTss;
    UsbDeviceConnection usbConnection;

    public SdkCodBodModule() {
    }

    public boolean connect(Context context, DeviceInfo deviceInfo, int baudRate) {
        UsbSerialDriver driver = deviceInfo.driver;
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        if (driver.getPorts().size() < deviceInfo.port) {
            Log.d("---sdk-lockerCOD---", "connection failed: not enough ports at device");
            return false;
        } else {
            this.usbSerialPort = (UsbSerialPort) driver.getPorts().get(deviceInfo.port);
            usbConnection = usbManager.openDevice(driver.getDevice());
            if (usbConnection == null) {
                if (!usbManager.hasPermission(driver.getDevice())) {
                    Log.d("---sdk-lockerCOD---", "connection failed: permission denied");
                } else {
                    Log.d("---sdk-lockerCOD---", "connection failed: open failed");
                }
                return false;
            } else {
                try {
                    this.usbSerialPort.open(usbConnection);
                    this.usbSerialPort.setParameters(baudRate, 8, 1, UsbSerialPort.PARITY_NONE);
                    this.connected = true;
                    return true;
                } catch (Exception var8) {
                    Log.d("---sdk-lockerCOD---", "connection failed: " + var8.getMessage());
                    this.disconnect();
                    return false;
                }
            }
        }
    }

    //read COD id: 01
    public CodBodData getCodBodData() {

        try {
            double bodData;
            double codData;
            double tssData;
            //cod
            byte[] bufferCod = new byte[]{8, 3, 38, 0, 0, 4, 79, -40}; // {08 03 26 00 00 04 4F D8}
            this.usbSerialPort.write(bufferCod, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatusCod = new byte[14];
            this.usbSerialPort.read(bufferStatusCod, this.READ_WAIT_MILLIS);
            checkReadCod = Utils.bytesToHex(new byte[]{bufferStatusCod[0], bufferStatusCod[1], bufferStatusCod[2]});


            //bod
            byte[] bufferBod = new byte[]{8, 3, 38, 4, 0, 2, -114, 27}; // {08 03 26 04 00 02 8E 1B}
            this.usbSerialPort.write(bufferBod, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatusBod = new byte[10];
            this.usbSerialPort.read(bufferStatusBod, this.READ_WAIT_MILLIS);
            checkReadBod = Utils.bytesToHex(new byte[]{bufferStatusBod[0], bufferStatusBod[1], bufferStatusBod[2]});


            //tss
            byte[] bufferTss = new byte[]{8, 3, 18, 0, 0, 2, -63, -22}; // {08 03 12 00 00 02 C1 EA}
            this.usbSerialPort.write(bufferTss, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatusTss = new byte[10];
            this.usbSerialPort.read(bufferStatusTss, this.READ_WAIT_MILLIS);
            checkReadTss = Utils.bytesToHex(new byte[]{bufferStatusTss[0], bufferStatusTss[1], bufferStatusTss[2]});


//            Log.d("data12=== ",checkReadBod);
//            Log.d("data13=== ",checkReadTss);

            // đọc giá trị COD
            if (checkReadCod.equals("080308") && checkReadBod.equals("080304") && checkReadTss.equals("080304")) {
//            if (checkReadCod.equals("080308")) {

                //đọc Cod
                String codString = Utils.bytesToHex(new byte[]{bufferStatusCod[10], bufferStatusCod[9], bufferStatusCod[8], bufferStatusCod[7]});
                String dataReceiveCod = "";
                for (int i = 0; i < codString.length(); i++) {
                    int k = Integer.parseInt(String.valueOf(codString.charAt(i)), 16);
                    dataReceiveCod = dataReceiveCod + String.format("%4s", Integer.toBinaryString(k)).replace(' ', '0');
                }

                String dataReceiveCod0 = String.valueOf(dataReceiveCod.charAt(0));//sign of value: 0: +    1: -
                String dataReceiveCod1 = dataReceiveCod.substring(1, 9);
                String dataReceiveCod2 = dataReceiveCod.substring(9);

                int exponentCod = Integer.parseInt(dataReceiveCod1, 2) - 127;

                String mantissaCod = "1" + dataReceiveCod2.substring(0, exponentCod);

                String tgCod = dataReceiveCod2.substring(exponentCod);
                int numberCod1 = Integer.parseInt(mantissaCod, 2);
                double numberCod2 = 0.0;

                for (int j = 0; j < tgCod.length(); j++) {
                    numberCod2 += Character.getNumericValue(tgCod.charAt(j)) * Math.pow(2, -(j + 1));
                }

                if (dataReceiveCod0.equals("0")) {
                    codData = (numberCod1 + numberCod2);
                } else codData = -(numberCod1 + numberCod2);


                //đọc giá trị bod
                String bodString = Utils.bytesToHex(new byte[]{bufferStatusBod[6], bufferStatusBod[5], bufferStatusBod[4], bufferStatusBod[3]});
                String dataReceiveBod = "";
                for (int i = 0; i < bodString.length(); i++) {
                    int k = Integer.parseInt(String.valueOf(bodString.charAt(i)), 16);
                    dataReceiveBod = dataReceiveBod + String.format("%4s", Integer.toBinaryString(k)).replace(' ', '0');
                }

                String dataReceiveBod0 = String.valueOf(dataReceiveBod.charAt(0));//sign of value: 0: +    1: -
                String dataReceiveBod1 = dataReceiveBod.substring(1, 9);
                String dataReceiveBod2 = dataReceiveBod.substring(9);

                int exponentBod = Integer.parseInt(dataReceiveBod1, 2) - 127;

                String mantissaBod = "1" + dataReceiveBod2.substring(0, exponentBod);

                String tgBod = dataReceiveBod2.substring(exponentBod);
                int numberBod1 = Integer.parseInt(mantissaBod, 2);
                double numberBod2 = 0.0;

                for (int j = 0; j < tgBod.length(); j++) {
                    numberBod2 += Character.getNumericValue(tgBod.charAt(j)) * Math.pow(2, -(j + 1));
                }

                if (dataReceiveBod0.equals("0")) {
                    bodData = numberBod1 + numberBod2;
                } else bodData = -(numberBod1 + numberBod2);


                //đọc giá trị tss ======
                String tssString = Utils.bytesToHex(new byte[]{bufferStatusTss[6], bufferStatusTss[5], bufferStatusTss[4], bufferStatusTss[3]});
                if (tssString.equals("00000000")) {
                    tssData = 0.0;
                } else {
                    String dataReceiveTss = "";
                    for (int i = 0; i < tssString.length(); i++) {
                        int k = Integer.parseInt(String.valueOf(bodString.charAt(i)), 16);
                        dataReceiveTss = dataReceiveTss + String.format("%4s", Integer.toBinaryString(k)).replace(' ', '0');
                    }

                    String dataReceiveTss0 = String.valueOf(dataReceiveTss.charAt(0));//sign of value: 0: +    1: -
                    String dataReceiveTss1 = dataReceiveTss.substring(1, 9);
                    String dataReceiveTss2 = dataReceiveTss.substring(9);

                    int exponentTss = Integer.parseInt(dataReceiveTss1, 2) - 127;

                    String mantissaTss = "1" + dataReceiveTss2.substring(0, exponentTss);

                    String tgTss = dataReceiveTss2.substring(exponentTss);
                    int numberTss1 = Integer.parseInt(mantissaTss, 2);
                    double numberTss2 = 0.0;

                    for (int j = 0; j < tgTss.length(); j++) {
                        numberTss2 += Character.getNumericValue(tgTss.charAt(j)) * Math.pow(2, -(j + 1));
                    }

                    if (dataReceiveTss0.equals("0")) {
                        tssData = numberTss1 + numberTss2;
                    } else tssData = -(numberTss1 + numberTss2);

                    //            Log.d("data11=== ", Arrays.toString(bufferStatusCod));
//            Log.d("data12=== ", Arrays.toString(bufferStatusBod));
//            Log.d("data13=== ", Arrays.toString(bufferStatusTss));
                }

                this.disconnect();

                return new CodBodData(codData, bodData, tssData);
            } else {
                this.disconnect();
                return null;
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            return null;
        }
    }


    public void disconnect() {
        this.connected = false;

        try {
            this.usbSerialPort.close();
        } catch (IOException var2) {
        }

        this.usbSerialPort = null;
    }
}
