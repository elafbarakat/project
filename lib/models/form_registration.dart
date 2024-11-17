// ignore_for_file: non_constant_identifier_names
import 'package:undp/models/education.dart';
import 'another_langauge.dart';
import 'experience.dart';
import 'skills.dart';

class FormRegistration {
  int id;
  int user_id;
  DateTime date_create;
  String english_fullName;
  int breadwinner; // معيل الأسرة
  int marital_status; // الحالة_الزواجية؛
  int disability;
  int disability_type;
  double disability_precentage; // نسبة الإعاقة؛
  int family_number; // رقم_العائلة
  bool families_ofMartyrs; // عائلات_الشهداء
  int serving_theflag; // خدمة العلم
  String HDYKATC_another;
  int housing_status; // حالة السكن
  int level_ofEducation; // مستوى التعليم
  int english_level;
  bool ICDL;
  List<AnotherLanguage> anotherLanguage;
  List<Skills> skills;
  List<Education> education;
  List<Experience> experience;
  List<int> hdykatc;

  FormRegistration({
    required this.id,
    required this.user_id,
    required this.date_create,
    required this.english_fullName,
    required this.breadwinner,
    required this.marital_status,
    required this.disability,
    required this.disability_type,
    required this.disability_precentage,
    required this.family_number,
    required this.families_ofMartyrs,
    required this.serving_theflag,
    required this.HDYKATC_another,
    required this.housing_status,
    required this.level_ofEducation,
    required this.english_level,
    required this.ICDL,
    required this.anotherLanguage,
    required this.skills,
    required this.education,
    required this.experience,
    required this.hdykatc,
  });
}
