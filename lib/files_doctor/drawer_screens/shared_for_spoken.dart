import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmazool/components/utils/app_theme_colors.dart';
import 'package:pharmazool/components/widgets/default_text_form_field_for_problem.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class SharedForSpoken extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController positionController = TextEditingController();

  TextEditingController explainYourProblemController = TextEditingController();

  GlobalKey<FormState> reportKey = GlobalKey<FormState>();

  SharedForSpoken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: AppColors.PharmaColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      Text(
                        'في فارمازول',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'نحن نهتم بكلماتك و نعمل علي تحسين خدماتنا بناء عليها, شاركنا رأيك و اجعل صوتك مسموعا',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              DefaultTextFormFieldForProblem(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Your Name';
                  } else if (value.length < 3) {
                    return 'Please Enter Valid Name';
                  }
                },
                textEditingController: nameController,
                textInputType: TextInputType.text,
                hintText: 'الاسم',

                maxLines: 1,
                // maxLines: 1,
              ),

              DefaultTextFormFieldForProblem(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Your Phone';
                  }
                },
                textInputType: TextInputType.number,
                hintText: 'رقم التليفون',
                textEditingController: phoneController,
                maxLines: 1,
                // maxLines: 1,
              ),

              DefaultTextFormFieldForProblem(
                validator: (value) {
                  if (value.isEmpty || value.length <= 11) {
                    return 'Please Explain Your Problem';
                  }
                },
                textEditingController: explainYourProblemController,
                textInputType: TextInputType.text,
                hintText: 'اشرح ما هو اقتراحك',
                maxLines: 6,
              ),
              const SizedBox(height: 50),
              MaterialButton(
                onPressed: () {},
                color: AppColors.PharmaColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 8,
                  ),
                  child: const Text(
                    'شاركنا اقتراحك',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              const Text(
                'او تواصل معنا علي التالي',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        launch(
                            'https://www.facebook.com/profile.php?id=100068365090281&mibextid=LQQJ4d');
                      },
                      child: FaIcon(
                        FontAwesomeIcons.facebookSquare,
                        color: Colors.blue,
                        size: 60,
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.instagramSquare,
                      color: Colors.redAccent,
                      size: 60,
                    ),
                    FaIcon(
                      FontAwesomeIcons.whatsappSquare,
                      color: Colors.green,
                      size: 60,
                    )
                  ],
                ),
              )
              // SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
