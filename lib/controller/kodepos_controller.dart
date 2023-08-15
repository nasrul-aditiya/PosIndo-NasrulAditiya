import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/kodepos_model.dart';

class KodePosController {
  String url = "https://kodepos.vercel.app/search/?q=";
  Future<Map<String, dynamic>> searchKodePos(String key) async {
    String targetUrl = "$url$key";
    // try {
    var response = await http.get(Uri.parse(targetUrl));
    if (response.statusCode == 200) {
      var converted = jsonDecode(response.body);
      List<KodePosModel> daftarKodePos = [];
      for (var k in converted["data"]) {
        daftarKodePos.add(KodePosModel.fromJson(k));
      }
      return {"status": 200, "data": daftarKodePos};
    } else {
      return {
        "status": 500,
        "message":
            "Tidak ditemukan : ${response.statusCode} -> ${response.body}"
      };
    }
  }
}
