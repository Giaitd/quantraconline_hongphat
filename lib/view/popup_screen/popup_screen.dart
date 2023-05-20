import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/view/calibartion_screen/calibration.dart';
import 'package:quantrac_online_hongphat/view/history_screen/history.dart';
import 'package:quantrac_online_hongphat/view/notification_screen/notification.dart';
import 'package:quantrac_online_hongphat/view/set_id/set_id.dart';
import 'package:quantrac_online_hongphat/view/setup_screen/setup.dart';
import '../../globals/globals.dart';

class Data {
  final String title;
  Widget screen;

  Data({
    required this.title,
    required this.screen,
  });
}

class PopupScreen extends StatelessWidget {
  Globals globals = Get.put(Globals());
  PopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<Data> menu = [
    Data(
      title: 'Thông báo',
      screen: NotificationScreen(),
    ),
    Data(
      title: 'Nhật ký',
      screen: HistoryScreen(),
    ),
    Data(
      title: 'Cài đặt cảnh báo',
      screen: SetupScreen(),
    ),
    Data(
      title: 'Hiệu chuẩn đầu đo',
      screen: Calibration(),
    ),
  ];

  //Menu option
  menuOption(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text(
                'Menu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: Colors.black,
                  fontSize: 38 / globals.sizeDevice.value,
                  fontWeight: FontWeight.w600,
                ),
              ),
              children: [
                SizedBox(
                  height: 10 / sizeDevice,
                ),
                SizedBox(
                  height: 370 / sizeDevice,
                  width: 350 / sizeDevice,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      final data = menu[index];
                      return SizedBox(
                        height: 90 / sizeDevice,
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            iconColor: Colors.black,
                            leading: Image.asset(
                              'assets/images/menu$index.png',
                              height: 60 / sizeDevice,
                              fit: BoxFit.fitHeight,
                            ),
                            title: Text(
                              data.title,
                              style: TextStyle(
                                  fontSize: 32 / sizeDevice,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => data.screen));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ));
  }

  //thông số nhập sai
  anounDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                //cảnh báo
                'Cảnh báo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: const Color.fromARGB(255, 255, 0, 0),
                  fontSize: 36 / globals.sizeDevice.value,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                'Giá trị nhập không hợp lệ. Hãy nhập lại',
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: Colors.black,
                  fontSize: 26 / globals.sizeDevice.value,
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Đồng ý',
                    style: TextStyle(
                      fontFamily: 'Roboto Mono',
                      color: Colors.black,
                      fontSize: 26 / globals.sizeDevice.value,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.all(10 / globals.sizeDevice.value))),
                )
              ],
            ));
  }

  //nhập mật khẩu mở khóa trước khi hiệu chuẩn
  requiredInputPassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                //cảnh báo
                'Cảnh báo!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: const Color.fromARGB(255, 255, 0, 0),
                  fontSize: 36 / globals.sizeDevice.value,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                'Nhập mật khẩu để mở khóa trước khi tiến hành hiệu chuẩn',
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: Colors.black,
                  fontSize: 26 / globals.sizeDevice.value,
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Đồng ý',
                    style: TextStyle(
                      fontFamily: 'Roboto Mono',
                      color: Colors.black,
                      fontSize: 26 / globals.sizeDevice.value,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.all(10 / globals.sizeDevice.value))),
                )
              ],
            ));
  }

  //password level 1
  inputPassword(BuildContext context) {
    String _password = '';
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: const Color(0xFFF0F0F0),
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (text) => {
                    _password = text,
                    if (_password == '2009')
                      {
                        globals.lockDevice.value = false,
                        Navigator.pop(context),
                      }
                  },
                  autofocus: true,
                  obscureText: false,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      labelText: 'Nhập mật khẩu',
                      hintText: '****',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto Mono',
                        color: Colors.black,
                        fontSize: 24 / globals.sizeDevice.value,
                      ),
                      border: const OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'Roboto Mono',
                    color: Colors.black,
                    fontSize: 32 / globals.sizeDevice.value,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ));
  }
}
