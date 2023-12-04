import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pharmazool/constants_widgets/utils/assets_images_path.dart';

HomeIconsModel? mycategorymodel;

class HomeIconsModel {
  String? icon;
  String? id;
  String? title;
  int? genericid;

  HomeIconsModel(
      {required this.icon, required this.title, required this.genericid});
}

List<HomeIconsModel> homelist = [
  HomeIconsModel(icon: painrelife, title: "مسكن الألم", genericid: 1),
  HomeIconsModel(icon: antibaiotic, title: 'مضاد حيوي', genericid: 2),
  HomeIconsModel(icon: eyecare, title: 'العناية بالعيون', genericid: 3),
  HomeIconsModel(icon: diabetesCare, title: 'الامراض المزمنة', genericid: 4),
  HomeIconsModel(icon: babyCare, title: 'عناية الطفل', genericid: 5),
  HomeIconsModel(icon: heartCare, title: 'رعاية القلب', genericid: 6),
  HomeIconsModel(icon: header, title: 'المعدات الطبية', genericid: 7),
  HomeIconsModel(icon: ppp, title: 'العناية بالجسم', genericid: 8),
  HomeIconsModel(icon: hair, title: 'العناية بالشعر', genericid: 9),
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
