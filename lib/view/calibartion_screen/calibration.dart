import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../globals/globals.dart';
import '../main_screen/main_screen.dart';
import '../popup_screen/popup_screen.dart';

class Calibration extends StatefulWidget {
  const Calibration({Key? key}) : super(key: key);

  @override
  State<Calibration> createState() => _CalibrationState();
}

class _CalibrationState extends State<Calibration> {
  Globals globals = Get.put(Globals());

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
                        child: Text('Hiệu chỉnh đầu đo',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
