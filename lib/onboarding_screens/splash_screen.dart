import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pharmazool/api_dio/services_paths.dart';
import 'package:pharmazool/constants_widgets/utils/app_theme_colors.dart';
import 'package:pharmazool/onboarding_screens/onboarding_screen.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Column(
        children: [
          // Image.asset(AppAssets.mainLogoPng),
          SizedBox(height: 180),
          Container(
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // image: AssetImage(AppAssets.mainLogoPng),
                image: AssetImage('assets/images/logo_11zon_low.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 35,
            ),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 7.0,
              animationDuration: 2500,
              percent: 1,
              barRadius: const Radius.circular(50),
              progressColor: AppColors.PharmaColor,
              onAnimationEnd: () async {
                setmypost();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnBoardingScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
