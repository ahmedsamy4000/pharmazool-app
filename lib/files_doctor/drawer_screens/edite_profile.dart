import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/components/utils/app_theme_colors.dart';
import 'package:pharmazool/files_doctor/drawer_screens/confirm_edite.dart';

import 'package:pharmazool/components/widgets/default_text_form_field_for_problem.dart';

class EditeProfile extends StatefulWidget {
  EditeProfile({super.key});

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  var controller1 = TextEditingController();

  var controller2 = TextEditingController();

  var controller3 = TextEditingController();

  var controller4 = TextEditingController();

  var controller5 = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$userName ,مرحبا بك' '\n' '${pharmamodel!.name}',
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        elevation: 0,
        toolbarHeight: 120,
      ),
      backgroundColor: Colors.teal,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                DefaultTextFormFieldForProblem(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'برجاء ادخال بيانات';
                    }
                  },
                  textEditingController: controller1,
                  textInputType: TextInputType.text,
                  hintText: "موقع الصيدلية الجغرافي",
                  maxLines: 1,
                ),
                DefaultTextFormFieldForProblem(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'برجاء ادخال بيانات';
                    }
                  },
                  textEditingController: controller2,
                  textInputType: TextInputType.text,
                  hintText: "رابط خدمات الموقع",
                  maxLines: 1,
                ),
                DefaultTextFormFieldForProblem(
                  validator: (value) {
                    if (value.isEmpty || value.length <= 10) {
                      return 'برجاء ادخال بيانات';
                    }
                  },
                  textEditingController: controller3,
                  textInputType: TextInputType.text,
                  hintText: "رقم المحمول",
                  maxLines: 1,
                ),
                DefaultTextFormFieldForProblem(
                  validator: (value) {
                    if (value.isEmpty || value.length <= 11) {
                      return 'برجاء ادخال بيانات';
                    }
                  },
                  textEditingController: controller4,
                  textInputType: TextInputType.text,
                  hintText: "مواعيد العمل",
                  maxLines: 1,
                ),
                DefaultTextFormFieldForProblem(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'برجاء ادخال بيانات';
                    }
                  },
                  textEditingController: controller5,
                  textInputType: TextInputType.text,
                  hintText: "رقم الرخصة",
                  maxLines: 1,
                ),
                MaterialButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmEdit(
                                    loc: controller1.text,
                                    link: controller2.text,
                                    phone: controller3.text,
                                    time: controller4.text,
                                    licence: controller5.text,
                                  )));
                    }
                  },
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 8,
                    ),
                    child: const Text(
                      "حفظ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
