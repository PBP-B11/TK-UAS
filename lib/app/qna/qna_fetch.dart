import 'package:my_panel/app/qna/qna_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

Future<List<QnaModels>> fetchQna(CookieRequest request) async {
  var response =
      await request.get('https://mypanel.up.railway.app/qna/show_question_json');

  List<QnaModels> listQna= [];

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  print(data);

  List<dynamic> listData = data["data"];
  for (int i = 0; i < listData.length; i++) {
    var d = listData[i];
    if (d != null) {
      listQna.add(QnaModels.fromJson(d));
    }
  }

  return listQna;
}