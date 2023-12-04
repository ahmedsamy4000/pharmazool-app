import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/api_dio/services_paths.dart';
import 'package:pharmazool/app_cubit/states.dart';

import 'package:pharmazool/app/patient/nav_screens/history_screen.dart';
import 'package:pharmazool/app/patient/nav_screens/BottomNavBarWidget.dart';
import 'package:pharmazool/constants_widgets/main_widgets/doctor_drawer.dart';
import 'package:pharmazool/files_doctor/nav_screens/floating_botton.dart';
import 'package:pharmazool/files_doctor/drawer_screens/edite_profile.dart';
import 'package:pharmazool/files_doctor/nav_screens/home_doctor_screen.dart';

import 'package:pharmazool/onboarding_screens/onboarding_screen.dart';
import 'package:pharmazool/files_doctor/drawer_screens/shared_for_spoken.dart';
import 'package:pharmazool/files_doctor/drawer_screens/who_are_screen.dart';

import '../app_cubit/cubit.dart';

class HomeLayoutDoctor extends StatefulWidget {
  const HomeLayoutDoctor({Key? key}) : super(key: key);

  @override
  State<HomeLayoutDoctor> createState() => _HomeLayoutDoctorState();
}

class _HomeLayoutDoctorState extends State<HomeLayoutDoctor> {
  PageController? _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          key: key, // Assign the key to Scaffold.

          appBar: AppBar(
            elevation: 0,
            title: const AutoSizeText(
              "الرئيسية",
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
            leading: Container(),
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          endDrawer: const DoctorDrawer(),
          backgroundColor: Colors.white,
          floatingActionButton: const FloatingBotton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          bottomNavigationBar: bottomMainNavWidget(cubit, _pageController),
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                cubit.changeBottomNAv(index, _pageController);
              },
              children: const <Widget>[
                HomeScreenDoctor1(),
                HistoryScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
