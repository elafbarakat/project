import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/config.dart';
import '../models/type_of_HDYKATC.dart';

class TypeOfHDYKATCProvider with ChangeNotifier {
  List<TypeOfHDYKATC> hdykatc = [];

  List<TypeOfHDYKATC> get hdykatcGet {
    return hdykatc;
  }

  getHDYKATCFN() async {
    Uri url = Uri.parse(selectTypeOfHDYKATCPath);

    var response = await http.post(url);
    var responseBody = await jsonDecode(response.body);

    if (responseBody['statu'] == 'success') {
      for (var element in responseBody['data']) {
        hdykatc.add(
          TypeOfHDYKATC(
            id: element['id'],
            title: {
              'en': element['titleEn'],
              'ar': element['titleAr'],
            },
            state: element['state'] == 1 ? true : false,
            dateCreate: DateTime.parse(
              element['dateCreate'],
            ),
          ),
        );
      }
    }
    notifyListeners();
  }
}
