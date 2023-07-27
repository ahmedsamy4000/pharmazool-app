import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/app/patient/auth_screens/confirm_password_screen.dart';
import 'package:pharmazool/app/patient/auth_screens/forget_password_screem.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';

import 'package:pharmazool/components/utils/app_theme_colors.dart';
import 'package:pharmazool/components/utils/media_query_values.dart';
import 'package:pharmazool/app/patient/lay_out.dart';
import 'package:pharmazool/components/widgets/loadingwidget.dart';

class PatientSignin extends StatefulWidget {
  const PatientSignin({super.key});

  @override
  State<PatientSignin> createState() => _PatientSigninState();
}

class _PatientSigninState extends State<PatientSignin> {
  bool isloading = false;
  var namEController = TextEditingController();
  var phonEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLoginSuccesState) {
          setState(() {
            isloading = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeLayOut()));
        }
        if (state is AppLoginErrorState) {
          setState(() {
            isloading = false;
          });
          showmydialog(context, 'الحساب غير صحيح', Icons.warning);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.height * 0.1,
                ),
                TextFormField(
                  controller: namEController,
                  keyboardType: TextInputType.name,
                  onTap: () {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الاسم غير مسجل ';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.PharmaColor,
                    ),
                    labelText: 'ادخل الاسم',
                  ),
                ),
                SizedBox(
                  height: context.height * 0.04,
                ),
                SizedBox(
                  width: context.width * 1,
                  child: TextFormField(
                    controller: phonEController,
                    keyboardType: TextInputType.name,
                    onTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'رقم الهاتف غير مسجل';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.numbers,
                        color: AppColors.PharmaColor,
                      ),
                      labelText: 'ادخل رقم الهاتف',
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ConfirmPasswordPatientScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'نسيت كلمة المرور',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: context.height * 0.04,
                ),
                isloading
                    ? loading()
                    : Center(
                        child: Container(
                          width: context.width * 0.5,
                          // height: context.height * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.PharmaColor,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                AppCubit.get(context).userlogin(
                                    username: namEController.text,
                                    password: phonEController.text);
                              }
                            },
                            child: const AutoSizeText(
                              'تسجيل الدخول',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
