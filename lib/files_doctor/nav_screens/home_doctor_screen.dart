import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/search_screen/search_bar.dart';
import 'package:pharmazool/components/constants.dart';
import 'package:pharmazool/components/main_body.dart';
import 'package:pharmazool/components/utils/assets_images_path.dart';

import 'package:pharmazool/files_doctor/categories_screens/Heart-care.dart';
import 'package:pharmazool/files_doctor/categories_screens/antibiotic.dart';
import 'package:pharmazool/files_doctor/categories_screens/baby-care.dart';
import 'package:pharmazool/files_doctor/categories_screens/body_care.dart';
import 'package:pharmazool/files_doctor/categories_screens/eye-care.dart';
import 'package:pharmazool/files_doctor/categories_screens/haircare.dart';
import 'package:pharmazool/files_doctor/categories_screens/medicaleq.dart';
import 'package:pharmazool/files_doctor/categories_screens/oral-care.dart';
import 'package:pharmazool/files_doctor/categories_screens/pain-relief.dart';

import 'package:pharmazool/files_doctor/nav_screens/search_screen.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../app_cubit/cubit.dart';

class HomeScreenDoctor1 extends StatelessWidget {
  const HomeScreenDoctor1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetDoctorGroubListLoadingState,
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
          builder: (context) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Container(
                      height: 140,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/logo_11zon_low.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SearchBar(() {
                    cubit.getsearchmedicine('');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchScreenDoctor()));
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: MainBody(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GridView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 8,
                                  mainAxisExtent: 110,
                                ),
                                children: [
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 7);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PainRelief()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            painrelife,
                                            height: 80,
                                            width: 80,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              "مسكن الألم",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 8);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Antibiotic()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            antibaiotic,
                                            height: 80,
                                            width: 120,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'مضاد حيوي',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 9);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EyeCare()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            eyecare,
                                            height: 80,
                                            width: 80,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'العناية بالعيون',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 10);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OralCare()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            diabetesCare,
                                            height: 80,
                                            width: 80,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'الامراض المزمنة',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 11);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BabyCare()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            babyCare,
                                            height: 80,
                                            width: 80,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'عناية الطفل',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 12);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HeartCare()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            heartCare,
                                            height: 80,
                                            width: 80,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'رعاية القلب',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 13);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MedicalEquipments()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            header,
                                            height: 80,
                                            width: 80,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'المعدات الطبية',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 14);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BodyCare()));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                            ppp,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const Expanded(
                                          child: Text(
                                            'العناية بالجسم',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getMedicinesByID(id: 15);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HairCare()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            hair,
                                            height: 80,
                                            width: 80,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'العناية بالشعر',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
