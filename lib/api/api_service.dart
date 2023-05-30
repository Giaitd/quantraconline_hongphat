import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quantrac_online_hongphat/api/duLieuQuanTrac_model.dart';

class APIService {
  //dữ liệu quan trắc
  Future<http.Response> addDuLieu(DuLieuQuanTracModel requestModel) async {
    String url = "http://192.168.0.120:8000/hongphat/themDuLieuQuanTrac";

    var url_uri = Uri.parse(url);
    final response = await http.post(
      url_uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel),
    );
    return response;
  }

  // Future<http.Response> getDuLieu(DuLieuQuanTracModel requestModel) async {
  //   String url =
  //       "http://192.168.0.120:8000/hongphat/layDanhSachViTri?diaChiId=${global.diaChi_Id.value}";
  //   // String url = "https://jsonplaceholder.typicode.com/posts?id=2";
  //   var url_uri = Uri.parse(url);

  //   final response = await http.get(
  //     url_uri,
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   var a = json.decode(response.body);

  //   global.checkBoxViTriList.clear();

  //   for (var element in a) {
  //     global.checkBoxViTriList.add({
  //       // "id": element["_id"],
  //       "value": false,
  //       "title": element["ten"],
  //       "maViTri": element["ma"],
  //     });
  //   }

  //   return response;
  // }

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
