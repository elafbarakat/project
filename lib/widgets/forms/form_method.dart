import 'package:flutter/material.dart';

UnderlineInputBorder focusedBorder = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.orange),
);
UnderlineInputBorder enabledBorder = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.blueGrey),
);

InputDecoration decorationFormFieldFN({required String hintText}) {
  return InputDecoration(
    focusedBorder: focusedBorder,
    enabledBorder: enabledBorder,
    hintText: hintText,
  );
}

Widget sizedBox = const SizedBox(height: 20);

Widget divider = const Divider(color: Colors.black45, thickness: 1);

showSnack(context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),

      content: SizedBox(
          height: 120,
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Hii this is GFG\'s SnackBar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Ok'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('cancel'),
                    ),
                  ],
                )
              ],
            ),
          )),
      backgroundColor: Colors.redAccent,
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      )),
      // dismissDirection: DismissDirection.none,
      onVisible: () {},
    ),
  );
}
