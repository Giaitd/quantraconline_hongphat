import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/view/calibartion_screen/calibration.dart';
import 'package:quantrac_online_hongphat/view/history_screen/history.dart';
import 'package:quantrac_online_hongphat/view/notification_screen/notification.dart';
import 'package:quantrac_online_hongphat/view/qrcode/generate_qrcode.dart';
import 'package:quantrac_online_hongphat/view/setup_screen/setup.dart';
import '../../api/api_service.dart';
import '../../api/duLieuQuanTrac_model.dart';
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
  late DuLieuQuanTracModel duLieuQuanTracModel;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<Data> menu = [
    Data(
      title: 'Thông báo',
      screen: const NotificationScreen(),
    ),
    Data(
      title: 'Nhật ký',
      screen: HistoryScreen(),
    ),
    Data(
      title: 'Cài đặt cảnh báo',
      screen: const SetupScreen(),
    ),
    Data(
      title: 'Hiệu chuẩn đầu đo',
      screen: const Calibration(),
    ),
    Data(
      title: 'QRCode',
      screen: const GenerateQRCode(),
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
                  height: 420 / sizeDevice,
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
                              if (index == 1) {
                                APIService apiService = APIService();
                                duLieuQuanTracModel = DuLieuQuanTracModel();
                                apiService.getDuLieu(duLieuQuanTracModel);

                                //delay 1s để load dataQuanTracList
                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  globals.listData.clear();
                                  for (int i =
                                          globals.dataQuanTracList.length - 1;
                                      i > 0;
                                      i--) {
                                    //giới hạn data xem trên thiết bị là 200 data mới nhất
                                    if (globals.listData.length < 200) {
                                      globals.listData
                                          .add(globals.dataQuanTracList[i]);
                                    } else {
                                      break;
                                    }
                                  }

                                  //vào giao diện dữ liệu quan trắc
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => data.screen));
                                });
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => data.screen));
                              }
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
                  keyboardType: TextInputType.number,
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
