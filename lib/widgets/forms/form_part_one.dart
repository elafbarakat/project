import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../assets/generated/locale_keys.g.dart/codegen_loader.g.dart';
import '../../providers/city_provider.dart';
import 'form_method.dart';

class FormPartOne extends StatefulWidget {
  final GlobalKey<FormState> form1Key;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController englishFullName;
  final TextEditingController fatherName;
  final TextEditingController motherName;
  final TextEditingController dateOfBirth;
  final TextEditingController constraint;
  final Function({int genderVal}) setGenderFN;
  final Function({int cityVal}) setCityFN;
  const FormPartOne({
    super.key,
    required this.form1Key,
    required this.firstName,
    required this.lastName,
    required this.englishFullName,
    required this.fatherName,
    required this.motherName,
    required this.dateOfBirth,
    required this.constraint,
    required this.setGenderFN,
    required this.setCityFN,
  });

  @override
  State<FormPartOne> createState() => _FormPartOneState();
}

class _FormPartOneState extends State<FormPartOne>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  FocusNode firstNameFNode = FocusNode();
  FocusNode lastNameFNode = FocusNode();
  FocusNode fatherNameFNode = FocusNode();

  DateTime selectedDate = DateTime(2000, 8);
  bool isSelectedDate = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000, 8),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2005, 8));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.dateOfBirth.text = selectedDate.toString().substring(0, 10);
        isSelectedDate = true;
      });
    }
  }

  int? selectedCity;

  int genderValue = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var cities = Provider.of<CityProvider>(context).getCities;

    return Form(
      key: widget.form1Key,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/undpLogoImage.png',
                width: 100,
                // color: Colors.red,
              ),
              Text(
                LocaleKeys.home_center.tr(),
                style: TextStyle(
                    fontFamily: LocaleKeys.home_fonts_primaryFont.tr(),
                    fontSize: 20,
                    color: Colors.grey[600]),
              ),
              TextFormField(
                controller: widget.firstName,
                focusNode: firstNameFNode,
                decoration: decorationFormFieldFN(
                  hintText: LocaleKeys.form_formOne_firstName.tr(),
                ),
                style: TextStyle(
                    fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (d) {
                  FocusScope.of(context).requestFocus(lastNameFNode);
                },
              ),
              TextFormField(
                controller: widget.lastName,
                focusNode: lastNameFNode,
                decoration: decorationFormFieldFN(
                  hintText: LocaleKeys.form_formOne_lastName.tr(),
                ),
                style: TextStyle(
                    fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                onFieldSubmitted: (d) {
                  FocusScope.of(context).requestFocus(fatherNameFNode);
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.englishFullName,
                decoration: decorationFormFieldFN(
                  hintText: LocaleKeys.form_formOne_englishFullName.tr(),
                ),
                style: TextStyle(
                    fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.fatherName,
                // focusNode: fatherNameFNode,
                decoration: decorationFormFieldFN(
                  hintText: LocaleKeys.form_formOne_fatherName.tr(),
                ),
                style: TextStyle(
                    fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),

                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.motherName,
                decoration: decorationFormFieldFN(
                  hintText: LocaleKeys.form_formOne_motherName.tr(),
                ),
                style: TextStyle(
                    fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.form_formOne_gender.tr()),
                  Row(
                    children: [
                      Text(
                        'Male',
                        style: TextStyle(
                            fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                      ),
                      Radio(
                        value: 1,
                        groupValue: genderValue,
                        onChanged: (val) {
                          setState(() {
                            genderValue = val!;
                            widget.setGenderFN(genderVal: val);
                          });
                        },
                      ),
                      const SizedBox(width: 40),
                      Text(
                        'Female',
                        style: TextStyle(
                            fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                      ),
                      Radio(
                        value: 0,
                        groupValue: genderValue,

                        onChanged: (val) {
                          setState(() {
                            genderValue = val!;
                            widget.setGenderFN(genderVal: val);
                          });
                        },
                        // toggleable: ,
                      ),
                    ],
                  ),
                ],
              ),
              divider,
              GestureDetector(
                onTap: () => _selectDate(context),
                child: TextFormField(
                  enabled: false,
                  controller: widget.dateOfBirth,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.form_formOne_DateOfBirth.tr(),
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                  ),
                  style: TextStyle(
                      fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                  // initialValue: 'Detect Date of birth',
                  validator: (text) {
                    if (text == 'Detect Date of birth') {
                      return 'This filed is required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              DropdownButtonFormField(
                value: selectedCity,
                isDense: true,
                elevation: 7,
                hint: Text(
                  LocaleKeys.form_formOne_city.tr(),
                ),
                items: [
                  for (int c = 0; c < cities.length; c++)
                    DropdownMenuItem(
                      value: cities[c].cityId,
                      child: Text(
                        cities[c].cityName[context.locale.languageCode],
                        style: TextStyle(
                          fontFamily: LocaleKeys.home_fonts_primaryFont.tr(),
                        ),
                      ),
                    )
                ],
                onChanged: (i) {
                  setState(() {
                    selectedCity = i!;
                    widget.setCityFN(cityVal: i);
                  });
                },
                validator: (city) {
                  if (selectedCity == null) {
                    return 'Select city pleas';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.constraint,
                decoration: decorationFormFieldFN(
                  hintText: LocaleKeys.form_formOne_constraint.tr(),
                ),
                style: TextStyle(
                    fontFamily: LocaleKeys.home_fonts_primaryFont.tr()),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
