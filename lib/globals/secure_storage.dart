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
      globals.pHMinSet.value.toString(),
      globals.pHMaxSet.value.toString(),
      globals.codSet.value.toString(),
      globals.bodSet.value.toString(),
      globals.tssSet.value.toString(),
      globals.nh4Set.value.toString(),
      globals.pubTopicSet.value,
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
