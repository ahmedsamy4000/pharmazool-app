import 'package:flutter/material.dart';
import 'package:pharmazool/app/patient/nav_screens/barcode.dart';

import '../../../components/utils/assets_images_path.dart';

class FloatingBottonPatient extends StatelessWidget {
  const FloatingBottonPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BarCode()));
      },
      child: Image.asset(
        // cacheHeight: 20,
        scan,
        color: Colors.black,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
