import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/api_dio/services_paths.dart';
import 'package:pharmazool/app/doctor/screens/chek_step.dart';
import 'package:pharmazool/app/patient/auth_screens/confirm_password_screen.dart';
import 'package:pharmazool/app/patient/auth_screens/forget_password_screem.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/nav_screens/home_screen.dart';
import 'package:pharmazool/constants_widgets/utils/app_theme_colors.dart';
import 'package:pharmazool/constants_widgets/utils/media_query_values.dart';
import 'package:pharmazool/app/patient/lay_out.dart';
import 'package:pharmazool/constants_widgets/main_widgets/loadingwidget.dart';
import 'package:pharmazool/files_doctor/home_screen.dart';

class DoctorSignin extends StatefulWidget {
  const DoctorSignin({super.key});

  @override
  State<DoctorSignin> createState() => _DoctorSigninState();
}

class _DoctorSigninState extends State<DoctorSignin> {
  bool isloading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLoginSuccesState) {
          setState(() {
            isloading = false;
          });
          showmycheckdialog(context, 'sadsad');
        }
        if (state is AppLoginErrorState) {
          setState(() {
            isloading = false;
          });
          showmydialog(context, 'الحساب غير صحيح', Icons.warning);
        }
      },
      builder: ((context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.height * 0.1,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (emailController) {
                    if (emailController!.isEmpty) {
                      return 'برجاء ادخال اسم المستخدم';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.PharmaColor,
                    ),
                    labelText: 'أسم المستخدم',
                  ),
                ),
                SizedBox(
                  height: context.height * 0.04,
                ),
                SizedBox(
                  width: context.width * 1,
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (passwordController) {
                      if (passwordController!.isEmpty) {
                        return 'برجاء ادخال كلمة المرور';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: AppColors.PharmaColor,
                      ),
                      labelText: 'كلمة المرور',
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
                            builder: (context) => const ConfirmPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyle(
                            color: AppColors.PharmaColor,
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
                                setState(() {
                                  isloading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                  AppCubit.get(context).userlogin(
                                      username: emailController.text,
                                      password: passwordController.text);
                                  // HomeLayoutDoctor()));
                                }
                              },
                              child: const AutoSizeText(
                                'تسجيل الدخول',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
