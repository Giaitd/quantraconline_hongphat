// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Globals extends GetxService {
  RxDouble sizeDevice = 1.0.obs;

  //set id
  RxInt idOld = 6.obs;
  RxInt idNew = 7.obs;
  RxBool setID = false.obs;
  RxBool offSetID = false.obs;
  RxBool lockDevice = true.obs;

  //data setup
  RxDouble pHMinSet = 6.5.obs;
  RxDouble pHMaxSet = 8.5.obs;
  RxDouble codSet = 100.0.obs;
  RxDouble bodSet = 50.0.obs;
  RxDouble tssSet = 100.0.obs;
  RxDouble nh4Set = 10.0.obs;

  //data quan trắc
  RxDouble pH = 7.0.obs;
  RxDouble temp = 27.7.obs;
  RxDouble cod = 100.95.obs;
  RxDouble bod = 90.05.obs;
  RxDouble tss = 75.12.obs;
  RxDouble nh4 = 0.59.obs;

  //topic pub data to app mobile
  RxString pubTopicSet = "quantracdaura".obs;

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
    //ph1
    "pHMinSet": "6.5",
    "pHMaxSet": "8.5",
    "codSet": "100.0",
    "bodSet": "50.0",
    "tssSet": "100.0",
    "nh4Set": "10.0",
    "pubTopicSet": "quantracdaura",
  }.obs;

  List<String> keySetup = [
    "pHMinSet",
    "pHMaxSet",
    "codSet",
    "bodSet",
    "tssSet",
    "nh4Set",
    "pubTopicSet",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    mqttConnect();

    Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      _getData();
      _convertData();
      publishMqtt();
    });
  }

  /// ============ MethodChannel=== send/get data to/from native ====================== */

  static const platform = MethodChannel('giaitd.com/data');

  //send data setup to native code
  Future<void> setData() async {
    var sendDataToNative = <String, dynamic>{
      "pHMinSet": double.parse(mapSetup["pHMinSet"]),
      "pHMaxSet": double.parse(mapSetup["pHMaxSet"]),
      "codSet": double.parse(mapSetup["codSet"]),
      "bodSet": double.parse(mapSetup["bodSet"]),
      "tssSet": double.parse(mapSetup["tssSet"]),
      "nh4Set": double.parse(mapSetup["nh4Set"]),
    };

    try {
      await platform.invokeMethod('dataToNative', sendDataToNative);
    } on PlatformException catch (e) {
      print(e);
    }
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

  //mqtt ===============================================================================================================================================================
  final client = MqttServerClient('broker.emqx.io', '');
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
            "androidBoxInfo.value") //must be unique for each device
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

    String subTopic = "androidBoxInfo.value";
    client.subscribe(subTopic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      Map<String, dynamic> json = jsonDecode(pt);
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

    client.subscribe(pubTopic, MqttQos.exactlyOnce);

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
