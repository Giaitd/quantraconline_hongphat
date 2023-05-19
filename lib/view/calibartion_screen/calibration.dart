import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ph_controller_hongphat/view/calibartion_screen/calibration_cod.dart';
import 'package:ph_controller_hongphat/view/calibartion_screen/calibration_nh4.dart';
import 'package:ph_controller_hongphat/view/calibartion_screen/calibration_ph.dart';
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
  int _number = 0;

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
                      color: Colors.white,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: IconButton(
                          onPressed: () {
                            globals.lockDevice.value = true;
                            Navigator.pushReplacement(
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
                        child: Text('Hiệu chuẩn đầu đo',
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
                      color: Colors.white,
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
                SizedBox(
                  height: 700 / sizeDevice,
                  width: 1365 / sizeDevice,
                  child: Column(
                    children: [
                      Container(
                        height: 90 / sizeDevice,
                        width: 1365 / sizeDevice,
                        color: const Color.fromARGB(211, 211, 211, 211),
                        child: Row(
                          children: [
                            //Hiệu chuẩn đầu đo pH
                            SizedBox(
                              width: 455 / sizeDevice,
                              height: 90 / sizeDevice,
                              child: Column(children: [
                                SizedBox(height: 24 / sizeDevice),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _number = 0;
                                    });
                                  },
                                  child: Text(
                                    "Đầu đo pH",
                                    style: TextStyle(
                                        fontSize: 34 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: _number == 0
                                            ? const Color.fromARGB(
                                                255, 5, 148, 10)
                                            : Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 7 / sizeDevice, 0, 0),
                                ),
                                _number == 0
                                    ? Container(
                                        height: 5 / sizeDevice,
                                        width: 170 / sizeDevice,
                                        color: Colors.orange,
                                      )
                                    : Container()
                              ]),
                            ),
                            //Hiệu chuẩn cod, bod
                            SizedBox(
                              width: 455 / sizeDevice,
                              height: 90 / sizeDevice,
                              child: Column(children: [
                                SizedBox(height: 24 / sizeDevice),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _number = 1;
                                    });
                                  },
                                  child: Text(
                                    "Đầu đo COD, BOD, TSS",
                                    style: TextStyle(
                                        fontSize: 34 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: _number == 1
                                            ? const Color.fromARGB(
                                                255, 5, 148, 10)
                                            : Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 7 / sizeDevice, 0, 0),
                                ),
                                _number == 1
                                    ? Container(
                                        height: 5 / sizeDevice,
                                        width: 350 / sizeDevice,
                                        color: Colors.orange,
                                      )
                                    : Container()
                              ]),
                            ),
                            //Hiệu chuẩn nh4
                            SizedBox(
                              width: 455 / sizeDevice,
                              height: 90 / sizeDevice,
                              child: Column(children: [
                                SizedBox(height: 24 / sizeDevice),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _number = 2;
                                    });
                                  },
                                  child: Text(
                                    "Đầu đo NH4+",
                                    style: TextStyle(
                                        fontSize: 34 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: _number == 2
                                            ? const Color.fromARGB(
                                                255, 5, 148, 10)
                                            : Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 7 / sizeDevice, 0, 0),
                                ),
                                _number == 2
                                    ? Container(
                                        height: 5 / sizeDevice,
                                        width: 210 / sizeDevice,
                                        color: Colors.orange,
                                      )
                                    : Container()
                              ]),
                            ),
                          ],
                        ),
                      ),
                      _number == 0
                          // ignore: prefer_const_constructors
                          ? CalibrationpH()
                          // ignore: prefer_const_constructors
                          : (_number == 1 ? CalibrationCOD() : CalibrationNH4())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
