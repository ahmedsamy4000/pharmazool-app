import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/nav_screens/floating_botton%20copy.dart';
import 'nav_screens/history_screen.dart';
import 'nav_screens/home_screen.dart';
import 'nav_screens/BottomNavBarWidget.dart';

class HomeLayOut extends StatefulWidget {
  const HomeLayOut({super.key});

  @override
  State<HomeLayOut> createState() => _HomeLayOutState();
}

class _HomeLayOutState extends State<HomeLayOut> {
  // int _currentIndex = 0;
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                cubit.changeBottomNAv(index, _pageController);
              },
              children: const <Widget>[
                HomeScreen(),
                HistoryScreen(),
              ],
            ),
          ),
          floatingActionButton: const FloatingBottonPatient(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          bottomNavigationBar: bottomMainNavWidget(cubit, _pageController),
        );
      },
    );
  }
}
