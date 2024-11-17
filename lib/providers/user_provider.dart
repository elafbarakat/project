import 'dart:convert';
// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/another_langauge.dart';
import '../models/config.dart';
import '../models/education.dart';
import '../models/experience.dart';
import '../models/form_registration.dart';
import '../models/skills.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User user = User(
    id: 0,
    firstName: '',
    lastName: '',
    fatherName: '',
    motherName: '',
    birthDate: DateTime.now(),
    gender: true,
    cityId: 0,
    constraint: '',
    idNumber: '',
    idCardNumber: '',
    dateCreate: DateTime.now(),
    phone: '',
    phoneSecondary: '',
    telephone: '',
    address: '',
    addressDetails: '',
    form: FormRegistration(
      id: 0,
      user_id: 0,
      date_create: DateTime.now(),
      english_fullName: '',
      breadwinner: 0,
      marital_status: 1,
      disability: 0,
      disability_type: 1,
      disability_precentage: 0,
      family_number: 0,
      families_ofMartyrs: false,
      serving_theflag: 1,
      HDYKATC_another: '',
      housing_status: 1,
      level_ofEducation: 1,
      english_level: 1,
      ICDL: false,
      anotherLanguage: [],
      skills: [],
      education: [],
      experience: [],
      hdykatc: [],
    ),
  );

  User get getUser {
    return user;
  }

  Future newUserFN({required User userInfo}) async {
    Uri url = Uri.parse(insertUserPath);

    Map<String, String> data = {
      'user_firstName': userInfo.firstName,
      'user_lastName': userInfo.lastName,
      'user_fatherName': userInfo.fatherName,
      'user_motherName': userInfo.motherName,
      'user_birthDate': userInfo.birthDate.toString(),
      'user_cityId': userInfo.cityId.toString(),
      'user_constraint': userInfo.constraint,
      'user_idNumber': userInfo.idNumber,
      'user_idCardNumber': userInfo.idCardNumber,
      'user_personalImagePath': 'user_personalImagePath',
      'user_frontCardImagePath': 'user_frontCardImagePath',
      'user_backCardImagePath': 'user_backCardImagePath',
    };
    var response = await http.post(url, body: data);
    var responseBody = await jsonDecode(response.body);
    if (responseBody['statu'] == 'success') {
      user = userInfo;
    } else {}
    notifyListeners();
  }

  bool isLoading = false;
  bool get getIsLoading {
    return isLoading;
  }

  Future<bool> newUserWithImage({
    required User userInfo,
    // required File personalImage,
  }) async {
    isLoading = true;
    notifyListeners();

    bool resulState = false;

    Uri url = Uri.parse(insertUserPath);

    var request = http.MultipartRequest("POST", url);

    request.fields["user_firstName"] = userInfo.firstName.toString();
    request.fields["user_lastName"] = userInfo.lastName.toString();
    request.fields["user_fatherName"] = userInfo.fatherName.toString();
    request.fields["user_motherName"] = userInfo.motherName.toString();
    request.fields["user_birthDate"] = userInfo.birthDate.toString();
    request.fields["user_cityId"] = userInfo.cityId.toString();
    request.fields["user_constraint"] = userInfo.constraint.toString();
    request.fields["user_idNumber"] = userInfo.idNumber.toString();
    request.fields["user_idCardNumber"] = userInfo.idCardNumber.toString();
    request.fields["user_gender"] = userInfo.gender ? '1' : '0';
    request.fields["user_phone"] = userInfo.phone.toString();
    request.fields["user_phoneSecondary"] = userInfo.phoneSecondary.toString();
    request.fields["user_telephone"] = userInfo.telephone.toString();
    request.fields["user_address"] = userInfo.address.toString();
    request.fields["user_addressDetails"] = userInfo.addressDetails.toString();

    // form feild
    request.fields["english_fullName"] = user.form.english_fullName;
    request.fields["date_create"] =
        user.form.date_create.toString().substring(0, 10);
    request.fields["breadwinner"] = user.form.breadwinner.toString();
    request.fields["marital_status"] = user.form.marital_status.toString();
    request.fields["disability"] = user.form.disability.toString();
    request.fields["disability_type"] = user.form.disability_type.toString();
    request.fields["disability_precentage"] =
        user.form.disability_precentage.toString();
    request.fields["family_number"] = user.form.family_number.toString();
    request.fields["families_ofMartyrs"] =
        user.form.families_ofMartyrs ? '1' : '0';
    request.fields["serving_theflag"] = user.form.serving_theflag.toString();
    request.fields["HDYKATC_another"] = user.form.HDYKATC_another;
    request.fields["housing_status"] = user.form.housing_status.toString();
    request.fields["level_ofEducation"] =
        user.form.level_ofEducation.toString();
    request.fields["english_level"] = user.form.english_level.toString();
    request.fields["ICDL"] = user.form.ICDL ? '1' : '0';

    // http.MultipartFile personalImagePic = await http.MultipartFile.fromPath(
    //     "user_personalImagePath", personalImage.path);
    // request.files.add(personalImagePic);

    var streamResponse = await request.send();
    if (streamResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamResponse);
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['statu'] == 'success') {
        user = userInfo;
        user.id = int.parse(result['user_id']);
        user.form.id = int.parse(result['form_id']);

        var tempoLang = user.form.anotherLanguage;
        user.form.anotherLanguage = [];
        await inserLanguageFN(lang: tempoLang);
        await inserSkillsFN(skills: userInfo.form.skills);
        await insertEducationFN(educations: userInfo.form.education);
        await insertExperienceFN(experience: userInfo.form.experience);
        await insertHDYKATCFN(hdykatc: userInfo.form.hdykatc);
        resulState = true;
      }
    } else {}
    isLoading = false;
    await Future.delayed(Duration(seconds: 4));
    notifyListeners();
    return resulState;
  }

  inserLanguageFN({required List<AnotherLanguage> lang}) async {
    for (var i = 0; i < lang.length; i++) {
      Uri url2 = Uri.parse(insertLanguagePath);

      var request2 = http.MultipartRequest("POST", url2);
      request2.fields["title"] = lang[i].title.toString();
      request2.fields["level"] = lang[i].level.toString();
      request2.fields["form_id"] = user.form.id.toString();
      var streamResponse2 = await request2.send();
      if (streamResponse2.statusCode == 200) {
        var response2 = await http.Response.fromStream(streamResponse2);
        final result2 = jsonDecode(response2.body) as Map<String, dynamic>;
        if (result2['statu'] == 'success') {
          user.form.anotherLanguage.add(AnotherLanguage(
              id: int.parse(result2['lang_id']),
              title: lang[i].title,
              level: lang[i].level,
              formId: user.form.id));
        }
      }
    }
  }

  inserSkillsFN({required List<Skills> skills}) async {
    for (var i = 0; i < skills.length; i++) {
      Uri url3 = Uri.parse(insertSkillPath);

      var request3 = http.MultipartRequest("POST", url3);
      request3.fields["description"] = skills[i].description.toString();
      request3.fields["form_id"] = user.form.id.toString();
      var streamResponse3 = await request3.send();
      if (streamResponse3.statusCode == 200) {
        var response3 = await http.Response.fromStream(streamResponse3);
        final result3 = jsonDecode(response3.body) as Map<String, dynamic>;
        if (result3['statu'] == 'success') {
          print(result3['skill_id']);
        }
      }
    }
  }

  insertEducationFN({required List<Education> educations}) async {
    for (var e = 0; e < educations.length; e++) {
      Uri url3 = Uri.parse(insertEducationPath);

      var request3 = http.MultipartRequest("POST", url3);
      request3.fields["universityName"] =
          educations[e].universityName.toString();
      request3.fields["specialization"] =
          educations[e].specialization.toString();
      request3.fields["years"] = educations[e].years.toString();
      request3.fields["graduatedDate"] = educations[e].graduatedDate.toString();
      request3.fields["form_id"] = user.form.id.toString();
      var streamResponse3 = await request3.send();
      if (streamResponse3.statusCode == 200) {
        var response3 = await http.Response.fromStream(streamResponse3);
        final result3 = jsonDecode(response3.body) as Map<String, dynamic>;
        if (result3['statu'] == 'success') {
          print(result3['id']);
        }
      }
    }
  }

  insertExperienceFN({required List<Experience> experience}) async {
    for (var e = 0; e < experience.length; e++) {
      Uri url3 = Uri.parse(insertExperiencePath);

      var request3 = http.MultipartRequest("POST", url3);
      request3.fields["destination_name"] =
          experience[e].destinationName.toString();
      request3.fields["job_position"] = experience[e].jobPosition.toString();
      request3.fields["duration"] = experience[e].duration.toString();
      request3.fields["reason_forLeaving"] =
          experience[e].reasonForLeaving.toString();
      request3.fields["form_id"] = user.form.id.toString();
      var streamResponse3 = await request3.send();
      if (streamResponse3.statusCode == 200) {
        var response3 = await http.Response.fromStream(streamResponse3);
        final result3 = jsonDecode(response3.body) as Map<String, dynamic>;
        if (result3['statu'] == 'success') {
          print(result3['id']);
        }
      }
    }
  }

  insertHDYKATCFN({required List<int> hdykatc}) async {
    for (var h = 0; h < hdykatc.length; h++) {
      Uri url3 = Uri.parse(insertHDYKATCPath);

      var request3 = http.MultipartRequest("POST", url3);
      request3.fields["typeId"] = hdykatc[h].toString();
      request3.fields["formId"] = user.form.id.toString();
      var streamResponse3 = await request3.send();
      if (streamResponse3.statusCode == 200) {
        var response3 = await http.Response.fromStream(streamResponse3);
        final result3 = jsonDecode(response3.body) as Map<String, dynamic>;
        if (result3['statu'] == 'success') {
          print(result3['id']);
        }
      }
    }
  }

  Future<String> checkUserStateFN({required String idNumber}) async {
    // try {
    Uri url = Uri.parse(checkUserStatePath);

    Map<String, String> data = {'user_idNumber': idNumber};
    var response = await http.post(url, body: data);
    var responseBody = await jsonDecode(response.body);

    if (responseBody['statu'] == 'success') {
      // user = User(
      //   id: responseBody['data']['user_id'],
      //   firstName: responseBody['data']['user_firstName'],
      //   lastName: responseBody['data']['user_lastName'],
      //   fatherName: responseBody['data']['user_fatherName'],
      //   motherName: responseBody['data']['user_motherName'],
      //   gender: responseBody['data']['user_gender'] == 1 ? true : false,
      //   birthDate: DateTime.parse(responseBody['data']['user_birthDate']),
      //   cityId: responseBody['data']['user_cityId'],
      //   constraint: responseBody['data']['user_constraint'],
      //   idNumber: responseBody['data']['user_idNumber'],
      //   idCardNumber: responseBody['data']['user_idCardNumber'],
      //   // personalImagePath: responseBody['data']['user_personalImagePath'],
      //   // frontCardImagePath: responseBody['data']['user_frontCardImagePath'],
      //   // backCardImagePath: responseBody['data']['user_backCardImagePath'],
      //   dateCreate: DateTime.parse(
      //     responseBody['data']['user_create'],
      //   ),
      //   phone: responseBody['data']['user_phone'],
      //   phoneSecondary: responseBody['data']['user_phoneSecondary'],
      //   telephone: responseBody['data']['user_telephone'],
      //   address: responseBody['data']['user_address'],
      //   addressDetails: responseBody['data']['user_addressDetails'],
      // );

      notifyListeners();
      return 'Task success ${responseBody['data']} record found';
    } else {
      notifyListeners();
      return 'No record found';
    }
    // } catch (e) {
    //   return 'No Internet';
    // }
  }
}
