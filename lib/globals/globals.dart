// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Globals extends GetxService {
  RxDouble sizeDevice = 1.0.obs;

  //set id
  RxInt idOld = 6.obs;
  RxInt idNew = 7.obs;
  RxBool setID = false.obs;
  RxBool offSetID = false.obs;
  RxBool lockDevice = true.obs;

  //data quan trắc
  RxDouble pH = 7.0.obs;
  RxDouble temp = 27.7.obs;
  RxDouble cod = 100.95.obs;
  RxDouble bod = 90.05.obs;
  RxDouble tss = 75.12.obs;
  RxDouble nh4 = 0.59.obs;

  //DIDO
  RxInt valueDO0 = 0.obs;
  RxInt valueDO1 = 0.obs;
  RxInt valueDO2 = 0.obs;

  RxList<bool> q0 =
      [false, false, false, false, false, false, false, false].obs;
  RxList<bool> q1 =
      [false, false, false, false, false, false, false, false].obs;
  RxList<bool> q2 =
      [false, false, false, false, false, false, false, false].obs;
  List<bool> q3 = List.filled(5, false);

  /// //data save for setup parameter
  //pH1
  Map<String, dynamic> mapSetup = {
    //ph1
    "axitSet1": "7.1",
    "bazoSet1": "6.1",
    "alarmSet1": "0.1",
    "controlAxit1": "1",
    "controlBazo1": "1",
  }.obs;

  List<String> keySetup = [
    //pH1
    "axitSet1",
    "bazoSet1",
    "alarmSet1",
    "controlAxit1",
    "controlBazo1",
  ].obs;

  @override
  void onInit() {
    super.onInit();

    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      _getData();
      _convertData();
    });
  }

  /// ============ MethodChannel=== send/get data to/from native ====================== */

  static const platform = MethodChannel('giaitd.com/data');

  //set data to native code
  Future<void> setData() async {
    // var sendDataToNative = <String, dynamic>{
    //   //pH1
    //   "axitSet1": double.parse(mapSetup["axitSet1"]),
    //   "bazoSet1": double.parse(mapSetup["bazoSet1"]),
    //   "controlAxit1": int.parse(mapSetup["controlAxit1"]),
    //   "controlBazo1": int.parse(mapSetup["controlBazo1"]),
    // };

    // try {
    //   await platform.invokeMethod('dataToNative', sendDataToNative);
    // } on PlatformException catch (e) {
    //   print(e);
    // }
  }

  // Future<void> setupID() async {
  //   var sendDataToNative9 = <String, dynamic>{
  //     //id
  //     "idOld": idOld.value,
  //     "idNew": idNew.value,
  //     "btnSetId": setID.value,
  //   };

  //   try {
  //     await platform.invokeMethod('dataToNative9', sendDataToNative9);
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }

  //get data from native code
  Future<void> _getData() async {
    Map<dynamic, dynamic> getDataValues = {};

    try {
      getDataValues = await platform.invokeMethod('getData');
      pH.value = getDataValues['getpH'];
      temp.value = getDataValues['getTemp'];
      cod.value = getDataValues['getCod'];
      bod.value = getDataValues['getBod'];
      tss.value = getDataValues['getTss'];
      nh4.value = getDataValues['getNh4'];

      valueDO0.value = getDataValues['getDO0'];
      valueDO1.value = getDataValues['getDO1'];
      valueDO2.value = getDataValues['getDO2'];
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _convertData() async {
    for (int i = 0; i < 8; i++) {
      q0[i] = (valueDO0 & (1 << i)) != 0;
      q1[i] = (valueDO1 & (1 << i)) != 0;
      q2[i] = (valueDO2 & (1 << i)) != 0;
    }
  }
}
