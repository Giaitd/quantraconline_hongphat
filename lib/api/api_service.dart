import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quantrac_online_hongphat/api/duLieuQuanTrac_model.dart';
import 'package:quantrac_online_hongphat/globals/globals.dart';

class APIService {
  Globals global = Get.put(Globals());
  //thêm dữ liệu quan trắc
  Future<http.Response> addDuLieu(DuLieuQuanTracModel requestModel) async {
    String url = "http://192.168.0.120:8000/hongphat/themDuLieuQuanTrac";

    var urlUri = Uri.parse(url);
    final response = await http.post(
      urlUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel),
    );
    return response;
  }

  //lấy dữ liệu quan trắc
  Future<http.Response> getDuLieu(DuLieuQuanTracModel requestModel) async {
    String url =
        "http://192.168.0.120:8000/hongphat/layDuLieuQuanTrac?thietBiId=${global.mapSetup["thietBiId"]}";
    var urlUri = Uri.parse(url);

    final response = await http.get(
      urlUri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var a = json.decode(response.body);

    global.pHDataList.clear();
    global.dataQuanTracList.clear();

    for (var element in a) {
      //xóa bớt ký tự k cần thiết ở dữ liệu time
      String m = (element["ngayTao"]).toString().replaceRange(10, 11, '     ');
      String dateTime = m.replaceRange(23, null, '');
      global.dataQuanTracList.add({
        dateTime,
        element["pH"],
        element["cod"],
        element["bod"],
        // element["tss"],
        0.00, //đợi test thực tế xem đầu đo COD có đo đc TSS không. hiện tại giá trị TSS = BOD, dữ liệu nhận đc chỉ 1 thay vì phải nhận đc cả giá trị TSS và BOD
        element["nh4"],
        element["temp"],
      });
      // global.pHDataList.add({
      //   "pH": element["pH"],
      //   "time": element["ngayTao"],
      // });
    }

    return response;
  }

  // Future<http.Response> deleteDuLieu(DuLieuQuanTracModel requestModel) async {
  //   String url = "http://192.168.0.120:8000/hongphat/xoaDuLieu";
  //   var url_uri = Uri.parse(url);

  //   final response = await http.delete(
  //     url_uri,
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(requestModel),
  //   );
  //   return response;
  // }
}
