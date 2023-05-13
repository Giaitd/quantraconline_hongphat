import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ph_controller_hongphat/view/setup_screen/data_setup.dart';

import '../../globals/globals.dart';
import '../main_screen/main_screen.dart';
import '../popup_screen/popup_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupState();
}

class _SetupState extends State<SetupScreen> {
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
                        child: Text('Cài đặt cảnh báo',
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
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 35 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "- Thông số cảnh báo: Là giới hạn tối đa của các thông số nước thải mà đầu ra vẫn đảm bảo được tiêu chuẩn thiết kế nước thải loại A, loại B...",
                        style: TextStyle(
                          fontSize: 28 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 15 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "- Nếu giá trị quan trắc vượt quá các giới hạn này, hệ thống sẽ gửi thông tin cảnh báo về sở tài nguyên môi trường, về đơn vị sử dụng và nhà sản xuất để có phương án xử lý tiếp theo.",
                        style: TextStyle(
                          fontSize: 28 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // data setup
                    DataSetup(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
