import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ph_controller_hongphat/globals/globals.dart';
import 'package:ph_controller_hongphat/view/main_screen/main_screen.dart';

class UserGuide extends StatefulWidget {
  const UserGuide({Key? key}) : super(key: key);

  @override
  State<UserGuide> createState() => _UserGuideState();
}

class _UserGuideState extends State<UserGuide> {
  Globals globals = Get.put(Globals());
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
                    child: Text('Hướng dẫn sử dụng',
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  5 / sizeDevice, 0, 5 / sizeDevice, 0),
              child: SizedBox(
                height: 675 / sizeDevice,
                width: 1340 / sizeDevice,
                child: Image.asset(
                  'assets/images/user_guide_picture.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
