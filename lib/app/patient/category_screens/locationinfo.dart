import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app/patient/category_screens/pharmasy_screen.dart';
import 'package:pharmazool/app/patient/category_screens/nearest_screen.dart';

class LocationInfo extends StatefulWidget {
  final String id;
  const LocationInfo(this.id, {super.key});

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  var area = TextEditingController(text: "");
  var locality = TextEditingController(text: "");
  var street = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.teal,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
              ),
              width: double.infinity,
              height: 700,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 330,
                      child: Text(
                        'قم بكتابة المحلية المنطقة و الحي او الشارع الرئيسي ثم اضغط بحث و سيقوم فارمازول بالبحث عن دواءك في الصيدليات المتوفرة بها',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextField(
                                  decoration: const InputDecoration(
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      hintText: ':المحلية',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  textAlign: TextAlign.right,
                                  controller: area,
                                  readOnly: true,
                                  onTap: () {
                                    setState(() {
                                      showPicker(context, areas, area);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: ':المنطقة',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  textAlign: TextAlign.right,
                                  controller: locality,
                                  readOnly: true,
                                  onTap: () {
                                    setState(() {
                                      showPicker(context, localities, locality);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: ':الحي/الشارع الرئيسي',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  textAlign: TextAlign.right,
                                  controller: street,
                                  readOnly: true,
                                  onTap: () {
                                    setState(() {
                                      showPicker(context, streets, street);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextButton(
                          child: const Text(
                            'بحث',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            AppCubit.get(context).getpharmacies(
                                id: int.parse(widget.id.toString()),
                                area: area.text,
                                locality: locality.text,
                                street: street.text);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PharmasyScreen()));
                            resetvalues(area, locality, street);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'او قم بالبحث عن طريق موقعك',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextButton(
                          child: const Text(
                            'البحث عن طريق موقعي',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            AppCubit.get(context).getpharmacies(
                                id: int.parse(widget.id.toString()),
                                area: area.text,
                                locality: locality.text,
                                street: street.text);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NearbyPharmacies()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
