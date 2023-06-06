import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../globals/globals.dart';
import '../main_screen/main_screen.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  Globals globals = Get.put(Globals());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;
    var a = {"androidboxInfo": "01233210", "serial": "0125"};

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
                    child: Text('Mã QR Code của thiết bị',
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
            Container(
              height: 100 / sizeDevice,
            ),
            Center(
              child: QrImage(
                data: a.toString(),
                size: 250 / sizeDevice,
                version: QrVersions.auto,
                eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square, color: Colors.black),
                // embeddedImage: AssetImage(imagePath[0]),
                // embeddedImageStyle: QrEmbeddedImageStyle(
                //     size: Size(200 / sizeDevice, 200 / sizeDevice)),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 100 / sizeDevice, 0, 0),
              height: 200 / sizeDevice,
              child: Text(
                'Quét mã QRcode này để thêm thiết bị vào hệ thống',
                style: TextStyle(fontSize: 32 / sizeDevice),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
