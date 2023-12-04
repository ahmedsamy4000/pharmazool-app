import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:pharmazool/api_dio/services_paths.dart';
import 'package:pharmazool/app/patient/drawer_screens/shared_for_spoken.dart';

import 'package:pharmazool/app/patient/drawer_screens/who_are_screen.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app/patient/drawer_screens/motabra_screen.dart';
import 'package:pharmazool/app/patient/search_screen/search_screen_patient.dart';
import 'package:pharmazool/constants_widgets/main_widgets/patient_drawer.dart';

import 'package:pharmazool/constants_widgets/utils/media_query_values.dart';
import 'package:pharmazool/app/patient/drawer_screens/location.dart';
import 'package:pharmazool/constants_widgets/main_constants.dart';
import 'package:pharmazool/onboarding_screens/onboarding_screen.dart';

import '../category_screens/MedicineScreen.dart';

import '../search_screen/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        elevation: 0,
        title: const AutoSizeText(
          "الرئيسية",
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      endDrawer: const PatientDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  height: context.height * 0.2,
                  width: context.width * 0.9,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo_11zon_low.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: context.height * 0.01,
              ),
              SearchBar(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => SearchScreenPatient())));
              }),
              Container(
                color: Colors.white,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 130,
                  ),
                  itemBuilder: (context, index) {
                    return homeGridView(homelist[index], context);
                  },
                  itemCount: homelist.length,
                ),
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
    );
  }
}

homeGridView(HomeIconsModel homeIconModel, BuildContext context) {
  return InkWell(
    onTap: () {
      mycategorymodel = homeIconModel;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MedicineScreen(
                  int.parse(homeIconModel.genericid.toString()))));
      AppCubit.get(context).getMedicinesByID(id: homeIconModel.genericid!);
    },
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: context.height * 0.1,
              width: context.height * 0.1,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                homeIconModel.icon.toString(),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: context.height * 0.0035,
            ),
            AutoSizeText(
              homeIconModel.title.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  // fontSize: context.height * 0.017,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Schyler'),
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
          ],
        ),
      ),
    ),
  );
}
