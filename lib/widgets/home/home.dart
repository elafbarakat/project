import 'dart:io';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:test10/assets/generated/locale_keys.g.dart/codegen_loader.g.dart';
// import 'package:test10/models/another_langauge.dart';
// import 'package:test10/models/experience.dart';
// import 'package:test10/models/form_registration.dart';
// import 'package:test10/models/skills.dart';
// import 'package:test10/models/user.dart';
// import 'package:test10/providers/city_provider.dart';
// import 'package:test10/providers/user_provider.dart';
// import 'package:test10/widgets/forms/form_part_four.dart';
// import 'package:test10/widgets/forms/form_part_one.dart';
// import 'package:test10/widgets/forms/form_part_three.dart';
// import 'package:test10/widgets/forms/from_part_tow.dart';

////////////////
///// import 'package:shared_preferences/shared_preferences.dart';

import 'package:theme_manager/theme_manager.dart';
import '../../models/another_langauge.dart';
import '../../models/education.dart';
import '../../models/experience.dart';
import '../../models/form_registration.dart';
import '../../models/skills.dart';
import '../../models/user.dart';
import '../../providers/city_provider.dart';
import '../../providers/type_of_HDYKATC_provider.dart';
import '../../providers/user_provider.dart';
import '../forms/form_method.dart';
import '../forms/form_part_four.dart';
import '../forms/form_part_one.dart';
import '../forms/form_part_three.dart';
import '../forms/from_part_tow.dart';
import 'user_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController constraint = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController idCardNumber = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phoneSecondary = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController addressDetails = TextEditingController();
  TextEditingController englishFullName = TextEditingController();
  TextEditingController familyNumber = TextEditingController();

  FocusNode confirmNode = FocusNode();

  DateTime selectedDate = DateTime(2000, 8);
  bool isSelectedDate = false;

  @override
  void initState() {
    Provider.of<CityProvider>(context, listen: false).getCitiesFN();
    Provider.of<TypeOfHDYKATCProvider>(context, listen: false).getHDYKATCFN();

    super.initState();
  }

  // checkPref() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey('test')) {
  //     print('yes');
  //   } else {
  //     // print('no');
  //     prefs.setString('test', 'login');
  //   }
  // }

  formConfirm() async {
    if (form4Key.currentState!.validate()) {
      var fff = User(
        id: 0,
        firstName: firstName.text,
        lastName: lastName.text,
        fatherName: fatherName.text,
        motherName: motherName.text,
        birthDate: selectedDate,
        gender: genderValue == 1 ? true : false,
        cityId: selectedCity!,
        constraint: constraint.text,
        idNumber: idNumber.text,
        idCardNumber: idCardNumber.text,
        dateCreate: DateTime.now(),
        phone: phone.text,
        phoneSecondary: phoneSecondary.text,
        telephone: telephone.text,
        address: address.text,
        addressDetails: addressDetails.text,
        form: FormRegistration(
          id: 0,
          user_id: 0,
          date_create: DateTime.now(),
          english_fullName: englishFullName.text,
          breadwinner: breadWinnerValue,
          marital_status: selectedMaritalStatus,
          disability: disabilityValue,
          disability_type: selectedDisabilityTypeStatus,
          disability_precentage: disabilityPrecentage,
          family_number: int.parse(familyNumber.text),
          families_ofMartyrs: familiesOfMartyrsValue == 1 ? true : false,
          serving_theflag: selectedServingTheFlag,
          HDYKATC_another: 'HDYKATC_another',
          housing_status: selectedHousingStatus,
          level_ofEducation: selectedLevelOfEducation,
          english_level: selectedEnglishLevel,
          ICDL: icdlValue == 1 ? true : false,
          anotherLanguage: languages,
          skills: skills,
          education: educations,
          experience: experience,
          hdykatc: hdykatcChecked,
        ),
      );
      await Provider.of<UserProvider>(context, listen: false)
          .newUserWithImage(
        userInfo: fff,
        // personalImage: personalFile,
      )
          .then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const UserInfo()),
              (route) => false);
        } else {
          print('Error');
        }
      });
    } else {
      showSnack(context);
      await Future.delayed(const Duration(milliseconds: 2300));
    }
  }

  int genderValue = 0;

  setGenderFN({int genderVal = 0}) {
    setState(() {
      genderValue = genderVal;
    });
  }

  int? selectedCity;
  setCityFN({int cityVal = 0}) {
    setState(() {
      selectedCity = cityVal;
    });
  }

  late File personalFile;
  setImageFN({File? personalFileVal}) {
    setState(() {
      personalFile = personalFileVal!;
    });
  }

  int breadWinnerValue = 0;
  setBreadWinnerFN({int? breadWinnerVal}) {
    setState(() {
      breadWinnerValue = breadWinnerVal!;
    });
  }

  int selectedMaritalStatus = 1;
  setSelectedMaritalStatusFN({int? selectedMaritalStatusVal}) {
    setState(() {
      selectedMaritalStatus = selectedMaritalStatusVal!;
    });
  }

  int disabilityValue = 0;
  setDisabilityValueFN({int? disabilityValueVal}) {
    setState(() {
      disabilityValue = disabilityValueVal!;
    });
  }

  int selectedDisabilityTypeStatus = 1;
  selectedDisabilityTypeStatusVal({int? selectedDisabilityTypeStatusVal}) {
    setState(() {
      selectedDisabilityTypeStatus = selectedDisabilityTypeStatusVal!;
    });
  }

  double disabilityPrecentage = 0.1;
  setDisabilityPrecentageFN({double? disabilityPrecentageVal}) {
    setState(() {
      disabilityPrecentage = disabilityPrecentageVal!;
    });
  }

  int familiesOfMartyrsValue = 0;
  setFamiliesOfMartyrsValueFN({int? familiesOfMartyrsValueVal}) {
    setState(() {
      familiesOfMartyrsValue = familiesOfMartyrsValueVal!;
    });
  }

  int selectedServingTheFlag = 1;
  setSelectedServingTheFlagFN({int? selectedServingTheFlagVal}) {
    setState(() {
      familiesOfMartyrsValue = selectedServingTheFlagVal!;
    });
  }

  List<int> hdykatcChecked = [];

  setHdykatcFN({List<int>? hdykatcCheckedVal}) {
    setState(() {
      hdykatcChecked.clear();
      hdykatcChecked.addAll(hdykatcCheckedVal!);
    });
  }

  int selectedHousingStatus = 1;
  setSelectedHousingStatusFN({int? selectedHousingStatusVal}) {
    setState(() {
      selectedHousingStatus = selectedHousingStatusVal!;
    });
  }

  int selectedLevelOfEducation = 1;
  setSelectedLevelOfEducationFN({int? selectedLevelOfEducationVal}) {
    setState(() {
      selectedLevelOfEducation = selectedLevelOfEducationVal!;
    });
  }

  int selectedEnglishLevel = 1;

  setSelectedEnglishLevelFN({int? selectedEnglishLevelVal}) {
    setState(() {
      selectedEnglishLevel = selectedEnglishLevelVal!;
    });
  }

  int icdlValue = 0;

  int selectedAnotherLanguageLevel = 1;

  List<AnotherLanguage> languages = [];
  setLanguagesFN({List<AnotherLanguage>? val}) {
    setState(() {
      languages.clear();
      languages.addAll(val!);
    });
  }

  List<Skills> skills = [];
  setSkillsFN({List<Skills>? val}) {
    setState(() {
      skills.clear();
      skills.addAll(val!);
    });
  }

  List<Education> educations = [];
  setEducationFN({List<Education>? val}) {
    setState(() {
      educations.clear();
      educations.addAll(val!);
    });
  }

  List<Experience> experience = [];
  setExperienceFN({List<Experience>? val}) {
    setState(() {
      experience.clear();
      experience.addAll(val!);
    });
  }

  PageController? pageController = PageController(
    initialPage: 0,
  );

  int pageIndex = 0;

  GlobalKey<FormState> form1Key = GlobalKey<FormState>(debugLabel: 'form1');
  GlobalKey<FormState> form2Key = GlobalKey<FormState>(debugLabel: 'form2');
  GlobalKey<FormState> form3Key = GlobalKey<FormState>(debugLabel: 'form3');
  GlobalKey<FormState> form4Key = GlobalKey<FormState>(debugLabel: 'form4');

  bool dark = false;

  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<UserProvider>(context).getIsLoading;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: pageController,
                            pageSnapping: true,
                            onPageChanged: (index) {
                              setState(() {
                                pageIndex = index;
                              });
                            },
                            children: [
                              /// Form one
                              FormPartOne(
                                form1Key: form1Key,
                                firstName: firstName,
                                lastName: lastName,
                                englishFullName: englishFullName,
                                fatherName: fatherName,
                                motherName: motherName,
                                dateOfBirth: dateOfBirth,
                                constraint: constraint,
                                setGenderFN: setGenderFN,
                                setCityFN: setCityFN,
                              ),

                              ///// Form tow
                              FormPartTow(
                                form2Key: form2Key,
                                idNumber: idNumber,
                                idCardNumber: idCardNumber,
                                phone: phone,
                                phoneSecondary: phoneSecondary,
                                telephone: telephone,
                                address: address,
                                addressDetails: addressDetails,
                                setImageFN: setImageFN,
                              ),

                              /////////// Form three
                              FormPartThree(
                                form3Key: form3Key,
                                familyNumber: familyNumber,
                                genderValue: genderValue,
                                setBreadWinnerFN: setBreadWinnerFN,
                                setSelectedMaritalStatusFN:
                                    setSelectedMaritalStatusFN,
                                setDisabilityValueFN: setDisabilityValueFN,
                                selectedDisabilityTypeStatusFN:
                                    selectedDisabilityTypeStatusVal,
                                setDisabilityPrecentageFN:
                                    setDisabilityPrecentageFN,
                                setFamiliesOfMartyrsValueFN:
                                    setFamiliesOfMartyrsValueFN,
                                setSelectedServingTheFlagFN:
                                    setSelectedServingTheFlagFN,
                                setHdykatcFN: setHdykatcFN,
                              ),
                              //////  Form four
                              FormPartFour(
                                form3Key: form4Key,
                                setSelectedHousingStatusFN:
                                    setSelectedHousingStatusFN,
                                setSelectedLevelOfEducationFN:
                                    setSelectedLevelOfEducationFN,
                                setSelectedEnglishLevelFN:
                                    setSelectedEnglishLevelFN,
                                setLanguagesFN: setLanguagesFN,
                                setSkillsFN: setSkillsFN,
                                setEducationFN: setEducationFN,
                                setExperienceFN: setExperienceFN,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            pageIndex == 0
                                ? const SizedBox(width: 25)
                                : GestureDetector(
                                    onTap: () {
                                      pageController!.animateToPage(
                                          pageIndex - 1,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    },
                                    child: const Icon(Icons.arrow_back_ios)),
                            const Spacer(),
                            pageIndex == 3
                                ? loading
                                    ? Padding(padding: EdgeInsets.all(0))
                                    : Focus(
                                        focusNode: confirmNode,
                                        child: ElevatedButton(
                                          // focusNode: fatherNameFNode,
                                          onPressed: () async =>
                                              await formConfirm(),
                                          child: const Text('Confirm'),
                                        ),
                                      )
                                : SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        for (int i = 0; i < 4; i++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3, right: 3),
                                            child: CircleAvatar(
                                              radius: pageIndex == i ? 4 : 3,
                                              backgroundColor: pageIndex == i
                                                  ? Colors.blue
                                                  : Colors.grey,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                            const Spacer(),
                            pageIndex < 3
                                ? GestureDetector(
                                    onTap: () {
                                      if (pageIndex == 0) {
                                        if (form1Key.currentState!.validate()) {
                                          pageController!.animateToPage(
                                              pageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.linear);
                                        }
                                      } else if (pageIndex == 1) {
                                        if (form2Key.currentState!.validate()) {
                                          pageController!.animateToPage(
                                              pageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.linear);
                                        }
                                      } else if (pageIndex == 2) {
                                        if (form3Key.currentState!.validate()) {
                                          pageController!.animateToPage(
                                              pageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.linear);
                                        }
                                      }
                                    },
                                    child: const Icon(Icons.arrow_forward_ios))
                                : const SizedBox(
                                    width: 25,
                                  ),
                          ],
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedIconButton(
                      onPressed: () => print('all icons pressed'),
                      icons: [
                        AnimatedIconItem(
                          icon: const Icon(
                            Icons.dark_mode,
                            color: Colors.grey,
                          ),
                          onPressed: () => ThemeManager.of(context)
                              .setBrightnessPreference(
                                  BrightnessPreference.dark),
                        ),
                        AnimatedIconItem(
                          icon: const Icon(
                            Icons.light_mode,
                            color: Colors.grey,
                          ),
                          onPressed: () => ThemeManager.of(context)
                              .setBrightnessPreference(
                                  BrightnessPreference.light),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          if (context.locale.languageCode == 'en') {
                            context.setLocale(Locale('ar'));
                          } else {
                            context.setLocale(Locale('en'));
                          }
                        },
                        icon: Icon(Icons.language)),
                  ],
                ),
                if (loading)
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: LinearProgressIndicator(
                          minHeight: 2,
                          backgroundColor: Colors.white.withOpacity(0.9),
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
