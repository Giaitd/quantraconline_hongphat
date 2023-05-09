import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ph_controller_hongphat/globals/globals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage extends GetxService {
  final storage = const FlutterSecureStorage();

  Globals globals = Get.put(Globals());

  /// ================ secure storage ==================**/

  //read/write data setup
  //pH1-----------------------------------------------
  //write
  Future<void> writeDataSetup(int i) async {
    List<dynamic> values = [
      //pH1
      // globals.axitSet1.value.toString(),
      // globals.bazoSet1.value.toString(),
      // globals.alarmSet1.value.toString(),
      // globals.controlAxit1.value.toString(),
      // globals.controlBazo1.value.toString(),
    ];
    await storage.write(
      key: globals.keySetup[i],
      value: values[i],
      aOptions: _getAndroidOptions(),
    );
  }

  //read
  Future<void> readDataSetup(int i) async {
    globals.mapSetup[globals.keySetup[i]] = (await storage.read(
      key: globals.keySetup[i],
      aOptions: _getAndroidOptions(),
    ))!;
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
