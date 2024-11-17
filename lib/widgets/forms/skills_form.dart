import 'package:flutter/material.dart';

import '../../models/skills.dart';
import 'form_method.dart';

class SkillsForm extends StatefulWidget {
  final Function({List<Skills> val}) setSkillsFN;

  const SkillsForm({
    super.key,
    required this.setSkillsFN,
  });

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  List<Skills> skills = [];
  bool showSkillForm = false;
  TextEditingController skillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (skills.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox,
                const Text('Skills'),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Table(
            border: TableBorder.all(
              width: 0.5,
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            columnWidths: {
              1: FlexColumnWidth(0.4),
            },
            children: [
              for (int s = 0; s < skills.length; s++)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(skills[s].description),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          skills.removeWhere((element) =>
                              element.description == skills[s].description);
                          widget.setSkillsFN(val: skills);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            const Icon(Icons.remove_circle, color: Colors.red),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
        Visibility(
          visible: showSkillForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: skillController,
                decoration:
                    decorationFormFieldFN(hintText: 'skill description'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      skillController.clear();
                      setState(() {
                        showSkillForm = false;
                      });
                    },
                    child: const Text('cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showSkillForm = false;
                        skills.add(Skills(
                            id: 0,
                            description: skillController.text,
                            formId: 0));
                        skillController.clear();
                        showSkillForm = false;
                        widget.setSkillsFN(val: skills);
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
          visible: !showSkillForm,
          child: Row(
            children: [
              Expanded(
                child: Card(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          showSkillForm = true;
                        });
                      },
                      child: const Text(
                        'Add Skill',
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
