// ignore_for_file: must_be_immutable, duplicate_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DefaultTextFormFieldForProblem extends StatelessWidget {
  Function validator;

  // Function? onChanged;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String hintText;
  final int maxLines;

  DefaultTextFormFieldForProblem({
    Key? key,
    required this.validator,
    // this.onChanged,
    required this.textEditingController,
    required this.textInputType,
    required this.hintText,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextFormField(
        validator: (value) => validator(value),
        textAlign: TextAlign.end,
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: false,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.black),
        maxLines: maxLines,
        decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            hintStyle:
                TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }
}
