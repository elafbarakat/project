import 'package:flutter/material.dart';

import '../../models/another_langauge.dart';
import 'form_method.dart';

class AnotherLanguageForm extends StatefulWidget {
  final List languageLevelItems;
  final Function({List<AnotherLanguage> val}) setLanguagesFN;

  const AnotherLanguageForm({
    super.key,
    required this.languageLevelItems,
    required this.setLanguagesFN,
  });

  @override
  State<AnotherLanguageForm> createState() => _AnotherLanguageFormState();
}

class _AnotherLanguageFormState extends State<AnotherLanguageForm> {
  TextEditingController anotherLang = TextEditingController();
  bool showAnotherLangForm = false;
  int selectedAnotherLanguageLevel = 1;
  List<AnotherLanguage> languages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (languages.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox,
                const Text('Another languages'),
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
              2: FlexColumnWidth(0.4),
            },
            children: [
              for (int l = 0; l < languages.length; l++)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(languages[l].title),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.languageLevelItems[widget.languageLevelItems
                            .indexWhere((element) =>
                                element[0] == languages[l].level)][1],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          languages.removeWhere(
                              (element) => element.title == languages[l].title);
                          widget.setLanguagesFN(val: languages);
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
          visible: showAnotherLangForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: anotherLang,
                decoration: decorationFormFieldFN(hintText: 'Language'),
              ),
              DropdownButtonFormField(
                  value: selectedAnotherLanguageLevel,
                  items: [
                    for (int i = 0; i < widget.languageLevelItems.length; i++)
                      DropdownMenuItem(
                        value: widget.languageLevelItems[i][0],
                        child: Text(widget.languageLevelItems[i][1]),
                      ),
                  ],
                  onChanged: (i) {
                    setState(() {
                      selectedAnotherLanguageLevel = i! as int;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      anotherLang.clear();
                      selectedAnotherLanguageLevel = 1;
                      setState(() {
                        showAnotherLangForm = false;
                      });
                    },
                    child: const Text('cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        languages.add(AnotherLanguage(
                            id: 0,
                            title: anotherLang.text,
                            level: selectedAnotherLanguageLevel,
                            formId: 0));
                        selectedAnotherLanguageLevel = 1;
                        anotherLang.clear();
                        showAnotherLangForm = false;
                        widget.setLanguagesFN(val: languages);
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
          visible: !showAnotherLangForm,
          child: Row(
            children: [
              Expanded(
                child: Card(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          showAnotherLangForm = true;
                        });
                      },
                      child: const Text(
                        'Add another langauge',
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
