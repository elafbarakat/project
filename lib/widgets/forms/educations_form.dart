import 'package:flutter/material.dart';

import '../../models/education.dart';
import 'form_method.dart';

class EducationsForm extends StatefulWidget {
  final Function({List<Education> val}) setEducationFN;

  const EducationsForm({
    super.key,
    required this.setEducationFN,
  });

  @override
  State<EducationsForm> createState() => _EducationsFormState();
}

class _EducationsFormState extends State<EducationsForm> {
  List<Education> educations = [];
  bool showEducationForm = false;
  TextEditingController universityNameController = TextEditingController();
  TextEditingController specializationNameController = TextEditingController();
  TextEditingController graduatedDateController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  DateTime selectedGraduatedDate = DateTime(2000, 8);
  bool isSelectedGraduatedDate = false;

  Future<void> selectGraduatedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000, 8),
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2005, 8));
    if (picked != null && picked != selectedGraduatedDate) {
      setState(() {
        selectedGraduatedDate = picked;
        graduatedDateController.text =
            selectedGraduatedDate.toString().substring(0, 10);
        isSelectedGraduatedDate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (educations.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox,
                const Text('Educations'),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 700,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        border: TableBorder.all(
                          width: 0.5,
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        defaultColumnWidth: FixedColumnWidth(125),
                        children: [
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('university Name'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('specialization'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('years'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Graduate year'),
                              ),
                              Padding(padding: EdgeInsets.all(0))
                            ],
                          ),
                          for (int e = 0; e < educations.length; e++)
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(educations[e].universityName),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(educations[e].specialization),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(educations[e].years),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(educations[e]
                                      .graduatedDate
                                      .toString()
                                      .substring(0, 10)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      educations.removeWhere((element) =>
                                          element.id == educations[e].id);
                                      widget.setEducationFN(val: educations);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        Visibility(
          visible: showEducationForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: universityNameController,
                decoration: decorationFormFieldFN(hintText: 'University name'),
              ),
              TextFormField(
                controller: specializationNameController,
                decoration:
                    decorationFormFieldFN(hintText: 'Specialization name'),
              ),
              TextFormField(
                controller: yearsController,
                decoration: decorationFormFieldFN(hintText: 'Years count'),
              ),
              GestureDetector(
                onTap: () => selectGraduatedDate(context),
                child: TextFormField(
                  enabled: false,
                  controller: graduatedDateController,
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Icons.date_range)),
                  validator: (text) {
                    if (showEducationForm && !isSelectedGraduatedDate) {
                      return 'This filed is required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      universityNameController.clear();
                      specializationNameController.clear();
                      yearsController.clear();
                      graduatedDateController.clear();
                      setState(() {
                        showEducationForm = false;
                        selectedGraduatedDate = DateTime(2000, 8);
                      });
                    },
                    child: const Text('cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showEducationForm = false;
                        educations.add(Education(
                            id: educations.length,
                            universityName: universityNameController.text,
                            specialization: specializationNameController.text,
                            years: yearsController.text,
                            graduatedDate: selectedGraduatedDate,
                            formId: 0));
                        universityNameController.clear();
                        specializationNameController.clear();
                        yearsController.clear();
                        graduatedDateController.clear();
                        selectedGraduatedDate = DateTime(2000, 8);
                        showEducationForm = false;
                        widget.setEducationFN(val: educations);
                      });
                    },
                    child: const Text(
                      'Add',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: !showEducationForm,
          child: Row(
            children: [
              Expanded(
                child: Card(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          showEducationForm = true;
                        });
                      },
                      child: const Text(
                        'Add education level',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
