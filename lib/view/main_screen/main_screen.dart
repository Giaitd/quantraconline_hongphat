import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/view/main_screen/input_topic.dart';
import 'package:quantrac_online_hongphat/view/main_screen/thongso_quantrac.dart';
import 'package:quantrac_online_hongphat/view/popup_screen/popup_screen.dart';
import '../../globals/globals.dart';
import '../../globals/secure_storage.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SecureStorage storage = Get.put(SecureStorage());
  Globals globals = Get.put(Globals());
  late Timer _timer;

  @override
  void initState() {
    for (int i = 0; i < globals.keySetup.length; i++) {
      storage.readDataSetup(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 212, 212),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: 120 / sizeDevice,
            width: 1365 / sizeDevice,
            child: Row(
              children: [
                SizedBox(
                  width: 160 / sizeDevice,
                  height: 120 / sizeDevice,
                  child: GestureDetector(
                    onTapDown: (_) {
                      //Detect when you click the element
                      _timer = Timer(
                        const Duration(seconds: 5),
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InputTopic()));
                        },
                      );
                    },
                    onTapUp: (_) {
                      // Detect and cancel when you lift the click
                      _timer.cancel();
                    },
                    child: Container(
                      color: const Color.fromARGB(255, 16, 39, 252),
                      height: 110 / sizeDevice,
                      width: 150 / sizeDevice,
                    ),
                  ),
                ),
                SizedBox(
                  width: 1045 / sizeDevice,
                  child: Text(
                    'Hệ thống quan trắc nước thải online',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48 / sizeDevice,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                //btn set id
                SizedBox(
                  width: 160 / sizeDevice,
                  height: 120 / sizeDevice,
                  child: IconButton(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      PopupScreen().menuOption(context);
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 70 / sizeDevice,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            color: const Color.fromARGB(255, 16, 39, 252),
          ),

          //thông số quan trắc
          const ThongSoQuanTrac(),
        ],
      ),
    );
  }
}
