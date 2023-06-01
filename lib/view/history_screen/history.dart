import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/view/history_screen/ph_chart.dart';
import 'package:quantrac_online_hongphat/view/history_screen/table.dart';

import '../../api/api_service.dart';
import '../../api/duLieuQuanTrac_model.dart';
import '../../globals/globals.dart';
import '../main_screen/main_screen.dart';

class HistoryScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryScreen> {
  Globals globals = Get.put(Globals());
  late DuLieuQuanTracModel duLieuQuanTracModel;
  APIService apiService = APIService();

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;
    return Scaffold(
      body: Container(
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
                  width: 1205 / sizeDevice,
                  height: 100 / sizeDevice,
                  color: const Color.fromARGB(255, 16, 39, 252),
                  child: Center(
                    child: Text('Dữ liệu quan trắc',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto Mono',
                            fontSize: 48 / sizeDevice,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20 / sizeDevice),
            SizedBox(
              height: 680 / sizeDevice,
              width: 1365 / sizeDevice,
              child: const TableData(),
            )
          ],
        ),
      ),
    );
  }
}
