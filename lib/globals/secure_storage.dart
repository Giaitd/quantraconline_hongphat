import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/globals/globals.dart';
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
      globals.offsetpH.value.toString(),
      globals.offsetCOD.value.toString(),
      globals.offsetNH4.value.toString(),
      globals.thietBiId.value,
      globals.mqttServerSet.value,
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
