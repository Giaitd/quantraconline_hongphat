import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/view/popup_screen/popup_screen.dart';
import '../../globals/globals.dart';
import '../../globals/secure_storage.dart';

class CalibrationpH extends StatefulWidget {
  const CalibrationpH({Key? key}) : super(key: key);

  @override
  State<CalibrationpH> createState() => _CalibrationpHState();
}

class _CalibrationpHState extends State<CalibrationpH> {
  Globals globals = Get.put(Globals());
  SecureStorage storage = Get.put(SecureStorage());
  late Timer timer1;

  @override
  void initState() {
    super.initState();
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      globals.calibrationPH();
      globals.calibpHZero.value = false;
      globals.calibpHSlopeLo.value = false;
      globals.calibpHSlopeHi.value = false;
    });
  }

  @override
  void dispose() {
    timer1.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;

    return Obx(
      () => Container(
        width: 1365 / sizeDevice,
        height: 580 / sizeDevice,
        margin: EdgeInsets.fromLTRB(
            40 / sizeDevice, 30 / sizeDevice, 40 / sizeDevice, 0),
        child: Column(children: [
          //text hướng dẫn
          Text(
            "- Rửa sạch đầu đo với nước sạch hoặc nước cất sau đó thấm khô trước khi cho vào dung dịch hiệu chuẩn (không được lau)",
            style: TextStyle(
                fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Sử dụng đúng dung dịch dùng để hiệu chuẩn (nếu sử dụng sai dung dịch có thể dẫn đến hỏng hóc không khắc phục được). Chờ 5 phút để kết quả ổn định. Sau đó hiệu chuẩn nếu kết quả sai lệch.",
            style: TextStyle(
                fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50 / sizeDevice, 10 / sizeDevice, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "+ Dung dịch chuẩn pH 6.86: Hiệu chuẩn điểm không - zero",
                  style: TextStyle(
                      fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(height: 7 / sizeDevice),
                Text(
                  "+ Dung dịch chuẩn pH 4.01: Hiệu chuẩn điểm dốc - slope nếu cần đo mẫu có tính axit",
                  style: TextStyle(
                      fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(height: 7 / sizeDevice),
                Text(
                  "+ Dung dịch chuẩn pH 9.18: Hiệu chuẩn điểm dốc - slope nếu cần đo mẫu có tính kiềm",
                  style: TextStyle(
                      fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          //nhập thông số
          Container(
            margin: EdgeInsets.fromLTRB(0, 30 / sizeDevice, 0, 0),
            // height: 235/sizeDevice,
            child: Row(children: [
              Container(
                width: 382 / sizeDevice,
                height: 235 / sizeDevice,
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Column(children: [
                  //pH =======
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        12 / sizeDevice, 24 / sizeDevice, 27 / sizeDevice, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 183 / sizeDevice,
                          height: 80 / sizeDevice,
                          alignment: Alignment.center,
                          child: Text(
                            "pH",
                            style: TextStyle(
                                fontSize: 28 / sizeDevice,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 160 / sizeDevice,
                          height: 80 / sizeDevice,
                          alignment: Alignment.center,
                          child: Text(
                            "${globals.pH.value}",
                            style: TextStyle(
                              fontSize: 34 / sizeDevice,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black, width: 1 / sizeDevice)),
                        ),
                      ],
                    ),
                  ),

                  //offset pH
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        12 / sizeDevice, 24 / sizeDevice, 27 / sizeDevice, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 183 / sizeDevice,
                          height: 80 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 9 / sizeDevice),
                              Text(
                                "Offset",
                                style: TextStyle(
                                    fontSize: 26 / sizeDevice,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(-0.5 -> 0.5)",
                                style: TextStyle(
                                    fontSize: 26 / sizeDevice,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 160 / sizeDevice,
                          height: 80 / sizeDevice,
                          child: TextFormField(
                            enabled: (!globals.lockDevice.value),
                            textAlign: TextAlign.center,
                            onChanged: (text) {
                              if (double.parse(text) < -0.5 ||
                                  double.parse(text) > 0.5) {
                                PopupScreen().anounDialog(context);
                              } else {
                                globals.offsetpH.value = double.parse(text);
                                storage.writeDataSetup(7);
                                storage.readDataSetup(7);
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "${globals.mapSetup["offsetpH"]}",
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero)),
                            style: TextStyle(
                              fontSize: 34 / sizeDevice,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Container(width: 14 / sizeDevice),
              Container(
                width: 889 / sizeDevice,
                height: 235 / sizeDevice,
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Row(children: [
                  //hiệu chuẩn pH điểm 0
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        29 / sizeDevice, 32 / sizeDevice, 0, 0),
                    width: 250 / sizeDevice,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          if (globals.lockDevice.value == false) {
                            setState(() {
                              globals.calibpHZero.value = true;
                              globals.lockDevice.value = true;
                            });
                          } else {
                            PopupScreen().requiredInputPassword(context);
                          }
                        },
                        child: Container(
                          height: 100 / sizeDevice,
                          width: 250 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 15 / sizeDevice),
                              Text(
                                "Hiệu chuẩn",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: globals.calibpHZero.value == true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                "điểm 0",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: globals.calibpHZero.value == true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4657ef)),
                      ),
                      SizedBox(height: 20 / sizeDevice),
                      Text("Sử dụng dung dịch chuẩn pH 6.86",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24 / sizeDevice,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),

                  // hiệu chuẩn pH4.01
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        40 / sizeDevice, 32 / sizeDevice, 0, 0),
                    width: 250 / sizeDevice,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          if (globals.lockDevice.value == false) {
                            setState(() {
                              globals.calibpHSlopeLo.value = true;
                              globals.lockDevice.value = true;
                            });
                          } else {
                            PopupScreen().requiredInputPassword(context);
                          }
                        },
                        child: Container(
                          height: 100 / sizeDevice,
                          width: 250 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 15 / sizeDevice),
                              Text(
                                "Hiệu chuẩn",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: globals.calibpHSlopeLo.value == true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                "slope - pH 4.01",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: globals.calibpHSlopeLo.value == true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4657ef)),
                      ),
                      SizedBox(height: 20 / sizeDevice),
                      Text("Sử dụng dung dịch chuẩn pH 4.01",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24 / sizeDevice,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),

                  // hiệu chuẩn pH9.18
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        40 / sizeDevice, 32 / sizeDevice, 0, 0),
                    width: 250 / sizeDevice,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          if (globals.lockDevice.value == false) {
                            setState(() {
                              globals.calibpHSlopeHi.value = true;
                              globals.lockDevice.value = true;
                            });
                          } else {
                            PopupScreen().requiredInputPassword(context);
                          }
                        },
                        child: Container(
                          height: 100 / sizeDevice,
                          width: 250 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 15 / sizeDevice),
                              Text(
                                "Hiệu chuẩn",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: globals.calibpHSlopeHi.value == true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                "slope - pH 9.18",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: globals.calibpHSlopeHi.value == true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4657ef)),
                      ),
                      SizedBox(height: 20 / sizeDevice),
                      Text("Sử dụng dung dịch chuẩn pH 9.18",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24 / sizeDevice,
                              fontWeight: FontWeight.bold))
                    ]),
                  )
                ]),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
