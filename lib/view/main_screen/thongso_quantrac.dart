import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../globals/globals.dart';

class ThongSoQuanTrac extends StatefulWidget {
  const ThongSoQuanTrac({Key? key}) : super(key: key);

  @override
  State<ThongSoQuanTrac> createState() => _ThongSoQuanTracState();
}

class _ThongSoQuanTracState extends State<ThongSoQuanTrac> {
  Globals globals = Get.put(Globals());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;

    return Obx(
      () => SizedBox(
        height: 680 / sizeDevice,
        width: 1365 / sizeDevice,
        child: Column(
          children: [
            // pH, COD, BOD ===========================================================================
            Row(
              children: [
                Container(
                  height: 240 / sizeDevice,
                  width: 400 / sizeDevice,
                  margin: EdgeInsets.fromLTRB(
                      43 / sizeDevice, 40 / sizeDevice, 0, 0),
                  color: Colors.white,
                  child: Column(children: [
                    //tên
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          15 / sizeDevice, 15 / sizeDevice, 0, 0),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "pH",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //giá trị đo được
                    Container(
                      height: 130 / sizeDevice,
                      alignment: Alignment.center,
                      child: Text(
                        "${globals.pH.value}",
                        style: TextStyle(
                            fontSize: 60 / sizeDevice,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //đơn vị đo
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 15 / sizeDevice, 15 / sizeDevice),
                      height: 40 / sizeDevice,
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      40 / sizeDevice, 40 / sizeDevice, 0, 0),
                  color: Colors.white,
                  height: 240 / sizeDevice,
                  width: 400 / sizeDevice,
                  child: Column(children: [
                    //tên
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          15 / sizeDevice, 15 / sizeDevice, 0, 0),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "COD",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //giá trị đo được
                    Container(
                      height: 130 / sizeDevice,
                      alignment: Alignment.center,
                      child: Text(
                        "${globals.cod.value}",
                        style: TextStyle(
                            fontSize: 60 / sizeDevice,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //đơn vị đo
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 15 / sizeDevice, 15 / sizeDevice),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "mg/L",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      43 / sizeDevice, 40 / sizeDevice, 0, 0),
                  color: Colors.white,
                  height: 240 / sizeDevice,
                  width: 400 / sizeDevice,
                  child: Column(children: [
                    //tên
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          15 / sizeDevice, 15 / sizeDevice, 0, 0),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "BOD",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //giá trị đo được
                    Container(
                      height: 130 / sizeDevice,
                      alignment: Alignment.center,
                      child: Text(
                        "${globals.bod.value}",
                        style: TextStyle(
                            fontSize: 60 / sizeDevice,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //đơn vị đo
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 15 / sizeDevice, 15 / sizeDevice),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "mg/L",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ]),
                ),
              ],
            ),

            // TSS, NH$, Nhiệt độ =================================================================
            Row(
              children: [
                Container(
                  height: 240 / sizeDevice,
                  width: 400 / sizeDevice,
                  margin: EdgeInsets.fromLTRB(
                      43 / sizeDevice, 40 / sizeDevice, 0, 0),
                  color: Colors.white,
                  child: Column(children: [
                    //tên
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          15 / sizeDevice, 15 / sizeDevice, 0, 0),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "TSS",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //giá trị đo được
                    Container(
                      height: 130 / sizeDevice,
                      alignment: Alignment.center,
                      child: Text(
                        "${globals.tss.value}",
                        style: TextStyle(
                            fontSize: 60 / sizeDevice,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //đơn vị đo
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 15 / sizeDevice, 15 / sizeDevice),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "mg/L",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      40 / sizeDevice, 40 / sizeDevice, 0, 0),
                  color: Colors.white,
                  height: 240 / sizeDevice,
                  width: 400 / sizeDevice,
                  child: Column(children: [
                    //tên
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          15 / sizeDevice, 15 / sizeDevice, 0, 0),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "NH4+",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //giá trị đo được
                    Container(
                      height: 130 / sizeDevice,
                      alignment: Alignment.center,
                      child: Text(
                        "${globals.nh4.value}",
                        style: TextStyle(
                            fontSize: 60 / sizeDevice,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //đơn vị đo
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 15 / sizeDevice, 15 / sizeDevice),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "mg/L",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      43 / sizeDevice, 40 / sizeDevice, 0, 0),
                  color: Colors.white,
                  height: 240 / sizeDevice,
                  width: 400 / sizeDevice,
                  child: Column(children: [
                    //tên
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          15 / sizeDevice, 15 / sizeDevice, 0, 0),
                      height: 40 / sizeDevice,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nhiệt độ",
                        style: TextStyle(
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //giá trị đo được
                    Container(
                      height: 130 / sizeDevice,
                      alignment: Alignment.center,
                      child: Text(
                        "${globals.temp.value}",
                        style: TextStyle(
                            fontSize: 60 / sizeDevice,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //đơn vị đo
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 15 / sizeDevice, 15 / sizeDevice),
                      height: 40 / sizeDevice,
                      // width: 25 / sizeDevice,
                      alignment: Alignment.centerRight,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text(
                                "o",
                                style: TextStyle(
                                    fontSize: 22 / sizeDevice,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                              ),
                              Container(height: 5 / sizeDevice),
                            ],
                          ),
                          Text(
                            "C",
                            style: TextStyle(
                                fontSize: 30 / sizeDevice,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
