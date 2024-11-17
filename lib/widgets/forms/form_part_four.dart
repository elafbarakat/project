import 'package:flutter/material.dart';
import '../../models/another_langauge.dart';
import '../../models/education.dart';
import '../../models/experience.dart';
import '../../models/skills.dart';
import 'another_language_form.dart';
import 'educations_form.dart';
import 'experience_form.dart';
import 'form_method.dart';
import 'skills_form.dart';

class FormPartFour extends StatefulWidget {
  final GlobalKey<FormState> form3Key;
  final Function({int selectedHousingStatusVal}) setSelectedHousingStatusFN;
  final Function({int selectedLevelOfEducationVal})
      setSelectedLevelOfEducationFN;
  final Function({int selectedEnglishLevelVal}) setSelectedEnglishLevelFN;
  final Function({List<AnotherLanguage> val}) setLanguagesFN;
  final Function({List<Skills> val}) setSkillsFN;
  final Function({List<Education> val}) setEducationFN;
  final Function({List<Experience> val}) setExperienceFN;

  const FormPartFour({
    super.key,
    required this.form3Key,
    required this.setSelectedHousingStatusFN,
    required this.setSelectedLevelOfEducationFN,
    required this.setSelectedEnglishLevelFN,
    required this.setLanguagesFN,
    required this.setSkillsFN,
    required this.setEducationFN,
    required this.setExperienceFN,
  });

  @override
  State<FormPartFour> createState() => _FormPartFourState();
}

class _FormPartFourState extends State<FormPartFour>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int selectedHousingStatus = 1;
  List housingStatusItems = [
    [1, 'a'],
    [2, 'b'],
    [3, 'c'],
    [4, 'd'],
  ];

  int selectedLevelOfEducation = 1;

  List levelOfEducationItems = [
    [1, 'a'],
    [2, 'b'],
    [3, 'c'],
    [4, 'd'],
  ];

  int selectedEnglishLevel = 1;
  List languageLevelItems = [
    [1, 'a'],
    [2, 'b'],
    [3, 'c'],
    [4, 'd'],
  ];

  List<AnotherLanguage> languages = [];
  setLanguagesFN({List<AnotherLanguage>? val}) {
    setState(() {
      languages.clear();
      languages.addAll(val!);
      widget.setLanguagesFN(val: val);
    });
  }

  List<Skills> skills = [];
  setSkillsFN({List<Skills>? val}) {
    setState(() {
      skills.clear();
      skills.addAll(val!);
      widget.setSkillsFN(val: val);
    });
  }

  List<Education> educations = [];
  setEducationFN({List<Education>? val}) {
    setState(() {
      educations.clear();
      educations.addAll(val!);
      widget.setEducationFN(val: educations);
    });
  }

  List<Experience> experience = [];
  setExperienceFN({List<Experience>? val}) {
    setState(() {
      experience.clear();
      experience.addAll(val!);
      widget.setExperienceFN(val: experience);
    });
  }

  int icdlValue = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context); //////////////?

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: widget.form3Key,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Housing status'),
                  DropdownButtonFormField(
                      value: selectedHousingStatus,
                      items: [
                        for (int i = 0; i < housingStatusItems.length; i++)
                          DropdownMenuItem(
                              value: housingStatusItems[i][0],
                              child: Text(housingStatusItems[i][1]))
                      ],
                      onChanged: (val) {
                        setState(() {
                          selectedHousingStatus = val as int;
                          widget.setSelectedHousingStatusFN(
                              selectedHousingStatusVal: val);
                        });
                      }),
                ],
              ),
              sizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Level of education'),
                  DropdownButtonFormField(
                      value: selectedLevelOfEducation,
                      items: [
                        for (int i = 0; i < levelOfEducationItems.length; i++)
                          DropdownMenuItem(
                              value: levelOfEducationItems[i][0],
                              child: Text(levelOfEducationItems[i][1]))
                      ],
                      onChanged: (val) {
                        setState(() {
                          selectedLevelOfEducation = val as int;
                          widget.setSelectedLevelOfEducationFN(
                              selectedLevelOfEducationVal: val);
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  sizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('English level'),
                      DropdownButtonFormField(
                          value: selectedEnglishLevel,
                          items: [
                            for (int i = 0; i < languageLevelItems.length; i++)
                              DropdownMenuItem(
                                  value: languageLevelItems[i][0],
                                  child: Text(languageLevelItems[i][1]))
                          ],
                          onChanged: (val) {
                            setState(() {
                              selectedEnglishLevel = val as int;
                              widget.setSelectedEnglishLevelFN(
                                  selectedEnglishLevelVal: val);
                            });
                          }),
                    ],
                  ),
                ],
              ),
              AnotherLanguageForm(
                languageLevelItems: languageLevelItems,
                setLanguagesFN: setLanguagesFN,
              ),
              SkillsForm(setSkillsFN: setSkillsFN),
              EducationsForm(setEducationFN: setEducationFN),
              ExperienceForm(setExperienceFN: setExperienceFN),
              sizedBox,
              const Text('ICDL'),
              Row(
                children: [
                  const Text('No'),
                  Radio(
                    value: 0,
                    groupValue: icdlValue,
                    onChanged: (val) {
                      setState(() {
                        icdlValue = val!;
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Text('Yes'),
                  Radio(
                    value: 1,
                    groupValue: icdlValue,
                    onChanged: (val) {
                      setState(() {
                        icdlValue = val!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
