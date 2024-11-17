import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'form_method.dart';

class FormPartTow extends StatefulWidget {
  final GlobalKey<FormState> form2Key;
  final TextEditingController idNumber;
  final TextEditingController idCardNumber;
  final TextEditingController phone;
  final TextEditingController phoneSecondary;
  final TextEditingController telephone;
  final TextEditingController address;
  final TextEditingController addressDetails;
  final Function({File personalFileVal}) setImageFN;

  const FormPartTow({
    super.key,
    required this.form2Key,
    required this.idNumber,
    required this.idCardNumber,
    required this.phone,
    required this.phoneSecondary,
    required this.telephone,
    required this.address,
    required this.addressDetails,
    required this.setImageFN,
  });

  @override
  State<FormPartTow> createState() => _FormPartTowState();
}

class _FormPartTowState extends State<FormPartTow>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  FocusNode idNumberNode = FocusNode();
  final ImagePicker picker = ImagePicker();
  bool personalFileLoaded = false;

  getImage({
    required ImageSource source,
    required ImagePicker picker,
    required String imageType,
  }) async {
    final XFile? image = await picker.pickImage(
      source: source,
    );
    setState(() {
      personalFileLoaded = true;
      widget.setImageFN(personalFileVal: File(image!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: widget.form2Key,
          child: Column(
            children: [
              TextFormField(
                controller: widget.idNumber,
                focusNode: idNumberNode,
                maxLength: 11,
                keyboardType: TextInputType.number,
                decoration: decorationFormFieldFN(hintText: 'ID number'),
                validator: (text) {
                  if (text!.length != 11) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.idCardNumber,
                maxLength: 8,
                keyboardType: TextInputType.number,
                decoration: decorationFormFieldFN(hintText: 'ID card number'),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                initialValue: 'Pick personal image please',
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: GestureDetector(
                    onTap: () => getImage(
                      source: ImageSource.camera,
                      picker: picker,
                      imageType: 'personal',
                    ),
                    child: const Icon(Icons.camera),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => getImage(
                      source: ImageSource.gallery,
                      picker: picker,
                      imageType: 'personal',
                    ),
                    child: const Icon(Icons.image_search),
                  ),
                ),
                validator: (text) {
                  return null;

                  // if (!personalFileLoaded) {
                  //   return 'Pick personal image please';
                  // } else {
                  //   return null;
                  // }
                },
              ),
              TextFormField(
                controller: widget.phone,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: decorationFormFieldFN(hintText: 'Phone number'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (text) {
                  if (text!.length != 10) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.phoneSecondary,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration:
                    decorationFormFieldFN(hintText: 'Secondary phone number'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (text) {
                  if (text!.length != 10) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.telephone,
                keyboardType: TextInputType.number,
                maxLength: 7,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: decorationFormFieldFN(
                  hintText: 'Telephone number     *optional',
                ),
              ),
              TextFormField(
                controller: widget.address,
                decoration: decorationFormFieldFN(
                  hintText: 'Adress',
                ),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: widget.addressDetails,
                decoration: decorationFormFieldFN(
                  hintText: 'Adress details',
                ),
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
