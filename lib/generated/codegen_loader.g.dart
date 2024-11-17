// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "home": {
      "center": "Youth Empowerment Center",
      "fonts": {"primaryFont": "couture"}
    },
    "form": {
      "formOne": {
        "firstName": "First name",
        "lastName": "Last name",
        "englishFullName": "English full name",
        "fatherName": "Father name",
        "motherName": "Mother name",
        "gender": "Gender",
        "DateOfBirth": "Date of birth",
        "city": "City",
        "constraint": "Constraint"
      }
    }
  };
  static const Map<String, dynamic> ar = {
    "home": {
      "center": "مركز تمكين الشباب",
      "fonts": {"primaryFont": "notoKufi"}
    },
    "form": {
      "formOne": {
        "firstName": "الإسم الأول",
        "lastName": "الكنية",
        "englishFullName": "الإسم الكامل باللغة الإنكليزية",
        "fatherName": "إسم الأب",
        "motherName": "إسم الأم",
        "gender": "الجنس",
        "DateOfBirth": "تاريخ الولادة",
        "city": "المدينة",
        "constraint": "القيد"
      }
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "ar": ar
  };
}
