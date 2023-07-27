import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmazool/app_cubit/cubit.dart';

import 'package:pharmazool/components/utils/assets_images_path.dart';

import 'package:pharmazool/files_doctor/home_screen.dart';

import 'package:pharmazool/mymodels/pharmacy_model.dart';

String? userName;
String? token;
PharmacyModel? pharmamodel;
List<PharmacyModel> pharmacyhistory = [];
dynamic lat1 = 31.265504445873205;
double long1 = 32.3016561;
double lat2 = 31.2640004386519;
double long2 = 32.30775007919794;

double myLat = 0;
double mylong = 0;

void setmypost() async {
  Position mypos = await determinePosition();
  myLat = mypos.latitude;
  mylong = mypos.longitude;
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

double calculateDistance(double lat1, double long1, double lat2, double long2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((long2 - long1) * p)) / 2;
  double distance = (12742 * asin(sqrt(a)) * 1000);

  return distance;
}

showmycheckdialog(
  context,
  String content,
) {
  var cubit = AppCubit.get(context);
  TextEditingController namecontroller = TextEditingController();
  TextEditingController licenceidcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SizedBox(
              width: 400,
              height: 400,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.emailAddress,
                          validator: (namecontoller) {
                            if (namecontoller!.isEmpty) {
                              return 'برجاء ادخال اسم الصيدلية';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'اسم الصيدلية',
                            labelText: 'أسم الصيدلية',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: licenceidcontroller,
                          keyboardType: TextInputType.number,
                          validator: (licenceController) {
                            if (licenceController!.isEmpty) {
                              return 'برجاء ادخال رقم الرخصة';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'رقم الرخصة',
                            labelText: 'رقم الرخصة',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const AutoSizeText(
                                  'رجوع',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (await cubit.checkpharmacy(
                                        licenceidcontroller.text,
                                        namecontroller.text)) {
                                      cubit.getdoctorpharmacy(
                                          licenceidcontroller.text);
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeLayoutDoctor()));
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      showmydialog(context,
                                          'البيانات غير صحيحة', Icons.warning);
                                    }
                                  }
                                },
                                child: const AutoSizeText(
                                  'تأكيد ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
}

showmydialog(context, String content, IconData icon) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 2,
                ),
                Text(content),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('رجوع'))
            ],
          ));
}

String baseurl = 'http://amc007-001-site8.etempurl.com/api/';

// 1- login endpoints:
String loginEndPoint = 'Authentication/Login';
String registerEndPoint = 'Authentication/Register';
String resetPasswordEndPoint = 'Authentication/ResetPassword';

// 2- area endpoints:
String getAreaByIdEndPoint = 'Area/:id';
String putAreaByIdEndPoint = 'Area/:id';
String deleteAreaByIdEndPoint = 'Area/:id';
String getAreaEndPoint =
    'Area?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postAreaEndPoint = 'Area';

// 3- generic endpoints:
String getGenericEndPoint =
    'Generic?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postGenericEndPoint = 'Generic';
String getGenericByIdEndPoint = 'Generic/:id';
String putGenericByIdEndPoint = 'Generic/:id';
String deleteGenericByIDEndPoint = 'Generic/:id';

// 4- groub endpoints:
String getGroubEndPoint = 'Group?pageSize=10';
String postGroupEndPoint = 'Group';
String getGroupByIdEndPoint = 'Group/:id';
String putGroupByIdEndPoint = 'Group/:id';
String deleteGroupByIDEndPoint = 'Group/:id';

// 5- locality endpoints:
String getLocalityEndPoint =
    'Locality?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postLocalityEndPoint = 'Locality';
String getLocalityByIdEndPoint = 'Locality/:id';
String putLocalityByIdEndPoint = 'Locality/:id';
String deleteLocalityByIDEndPoint = 'Locality/:id';

// 6- manufactory endpoints:
String getManufacturerEndPoint =
    'Manufacturer?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postManufacturerEndPoint = 'Manufacturer';
String getManufacturerByIdEndPoint = 'Manufacturer/:id';
String putManufacturerByIdEndPoint = 'Manufacturer/:id';
String deleteManufacturerByIDEndPoint = 'Manufacturer/:id';

// 7- manufactoryorigincountry:
String getManufacturerOrginCountryEndPoint =
    'ManufacturerOrginCountry?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postManufacturerOrginCountryEndPoint = 'ManufacturerOrginCountry';
String getManufacturerOrginCountryByIdEndPoint = 'ManufacturerOrginCountry/:id';
String putManufacturerOrginCountryByIdEndPoint = 'ManufacturerOrginCountry/:id';
String deleteManufacturerOrginCountryByIDEndPoint =
    'ManufacturerOrginCountry/:id';

// 8- medicine endpoints:
String getMedicineEndPoint = 'Medicine?PageSize=100';
String postMedicineEndPoint = 'Medicine';
String getMedicineByIdEndPoint = 'Medicine/:id';
String putMedicineByIdEndPoint = 'Medicine/:id';
String deleteMedicineByIDEndPoint = 'Medicine/:id';

// 8- medicinegroub endpoints:
String getMedicineGroupEndPoint =
    'Medicine?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postMedicineGroupEndPoint = 'Medicine';
String getMedicineGroupByIdEndPoint = 'MedicineGroup/:MedicineId/:GroupId';
String putMedicineGroupByIdEndPoint = 'MedicineGroup/:MedicineId/:GroupId';
String deleteMedicineGroupByIDEndPoint = 'MedicineGroup/:MedicineId/:GroupId';

// 9- origincountry endpoints:
String getOrginCountryEndPoint =
    'OrginCountry?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postOrginCountryEndPoint = 'OrginCountry';
String getOrginCountryByIdEndPoint = 'OrginCountry/:id';
String putOrginCountryByIdEndPoint = 'OrginCountry/:id';
String deleteOrginCountryByIDEndPoint = 'OrginCountry/:id';

// 10- pharmacy endpoints:
String getPharmacyEndPoint = 'Pharmacy?PageSize=20';
String postPharmacyEndPoint = 'Pharmacy';
String getPharmacyByIdEndPoint = 'Pharmacy/:id';
String putPharmacyByIdEndPoint = 'Pharmacy/:id';
String deletePharmacyByIDEndPoint = 'Pharmacy/:id';

// 11- pharmacymedicine endpoints:
String getPharmacyMedicineEndPoint =
    'PharmacyMedicine?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postPharmacyMedicineEndPoint = 'PharmacyMedicine';
String getPharmacyMedicineByIdEndPoint =
    'PharmacyMedicine/:MedicineId/:PharmacyId';
String putPharmacyMedicineByIdEndPoint =
    'PharmacyMedicine/:MedicineId/:PharmacyId';
String deletePharmacyMedicineByIDEndPoint =
    'PharmacyMedicine/:MedicineId/:PharmacyId';

// 12- ProductStatus endpoints:
String getProductStatusEndPoint =
    'ProductStatus?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postProductStatusEndPoint = 'ProductStatus';
String getProductStatusByIdEndPoint = 'ProductStatus/:id';
String putProductStatusByIdEndPoint = 'ProductStatus/:id';
String deleteProductStatusByIDEndPoint = 'ProductStatus/:id';

// 13- ProductStatus endpoints:
String getUnitEndPoint =
    'Unit?PageIndex=<integer>&PageSize=<integer>&Sort=<string>&Search=<string>';
String postUnitEndPoint = 'Unit';
String getUnitByIdEndPoint = 'Unit/:id';
String putUnitByIdEndPoint = 'Unit/:id';
String deleteUnitByIDEndPoint = 'Unit/:id';

HomeIconsModel? mycategorymodel;

class HomeIconsModel {
  String? icon;
  String? id;
  String? title;
  String? genericid;

  HomeIconsModel(
      {required this.icon, required this.title, required this.genericid});
}

List<HomeIconsModel> homelist = [
  HomeIconsModel(icon: painrelife, title: "مسكن الألم", genericid: '7'),
  HomeIconsModel(icon: antibaiotic, title: 'مضاد حيوي', genericid: '8'),
  HomeIconsModel(icon: eyecare, title: 'العناية بالعيون', genericid: '9'),
  HomeIconsModel(icon: diabetesCare, title: 'الامراض المزمنة', genericid: '10'),
  HomeIconsModel(icon: babyCare, title: 'عناية الطفل', genericid: '11'),
  HomeIconsModel(icon: heartCare, title: 'رعاية القلب', genericid: '12'),
  HomeIconsModel(icon: header, title: 'المعدات الطبية', genericid: '13'),
  HomeIconsModel(icon: ppp, title: 'العناية بالجسم', genericid: '14'),
  HomeIconsModel(icon: hair, title: 'العناية بالشعر', genericid: '15'),
];
void resetvalues(TextEditingController result, TextEditingController result2,
    TextEditingController result3) {
  result.text = '';
  result2.text = '';
  result3.text = '';
}

showPicker(
    BuildContext context, List<dynamic> region, TextEditingController result) {
  Picker picker = Picker(
      adapter: PickerDataAdapter<String>(pickerData: region),
      changeToFirst: false,
      textAlign: TextAlign.left,
      textStyle: TextStyle(
        color: Colors.blue,
      ),
      selectedTextStyle: TextStyle(color: Colors.red),
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        result.text = picker.getSelectedValues()[0];
      });

  picker.showModal(context);
}

final List<Map<String, dynamic>> clityList = [
  {
    "address": "'موقع فارمسي زول'",
    "id": "jaipur_01",
    "image":
        "https://i.pinimg.com/originals/b7/3a/13/b73a132e165978fa07c6abd2879b47a6.png",
    "lat": 26.8206,
    "lng": 30.8025,
    "name": "'موقع فارمسي زول'",
    "phone": "+201064422809",
    "region": "North Africa"
  }
];

double? lat = 19.13232;
double? long = 41.08591;
String? name = '';
String? address = '';

List<dynamic> areas = [
  "cairo",
  "portsaid",
  "alexandria",
  "suez",
];
List<dynamic> localities = [
  "elmaadi",
  "oktober",
  "elasafra",
];
List<dynamic> streets = [
  "salah salem",
  "elmaadi",
  "elzamalek",
];
List<dynamic> data = [
  "القاهرة",
  "الجيزة",
  "الأسكندرية",
  "الدقهلية",
  "البحر الأحمر",
  "البحيرة",
  "الفيوم",
  "الغربية",
  "الإسماعلية",
  "المنوفية",
  "المنيا",
  "القليوبية"
      "الوادي الجديد"
      "السويس",
  "اسوان",
  "اسيوط",
  "بني سويف",
  "بورسعيد",
  "دمياط",
  "الشرقية",
  "جنوب سيناء"
      "كفر الشيخ",
  "مطروح",
  "الأقصر",
  "قنا",
  "شمال سيناء"
      "سوهاج",
];
const PickerData = '''
[
    {
        "a": [
            {
                "a1": [
                    1,
                    2,
                    3,
                    4
                ]
            },
            {
                "a2": [
                    5,
                    6,
                    7,
                    8,
                    555,
                    666,
                    999
                ]
            },
            {
                "a3": [
                    9,
                    10,
                    11,
                    12
                ]
            }
        ]
    },
    {
        "b": [
            {
                "b1": [
                    11,
                    22,
                    33,
                    44
                ]
            },
            {
                "b2": [
                    55,
                    66,
                    77,
                    88,
                    99,
                    1010,
                    1111,
                    1212,
                    1313,
                    1414,
                    1515,
                    1616
                ]
            },
            {
                "b3": [
                    1010,
                    1111,
                    1212,
                    1313,
                    1414,
                    1515,
                    1616
                ]
            }
        ]
    },
    {
        "c": [
            {
                "c1": [
                    "a",
                    "b",
                    "c"
                ]
            },
            {
                "c2": [
                    "aa",
                    "bb",
                    "cc"
                ]
            },
            {
                "c3": [
                    "aaa",
                    "bbb",
                    "ccc"
                ]
            },
            {
                "c4": [
                    "a1",
                    "b1",
                    "c1",
                    "d1"
                ]
            }
        ]
    }
]
    ''';
