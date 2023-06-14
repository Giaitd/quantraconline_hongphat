// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:quantrac_online_hongphat/globals/secure_storage.dart';

class Globals extends GetxService {
  RxDouble sizeDevice = 1.0.obs;

  //check timer sent data to server run
  RxBool check = false.obs;

  //androidbox info (use to this topic name to receive thietBiId)
  RxString androidBoxInfo = 'info'.obs;

  //thietBiId
  RxString thietBiId = "".obs;

  //list data
  RxList pHDataList = [].obs;
  RxList dataQuanTracList = [].obs;
  RxList<dynamic> listData = [].obs;
  //set id
  RxInt idOld = 6.obs;
  RxInt idNew = 7.obs;
  RxBool setID = false.obs;
  RxBool offSetID = false.obs;
  RxBool lockDevice = true.obs;

  //calibration
  RxBool calibpHZero = false.obs;
  RxBool calibpHSlopeLo = false.obs;
  RxBool calibpHSlopeHi = false.obs;

  RxBool calibNH4Zero = false.obs;
  RxBool calibNH4Slope = false.obs;

  RxBool calibCODDefault = false.obs;
  RxBool turnOnBrush = false.obs;
  RxBool calibCODSensor = false.obs;
  RxDouble X = 0.2.obs;
  RxDouble Y = 151.3.obs;

  //data setup
  RxDouble pHMinSet = 6.5.obs;
  RxDouble pHMaxSet = 8.5.obs;
  RxDouble codSet = 100.0.obs;
  RxDouble bodSet = 50.0.obs;
  RxDouble tssSet = 100.0.obs;
  RxDouble nh4Set = 10.0.obs;

  //data quan trắc
  RxDouble pH = 0.0.obs;
  RxDouble temp = 0.0.obs;
  RxDouble cod = 0.0.obs;
  RxDouble bod = 0.0.obs;
  RxDouble tss = 0.0.obs;
  RxDouble nh4 = 0.0.obs;

  //data offset
  RxDouble offsetpH = 0.0.obs;
  RxDouble offsetCOD = 0.0.obs;
  RxDouble offsetNH4 = 0.0.obs;

  //topic pub data to app mobile
  RxString pubTopicSet = "quantracdaura".obs;
  RxString mqttServerSet = "broker.emqx.io".obs;

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
  Map<String, dynamic> mapSetup = {
    "pHMinSet": "6.5",
    "pHMaxSet": "8.5",
    "codSet": "100.0",
    "bodSet": "50.0",
    "tssSet": "100.0",
    "nh4Set": "10.0",
    "pubTopicSet": "quantracdaura",
    "offsetpH": "0.0",
    "offsetCOD": "0.0",
    "offsetNH4": "0.0",
    "thietBiId": "64746b0adf7ac34be49ce692",
    "mqttServer": "broker.emqx.io",
  }.obs;

  List<String> keySetup = [
    "pHMinSet",
    "pHMaxSet",
    "codSet",
    "bodSet",
    "tssSet",
    "nh4Set",
    "pubTopicSet",
    "offsetpH",
    "offsetCOD",
    "offsetNH4",
    "thietBiId",
    "mqttServer",
  ].obs;
  // ignore: prefer_typing_uninitialized_variables
  var client;

  @override
  void onInit() {
    super.onInit();
    getDeviceId();
    Future.delayed(const Duration(milliseconds: 3000), () {
      mqttConnect();

      Timer.periodic(const Duration(milliseconds: 2000), (timer) {
        setDataToNative();
        _getData();
        _convertData();
        publishMqtt();
      });
    });
  }

  //get device info
  Future<void> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
      androidBoxInfo.value = deviceData.androidId!;
    }
    Future.delayed(const Duration(milliseconds: 1500), () {
      client = MqttServerClient(
          mapSetup["mqttServer"], ''); //khởi tạo client cho mqtt
    });
  }

  /// ============ MethodChannel=== send/get data to/from native ====================== */

  static const platform = MethodChannel('giaitd.com/data');

  //send data setup to native code
  Future<void> setDataToNative() async {
    var sendDataToNative = <String, dynamic>{
      "pHMinSet": double.parse(mapSetup["pHMinSet"]),
      "pHMaxSet": double.parse(mapSetup["pHMaxSet"]),
      "codSet": double.parse(mapSetup["codSet"]),
      "bodSet": double.parse(mapSetup["bodSet"]),
      "tssSet": double.parse(mapSetup["tssSet"]),
      "nh4Set": double.parse(mapSetup["nh4Set"]),
      "offsetpH": double.parse(mapSetup["offsetpH"]),
      "offsetCOD": double.parse(mapSetup["offsetCOD"]),
      "offsetNH4": double.parse(mapSetup["offsetNH4"]),
    };

    try {
      await platform.invokeMethod('dataToNative', sendDataToNative);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo PH
  Future<void> calibrationPH() async {
    var sendDataToNative1 = <String, dynamic>{
      "calibpHZero": calibpHZero.value,
      "calibpHSlopeLo": calibpHSlopeLo.value,
      "calibpHSlopeHi": calibpHSlopeHi.value,
    };

    try {
      await platform.invokeMethod('dataToNative1', sendDataToNative1);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo NH4
  Future<void> calibrationNH4() async {
    var sendDataToNative2 = <String, dynamic>{
      "calibNH4Zero": calibNH4Zero.value,
      "calibNH4Slope": calibNH4Slope.value,
    };

    try {
      await platform.invokeMethod('dataToNative2', sendDataToNative2);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo COD
  Future<void> calibrationCOD() async {
    var sendDataToNative3 = <String, dynamic>{
      "calibCODDefault": calibCODDefault.value,
      "turnOnBrush": turnOnBrush.value,
      "calibCODSensor": calibCODSensor.value,
      "x": X.value,
      "y": Y.value,
    };

    try {
      await platform.invokeMethod('dataToNative3', sendDataToNative3);
    } on PlatformException catch (e) {
      print(e);
    }
  }

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

  //mqtt ===============================================================================================================================================================
  // final client = MqttServerClient('broker.emqx.io', '');
  // final client = MqttServerClient('broker.hivemq.com', '');
  Future<void> mqttConnect() async {
    print('enable mqtt');

    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.port = 8883;
    client.secure = true;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    // client.pongCallback = pong;
    client.autoReconnect = true;

    client.onSubscribed = onSubscribed;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(
            androidBoxInfo.value) //must be unique for each device
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('client connecting....');
    client.connectionMessage = connMess;

    await client.connect();
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('client connected');
    } else {
      print(
          'connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    //subscription ========================================================
    SecureStorage storage = Get.put(SecureStorage());

    // String subTopic = androidBoxInfo.value; //khi chạy thật thì enable
    String subTopic = "20099002";

    client.subscribe(subTopic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      Map<String, dynamic> json = jsonDecode(pt);
      thietBiId.value = json['thietBiId'];
      storage.writeDataSetup(10);
      storage.readDataSetup(10);
    });
    publishMqtt();
  }

  //function publish data to mqtt
  publishMqtt() async {
    String pubTopic = mapSetup["pubTopicSet"];
    final builder = MqttClientPayloadBuilder();
    builder.addString(json.encode({
      "pH": "${pH.value}",
      "bod": "${bod.value}",
      "cod": "${cod.value}",
      "tss": "${tss.value}",
      "nh4": "${nh4.value}",
      "temp": "${temp.value}",
    }));

    // client.subscribe(pubTopic, MqttQos.exactlyOnce);

    print('EXAMPLE::Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
  }

  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  }

  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was successful');
  }

  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }
}
