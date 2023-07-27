import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/app_cubit/states.dart';

import 'package:pharmazool/app/patient/nav_screens/history_screen.dart';
import 'package:pharmazool/app/patient/nav_screens/BottomNavBarWidget.dart';
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
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/47.jpg"),
                        radius: 50,
                      ),
                      Positioned(
                        bottom: 8.0,
                        left: 4.0,
                        child: Text(
                          userName!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                  leading: const Icon(Icons.person_pin),
                  title: const Text(
                    'من نحن ؟',
                    style: TextStyle(
                      color: Colors.black,
                      // fontSize: context.height * 0.017,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Schyler',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WhoAreScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                  leading: const Icon(Icons.message),
                  title: const Text(
                    'شاركنا باقتراحك',
                    style: TextStyle(
                        color: Colors.black,
                        // fontSize: context.height * 0.017,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Schyler'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SharedForSpoken(),
                      ),
                    );
                  },
                ),
                const SizedBox(),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                  leading: const Icon(Icons.location_on),
                  title: const Text(
                    'تعديل الملف الشخصي',
                    style: TextStyle(
                        color: Colors.black,
                        // fontSize: context.height * 0.017,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Schyler'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditeProfile(),
                      ),
                    );
                  },
                ),
                const SizedBox(),
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'تسجيل خروج',
                    style: TextStyle(
                        color: Colors.black,
                        // fontSize: context.height * 0.017,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Schyler'),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const OnBoardingScreen();
                      }),
                    );
                    setState(() {
                      userName = '';
                      token = '';
                    });
                  },
                ),
              ],
            ),
          ),
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
