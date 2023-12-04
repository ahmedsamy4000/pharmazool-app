import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pharmazool/api_dio/services_paths.dart';
import 'package:pharmazool/files_doctor/drawer_screens/edite_profile.dart';
import 'package:pharmazool/files_doctor/drawer_screens/shared_for_spoken.dart';
import 'package:pharmazool/files_doctor/drawer_screens/who_are_screen.dart';
import 'package:pharmazool/onboarding_screens/onboarding_screen.dart';

class DoctorDrawer extends StatefulWidget {
  const DoctorDrawer({super.key});

  @override
  State<DoctorDrawer> createState() => _DoctorDrawerState();
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    style: const TextStyle(color: Colors.black, fontSize: 20),
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
    );
  }
}
