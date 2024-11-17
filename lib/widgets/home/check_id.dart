import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
// import '../../models/config.dart';
import '../../providers/user_provider.dart';
import 'user_info.dart';

class CheckId extends StatefulWidget {
  const CheckId({super.key});

  @override
  State<CheckId> createState() => _CheckIdState();
}

class _CheckIdState extends State<CheckId> {
  TextEditingController id = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showButton = false;

  RoundedLoadingButtonController confirmController =
      RoundedLoadingButtonController();

  confirm() async {
    if (formKey.currentState!.validate()) {
      if (showButton) {
        await Provider.of<UserProvider>(context, listen: false)
            .checkUserStateFN(idNumber: id.text)
            .then((value) async {
          if (value.contains('Task')) {
            print(value);
            // move to new page

            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const UserInfo()));

            confirmController.success();
            await Future.delayed(Duration(milliseconds: 300));

            // move to new page and prevent back
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const UserInfo()),
                (route) => false);
          } else if (value.contains('No record')) {
            print(value);
            confirmController.error();
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value)));
            print(value);
            confirmController.error();
          }
          await Future.delayed(Duration(milliseconds: 1000));
          confirmController.reset();
        });
      } else {
        confirmController.reset();
      }
    } else {}
  }

  List<Map<String, String>> numbers = [
    {'ar': '٠', 'en': '0'},
    {'ar': '١', 'en': '1'},
    {'ar': '٢', 'en': '2'},
    {'ar': '٣', 'en': '3'},
    {'ar': '٤', 'en': '4'},
    {'ar': '٥', 'en': '5'},
    {'ar': '٦', 'en': '6'},
    {'ar': '٧', 'en': '7'},
    {'ar': '٨', 'en': '8'},
    {'ar': '٩', 'en': '9'},
  ];

  setToEnglishNumber({required String val}) {
    String newValue = '';
    for (var v = 0; v < val.length; v++) {
      for (var i = 0; i < numbers.length; i++) {
        if (val[v] == numbers[i]['ar'] || val[v] == numbers[i]['en']) {
          newValue += numbers[i]['en']!;
        }
      }
    }
    setState(() {
      id.text = newValue;
      id.selection =
          TextSelection.fromPosition(TextPosition(offset: id.text.length));
    });
    print(id.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'lib/assets/images/undpLogo.png',
                  width: 200,
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Enter you id number please',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: id,
                        maxLength: 11,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            setToEnglishNumber(val: val);
                          }
                          if (val.length == 11) {
                            setState(() {
                              showButton = true;
                            });
                          } else {
                            setState(() {
                              showButton = false;
                            });
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'This feild is required';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: RoundedLoadingButton(
                    controller: confirmController,
                    valueColor: Colors.white,
                    borderRadius: 4,
                    resetDuration: Duration(milliseconds: 100),
                    width: 200,
                    elevation: 10,
                    height: 40,
                    // duration: Duration(seconds: 2),
                    color: showButton ? Colors.green : Colors.grey,
                    onPressed: () async => await confirm(),
                    child: Text('Confirm'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
