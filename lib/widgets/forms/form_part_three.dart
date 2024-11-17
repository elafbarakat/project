import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/type_of_HDYKATC_provider.dart';
import 'form_method.dart';

class FormPartThree extends StatefulWidget {
  final GlobalKey<FormState> form3Key;
  final TextEditingController familyNumber;
  final int genderValue;
  final Function({int breadWinnerVal}) setBreadWinnerFN;
  final Function({int selectedMaritalStatusVal}) setSelectedMaritalStatusFN;
  final Function({int disabilityValueVal}) setDisabilityValueFN;
  final Function({int selectedDisabilityTypeStatusVal})
      selectedDisabilityTypeStatusFN;
  final Function({double disabilityPrecentageVal}) setDisabilityPrecentageFN;
  final Function({int familiesOfMartyrsValueVal}) setFamiliesOfMartyrsValueFN;
  final Function({int selectedServingTheFlagVal}) setSelectedServingTheFlagFN;
  final Function({List<int> hdykatcCheckedVal}) setHdykatcFN;

  const FormPartThree({
    super.key,
    required this.form3Key,
    required this.familyNumber,
    required this.genderValue,
    required this.setBreadWinnerFN,
    required this.setSelectedMaritalStatusFN,
    required this.setDisabilityValueFN,
    required this.selectedDisabilityTypeStatusFN,
    required this.setDisabilityPrecentageFN,
    required this.setFamiliesOfMartyrsValueFN,
    required this.setSelectedServingTheFlagFN,
    required this.setHdykatcFN,
  });

  @override
  State<FormPartThree> createState() => _FormPartThreeState();
}

class _FormPartThreeState extends State<FormPartThree>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  FocusNode familyNumberNode = FocusNode();

  int breadWinnerValue = 0;

  int selectedMaritalStatus = 1;
  List maritalStatusItems = [
    [1, 'a'],
    [2, 'b'],
    [3, 'c'],
    [4, 'd'],
  ];

  int disabilityValue = 0;

  int selectedDisabilityTypeStatus = 1;

  List disabilityTypeItems = [
    [1, 'a'],
    [2, 'b'],
    [3, 'c'],
    [4, 'd'],
  ];

  double disabilityPrecentage = 0.1;

  int familiesOfMartyrsValue = 0;

  int selectedServingTheFlag = 1;
  List servingTheFlagItems = [
    [1, 'a'],
    [2, 'b'],
    [3, 'c'],
    [4, 'd'],
  ];

  List<int> hdykatcChecked = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var hdykatc = Provider.of<TypeOfHDYKATCProvider>(context).hdykatcGet;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: widget.form3Key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: widget.familyNumber,
                focusNode: familyNumberNode,
                maxLength: 2,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: decorationFormFieldFN(
                  hintText: 'family number',
                ),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              const Text('Bread winner'),
              Row(
                children: [
                  const Text('Yes'),
                  Radio(
                    value: 1,
                    groupValue: breadWinnerValue,
                    onChanged: (val) {
                      setState(() {
                        breadWinnerValue = val!;
                        widget.setBreadWinnerFN(breadWinnerVal: val);
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Text('No'),
                  Radio(
                    value: 0,
                    groupValue: breadWinnerValue,
                    onChanged: (val) {
                      setState(() {
                        breadWinnerValue = val!;
                        widget.setBreadWinnerFN(breadWinnerVal: val);
                      });
                    },
                  ),
                ],
              ),
              divider,
              sizedBox,
              const Text('Marital status'),
              DropdownButtonFormField(
                  value: selectedMaritalStatus,
                  items: [
                    for (int i = 0; i < maritalStatusItems.length; i++)
                      DropdownMenuItem(
                          value: maritalStatusItems[i][0],
                          child: Text(maritalStatusItems[i][1]))
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedMaritalStatus = val as int;
                      widget.setSelectedMaritalStatusFN(
                          selectedMaritalStatusVal: val);
                    });
                  }),
              sizedBox,
              const Text('Disability'),
              Row(
                children: [
                  const Text('No'),
                  Radio(
                    value: 0,
                    groupValue: disabilityValue,
                    onChanged: (val) {
                      setState(() {
                        disabilityValue = val!;
                        widget.setDisabilityValueFN(disabilityValueVal: val);
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Text('Yes'),
                  Radio(
                    value: 1,
                    groupValue: disabilityValue,
                    onChanged: (val) {
                      setState(() {
                        disabilityValue = val!;
                        widget.setDisabilityValueFN(disabilityValueVal: val);
                      });
                    },
                  ),
                ],
              ),
              divider,
              Visibility(
                visible: disabilityValue == 1 ? true : false,
                child: Column(
                  children: [
                    sizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Disability type'),
                        DropdownButtonFormField(
                            value: selectedDisabilityTypeStatus,
                            items: [
                              for (int i = 0;
                                  i < disabilityTypeItems.length;
                                  i++)
                                DropdownMenuItem(
                                    value: disabilityTypeItems[i][0],
                                    child: Text(disabilityTypeItems[i][1]))
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedDisabilityTypeStatus = val as int;
                                widget.selectedDisabilityTypeStatusFN(
                                    selectedDisabilityTypeStatusVal: val);
                              });
                            }),
                        sizedBox,
                        const Text('Disability precentage'),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                min: (0.1),
                                max: 99.9,
                                value: disabilityPrecentage,
                                onChanged: (val) {
                                  setState(() {
                                    disabilityPrecentage = val;
                                    widget.setDisabilityPrecentageFN(
                                        disabilityPrecentageVal: val);
                                  });
                                },
                              ),
                            ),
                            Text(
                              '${disabilityPrecentage.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Text('Families of martyrs'),
              Row(
                children: [
                  const Text('No'),
                  Radio(
                    value: 0,
                    groupValue: familiesOfMartyrsValue,
                    onChanged: (val) {
                      setState(() {
                        familiesOfMartyrsValue = val!;
                        widget.setFamiliesOfMartyrsValueFN(
                            familiesOfMartyrsValueVal: val);
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Text('Yes'),
                  Radio(
                    value: 1,
                    groupValue: familiesOfMartyrsValue,
                    onChanged: (val) {
                      setState(() {
                        familiesOfMartyrsValue = val!;
                        widget.setFamiliesOfMartyrsValueFN(
                            familiesOfMartyrsValueVal: val);
                      });
                    },
                  ),
                ],
              ),
              divider,
              sizedBox,
              Visibility(
                visible: widget.genderValue == 1 ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Serving the flag'),
                    DropdownButtonFormField(
                        value: selectedServingTheFlag,
                        items: [
                          for (int i = 0; i < servingTheFlagItems.length; i++)
                            DropdownMenuItem(
                                value: servingTheFlagItems[i][0],
                                child: Text(servingTheFlagItems[i][1]))
                        ],
                        onChanged: (val) {
                          setState(() {
                            selectedServingTheFlag = val as int;
                            widget.setSelectedServingTheFlagFN(
                                selectedServingTheFlagVal: val);
                          });
                        }),
                  ],
                ),
              ),
              sizedBox,
              Text('How did you know about the center ?'),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: hdykatc.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 40,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return CheckboxMenuButton(
                        value: hdykatcChecked.contains(hdykatc[index].id),
                        onChanged: (val) {
                          if (hdykatcChecked.contains(hdykatc[index].id)) {
                            setState(() {
                              hdykatcChecked.removeWhere(
                                  (element) => element == hdykatc[index].id);
                            });
                          } else {
                            setState(() {});
                            hdykatcChecked.add(hdykatc[index].id);
                          }
                          setState(() {
                            widget.setHdykatcFN(
                                hdykatcCheckedVal: hdykatcChecked);
                          });
                        },
                        child: Text(hdykatc[index].title['en']));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
