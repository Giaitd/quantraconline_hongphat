import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ph_controller_hongphat/view/main_screen/thongso_quantrac.dart';
import 'package:ph_controller_hongphat/view/popup_screen/popup_screen.dart';
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

  @override
  void initState() {
    // for (int i = 0; i < globals.keySetup.length; i++) {
    // storage.readDataSetup(i);
    // }

    // Future.delayed(const Duration(seconds: 5), (() {
    //   globals.setData();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 212, 212),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        child: Column(
          children: [
            Container(
              height: 120 / sizeDevice,
              width: 1365 / sizeDevice,
              child: Row(
                children: [
                  Container(width: 160 / sizeDevice),
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
            ThongSoQuanTrac(),
          ],
        ),
      ),
    );
  }
}