import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/city.dart';
import '../models/config.dart';

class CityProvider with ChangeNotifier {
  List<City> cities = [];

  List<City> get getCities {
    return cities;
  }

  getCitiesFN() async {
    Uri url = Uri.parse(selectCityPath);

    var response = await http.post(url);
    var responseBody = await jsonDecode(response.body);

    if (responseBody['statu'] == 'success') {
      for (var element in responseBody['data']) {
        cities.add(
          City(
            cityId: element['city_id'],
            cityName: {
              'en': element['city_nameEn'],
              'ar': element['city_nameAr'],
              'tr': element['city_nameTr'],
              'Fr': element['city_nameFr'],
              // 'ar': element['city_nameAr'],
            },
            cityState: element['city_state'] == 1 ? true : false,
            cityCreate: DateTime.parse(
              element['city_create'],
            ),
          ),
        );
      }
      notifyListeners();
    }
  }
}
