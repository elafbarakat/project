import 'package:flutter/material.dart';

import '../../models/experience.dart';
import 'form_method.dart';

class ExperienceForm extends StatefulWidget {
  final Function({List<Experience> val}) setExperienceFN;

  const ExperienceForm({
    super.key,
    required this.setExperienceFN,
  });

  @override
  State<ExperienceForm> createState() => _ExperienceStateForm();
}

class _ExperienceStateForm extends State<ExperienceForm> {
  TextEditingController destinationNameController = TextEditingController();
  TextEditingController jobPositionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController reasonForLeavingController = TextEditingController();

  List<Experience> experience = [];
  bool showExperienceForm = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (experience.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox,
                const Text('Experiences'),
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
                        defaultColumnWidth: const FixedColumnWidth(150),
                        children: [
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Destination name'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Job position'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('duration'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Reason for Leaving'),
                              ),
                              Padding(padding: EdgeInsets.all(0))
                            ],
                          ),
                          for (int e = 0; e < experience.length; e++)
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(experience[e].destinationName),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(experience[e].jobPosition),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(experience[e].duration),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(experience[e].reasonForLeaving),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      experience.removeWhere((element) =>
                                          element.id == experience[e].id);
                                      widget.setExperienceFN(val: experience);
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.remove_circle,
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
          visible: showExperienceForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: destinationNameController,
                decoration: decorationFormFieldFN(hintText: 'Destination name'),
              ),
              TextFormField(
                controller: jobPositionController,
                decoration: decorationFormFieldFN(hintText: 'Job position'),
              ),
              TextFormField(
                controller: durationController,
                decoration: decorationFormFieldFN(hintText: 'Duration'),
              ),
              TextFormField(
                controller: reasonForLeavingController,
                decoration:
                    decorationFormFieldFN(hintText: 'Reason for leaving'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      destinationNameController.clear();
                      jobPositionController.clear();
                      durationController.clear();
                      reasonForLeavingController.clear();
                      setState(() {
                        showExperienceForm = false;
                      });
                    },
                    child: const Text('cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showExperienceForm = false;
                        experience.add(Experience(
                            id: experience.length,
                            destinationName: destinationNameController.text,
                            jobPosition: jobPositionController.text,
                            duration: durationController.text,
                            reasonForLeaving: reasonForLeavingController.text,
                            formId: 0));
                        destinationNameController.clear();
                        jobPositionController.clear();
                        durationController.clear();
                        reasonForLeavingController.clear();
                        showExperienceForm = false;
                        widget.setExperienceFN(val: experience);
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
          visible: !showExperienceForm,
          child: Row(
            children: [
              Expanded(
                child: Card(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          showExperienceForm = true;
                        });
                      },
                      child: const Text(
                        'Add experience',
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
