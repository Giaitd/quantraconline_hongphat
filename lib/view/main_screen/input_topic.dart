import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/view/main_screen/main_screen.dart';
import '../../globals/globals.dart';
import '../../globals/secure_storage.dart';
import '../popup_screen/popup_screen.dart';

class InputTopic extends StatefulWidget {
  const InputTopic({Key? key}) : super(key: key);

  @override
  State<InputTopic> createState() => _InputTopicState();
}

class _InputTopicState extends State<InputTopic> {
  Globals globals = Get.put(Globals());
  SecureStorage storage = Get.put(SecureStorage());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;
    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 800 / sizeDevice,
            width: 1365 / sizeDevice,
            color: const Color(0xFFF0F0F0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 150 / sizeDevice,
                      height: 100 / sizeDevice,
                      color: const Color(0xFFD9D9D9),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: IconButton(
                          onPressed: () {
                            globals.lockDevice.value = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                          },
                          icon: Image.asset(
                            'assets/images/undo.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10 / sizeDevice),
                    Container(
                      width: 1045 / sizeDevice,
                      height: 100 / sizeDevice,
                      color: const Color.fromARGB(255, 16, 39, 252),
                      child: Center(
                        child: Text('Cài đặt nhà sản xuất',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Mono',
                                fontSize: 48 / sizeDevice,
                                fontWeight: FontWeight.w800)),
                      ),
                    ),
                    SizedBox(width: 10 / sizeDevice),
                    Container(
                      width: 150 / sizeDevice,
                      height: 100 / sizeDevice,
                      color: const Color(0xFFD9D9D9),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (globals.lockDevice.value == false) {
                                globals.lockDevice.value = true;
                              } else {
                                PopupScreen().inputPassword(context);
                              }
                            });
                          },
                          icon: Image.asset(
                            globals.lockDevice.value
                                ? 'assets/images/locked.png'
                                : 'assets/images/unlocked.png',
                            height: 95,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20 / sizeDevice),
                SizedBox(
                    height: 680 / sizeDevice,
                    width: 1365 / sizeDevice,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(35 / sizeDevice,
                              35 / sizeDevice, 35 / sizeDevice, 0),
                          child: Text(
                            "Nhập tên topic publish để truyền dữ liệu lên app mobile qua phương thức mqtt",
                            style: TextStyle(
                              fontSize: 28 / sizeDevice,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(150 / sizeDevice,
                              100 / sizeDevice, 150 / sizeDevice, 0),
                          child: TextFormField(
                            enabled: (!globals.lockDevice.value),
                            textAlign: TextAlign.center,
                            onChanged: (text) {
                              globals.pubTopicSet.value = text;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "${globals.mapSetup["pubTopicSet"]}",
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero)),
                            style: TextStyle(
                              fontSize: 30 / sizeDevice,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Container(
                            margin:
                                EdgeInsets.fromLTRB(0, 100 / sizeDevice, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 5, 114, 10)),
                              onPressed: () {
                                if (globals.lockDevice.value == false &&
                                    globals.pubTopicSet.value != "") {
                                  storage.writeDataSetup(6);
                                  storage.readDataSetup(6);
                                  globals.lockDevice.value = true;
                                }
                              },
                              child: Container(
                                  height: 100 / sizeDevice,
                                  width: 200 / sizeDevice,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Lưu",
                                    style: TextStyle(
                                        fontSize: 36 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
