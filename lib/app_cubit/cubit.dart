import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:basic_utils/basic_utils.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmazool/api_dio/services_paths.dart';
import 'package:pharmazool/api_dio/dio.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/nav_screens/barcode.dart';
import 'package:pharmazool/app/patient/nav_screens/home_screen.dart';
import 'package:pharmazool/repo/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:pharmazool/files_doctor/nav_screens/home_doctor_screen.dart';
import 'package:pharmazool/mymodels/medicine_model.dart';
import 'package:pharmazool/mymodels/pharmacy_model.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import '../app/patient/nav_screens/history_screen.dart';
import 'dart:developer' as logDev;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isInitialized = false;

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const BarCode(),
  ];
  int doctorindex = 0;
  List doctorscreens = [
    const HomeScreenDoctor1(),
    const HistoryScreen(),
    const BarCode(),
  ];
  void changeindex(int index) {
    currentIndex = index;
    emit(changeBottomNAvState());
  }

  var searchList = [];
  void getsearchmedicine(String search) {
    searchList = [];
    emit(GetMedicinesByIdLoadingState());
    //get data without pagination
    DioHelper.getData(
      url: 'Medicine/GetAllMedicine?PageSize=40&Search=$search',
    ).then((value) {
      value.data['data'].forEach((element) {
        if (search.isNotEmpty) {
          searchList.add(MedicineModel.fromJson(element));
        }
      });
      search = '';
      updatestatus(searchList);
      emit(GetMedicinesByIdSuccesState());
    }).catchError((error) {
      print(error);
      emit(GetMedicinesByIdErrorState());
    });
  }

  List<MedicineModel> medicinesbyId = [];

  // void getmedicinebyrepo({int id = 0, String search = ''}) async {
  // medicinesbyId = [];
  //GetMedicineData data = GetMedicineData();
  //emit(GetMedicinesByIdLoadingState());
  //try {
  //  medicinesbyId = await data.getmedicinelist(id, search, medicinesbyId);
  //emit(GetMedicinesByIdSuccesState());
  //} catch (error) {
  // print(error.toString());
  //emit(GetMedicinesByIdErrorState());
  //}
  // }
  void updatestatus(var pharmacymedicinelist) {
    pharmacymedicinelist.forEach((element) {
      element.pharmacyMedicines!.forEach((element1) {
        if (element1['pharmacyId'] == int.parse(pharmamodel!.id!)) {
          element.status = true;
        } else {
          element.status = false;
        }
      });
    });
  }

  void searchGenericMedicinePatient(String search, int id) {
    medicinesbyId = [];
    emit(SearchGenericMedicinePatientLoadingState());
    DioHelper.getData(
      url:
          'Medicine/GetMedicineByGeneric?genericId=$id&Search=$search&PageSize=15',
    ).then((value) {
      value.data['data'].forEach((element) {
        medicinesbyId.add(MedicineModel.fromJson(element));
      });
      emit(SearchGenericMedicinePatientSuccesState());
    }).catchError((error) {
      emit(SearchGenericMedicinePatientErrorState());
    });
  }

  void getMedicinesByID({int id = 0, String search = ""}) {
    medicinesbyId = [];
    emit(GetMedicinesByIdLoadingState());
    DioHelper.getData(
      url:
          'Medicine/GetMedicineByGeneric?genericId=$id&PageSize=15&Search=$search',
    ).then((value) {
      value.data['data'].forEach((element) {
        medicinesbyId.add(MedicineModel.fromJson(element));
      });
      updatestatus(medicinesbyId);
      emit(GetMedicinesByIdSuccesState());
    }).catchError((error) {
      emit(GetMedicinesByIdErrorState());
    });
  }

  void medicinelistpagination(
      {var medicinelist, int? page, int? id, String? search}) async {
    emit(IncreamentOfMedicineListLoadingState());
    GetMedicineData data = GetMedicineData();
    try {
      await data.medicinelistpaginationRepo(medicinelist, id!, page!, search!);

      emit(IncreamentOfMedicineListSuccesState());
    } catch (error) {
      print(error);
      emit(IncreamentOfMedicineListErrorState());
    }
  }

  void userlogin({required String username, required String password}) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
        url: loginEndPoint,
        data: {'userName': username, 'password': password}).then((value) {
      print(value.data.toString());
      userName = value.data['userName'];
      token = value.data['token'];
      emit(AppLoginSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorState());
    });
  }

  void resetPassword(
      {required String phonenumber,
      required String password,
      required String licenceId,
      required int type}) {
    DioHelper.postData(url: resetPasswordEndPoint, data: {
      "phoneNumber": phonenumber,
      "licenseId": licenceId,
      "type": type,
      "newPassword": password
    }).then((value) {
      emit(AppResetPasswordSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppResetPasswordErrorState());
    });
  }

  Future<bool> checkpharmacy(String licId, String name) async {
    bool isverified = false;
    await DioHelper.getData(url: getPharmacyEndPoint).then((value) {
      value.data['data'].forEach((element) {
        if (element['licenceId'] == licId && element['name'] == name) {
          isverified = true;
        }
      });
    }).catchError((error) {
      print(error);
    });
    return isverified;
  }

  void patientRegister({
    required String username,
    required String phone,
    required String password,
    required int type,
  }) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(url: registerEndPoint, data: {
      'firstName': 'osamaa22',
      'lastName': 'osama22',
      'phone': phone,
      'email': 'asdsad@gmail.com',
      'userName': username,
      'password': password,
      'licenseId': 'sdas5445',
      'type': '$type'
    }).then((value) {
      print(value.data.toString());
      userName = value.data['userName'];
      token = value.data['token'];
      emit(AppRegisterSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppRegisterErrorState());
    });
  }

  void doctorRegister(
      {required String username,
      required String phone,
      required String password,
      required int type,
      required String licenceId,
      required String pharmacyName,
      context}) async {
    emit(DoctorRegisterLoadingState());
    if (await checkpharmacy(licenceId, pharmacyName)) {
      print('success');
      DioHelper.postData(url: registerEndPoint, data: {
        'firstName': 'osamaa22',
        'lastName': 'osama22',
        'phone': phone,
        'email': 'asdsad@gmail.com',
        'userName': username,
        'password': password,
        'licenseId': licenceId,
        'type': '$type'
      }).then((value) {
        print(value.data.toString());
        userName = value.data['userName'];
        token = value.data['token'];
        getdoctorpharmacy(licenceId);
        showmydialog(
            context, 'تم انشاء الحساب', Icons.assignment_turned_in_outlined);
        emit(DoctorRegisterSuccesState());
      }).catchError((error) {
        print(error);
        emit(DoctorRegisterErrorState());
      });
    } else {
      emit(DoctorRegisterErrorState());
      showmydialog(context, '1 الحساب غير صحيح', Icons.warning);
    }
  }

  bool checkarea = false;
  List<PharmacyModel> filteredpharmacyList = [];
  List<PharmacyModel> pharmacyList = [];
  List<Marker> pharmaciesmarkers = [];
  List<PharmacyModel> nearestpharmacies = [];
  void resetmarker() {
    pharmaciesmarkers = [];
    pharmaciesmarkers.add(
      Marker(
        markerId: const MarkerId('موقعي'),
        position: LatLng(myLat, mylong),
        infoWindow: InfoWindow(onTap: () {}, title: 'my location'),
      ),
    );
  }

  void getpharmacies(
      {int id = 0,
      String area = "",
      String locality = "",
      String street = ""}) {
    checkarea = false;
    resetmarker();
    pharmacyList = [];
    filteredpharmacyList = [];
    nearestpharmacies = [];
    emit(GetPharmaciesLoadingState());
    DioHelper.getData(url: getPharmacyEndPoint).then((value) {
      value.data['data'].forEach((element) {
        element['pharmacyMedicines'].forEach((pharmacieselement) {
          if (pharmacieselement['medicineId'] == id) {
            pharmacyList.add(PharmacyModel.fromJson(element));
            if (element['latitude'] != null) {
              double distance = calculateDistance(
                  myLat,
                  mylong,
                  double.parse(element['latitude']),
                  double.parse(element['longitude']));
              print(distance.toInt());
              if (distance.toInt() < 5000) {
                /*  pharmaciesmarkers.add(
                  Marker(
                    markerId: MarkerId(element['name']),
                    position: LatLng(double.parse(element['latitude']),
                        double.parse(element['longitude'])),
                    infoWindow:
                        InfoWindow(onTap: () {}, title: element['name']),
                  ),
                );*/
                nearestpharmacies.add(PharmacyModel(
                    address: element['address'],
                    area: element['area']['name'],
                    street: element['street'],
                    id: element['id'].toString(),
                    distance: distance.toInt(),
                    licenseId: element['licenceId'],
                    locality: element['locality']['name'],
                    name: element['name'],
                    phone: element['phone'],
                    medicines: element['pharmacyMedicines']));
                nearestpharmacies
                    .sort((a, b) => a.distance!.compareTo(b.distance!));
              } else {
                return;
              }
            }
          }
        });
      });
      if (area.isNotEmpty) {
        checkarea = !checkarea;
        pharmacyList.forEach((element) {
          if (locality.isEmpty) {
            if (element.area == area) {
              filteredpharmacyList.add(element);
            }
          } else {
            if (element.locality == locality && element.area == area) {
              if (street.isNotEmpty) {
                if (element.street == street) {
                  filteredpharmacyList.add(element);
                } else {
                  return;
                }
              } else {
                filteredpharmacyList.add(element);
              }
            }
          }
        });
      }
      print(pharmacyList.length);
      emit(GetPharmaciesSuccesState());
    }).catchError((error) {
      print(error);
      emit(GetPharmaciesErrorState());
    });
  }

  String searcher = '';
  List<String> doctorSearcher = [''];

  File? textImage;
  Future<String> getGalleryImageForPatientSearch() async {
    String search = '';
    XFile? PickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (PickedFile != null) {
      textImage = File(PickedFile.path);
      List<TextBlock> rectext = await recogniseText(textImage);
      rectext.forEach((element) {
        search = search + element.text;
      });

      emit(PickImageSuccesState());
    } else {
      emit(PickImageErrorState());
    }
    return search;
  }

  Future<void> getPostImage() async {
    XFile? PickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    searcher = '';
    doctorSearcher = [''];
    if (PickedFile != null) {
      textImage = File(PickedFile.path);
      List<TextBlock> rectext = await recogniseText(textImage);
      rectext.forEach((element) {
        searcher = searcher + element.text;
        doctorSearcher.add(element.text);
      });
      print(doctorSearcher);

      emit(PickImageSuccesState());
    } else {
      emit(PickImageErrorState());
    }
  }

  Future<void> getPdfText() async {
    doctorSearcher = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path ?? "");

      try {
        String pdflist = await ReadPdfText.getPDFtext(file.path);
        var splittedText = pdflist.replaceAll('\n', '');
        List<String> firstresult = splittedText.split(' ');
        doctorSearcher = firstresult;
        doctorSearcher = doctorSearcher.toSet().toList();
      } catch (error) {
        print(error);
      }
    }
  }

  File? textImage2;

  Future<void> getPostImage2() async {
    XFile? PickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    searcher = '';
    doctorSearcher = [''];
    if (PickedFile != null) {
      textImage2 = File(PickedFile.path);
      List<TextBlock> rectext = await recogniseText(textImage2);
      rectext.forEach((element) {
        searcher = searcher + element.text;
        doctorSearcher.add("${element.text}");
      });
      print(searcher);

      emit(PickImageSuccesState());
    } else {
      emit(PickImageErrorState());
    }
  }

  Future<String> getImageForSeacrhPatient() async {
    String search = '';
    XFile? PickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (PickedFile != null) {
      textImage2 = File(PickedFile.path);
      List<TextBlock> rectext = await recogniseText(textImage2);
      rectext.forEach((element) {
        search = search + element.text;
      });

      emit(PickImageSuccesState());
    } else {
      emit(PickImageErrorState());
    }
    return search;
  }

  static Future<List<TextBlock>> recogniseText(File? image) async {
    List<dynamic> s = [''];
    if (image == null) {
      return s[0];
    } else {
      try {
        final visionimage = await GoogleMlKit.vision
            .textRecognizer()
            .processImage(InputImage.fromFile(image));

        final text = visionimage.blocks;
        return text.isEmpty ? s[0] : text;
      } catch (error) {
        return s[0];
      }
    }
  }

  void addsearchpharmacymedicine(
      int medicineid, int pharmacyid, context, String search) {
    emit(ChangeMedicineSatteLoadingState());
    DioHelper.postData(url: postPharmacyMedicineEndPoint, data: {
      'medicineId': medicineid,
      'pharmacyId': pharmacyid,
      'price': 60,
      'quantity': 60,
      'productStatusId': 10,
    }).then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('تم تغيير حالة العلاج'),
          actions: [
            TextButton(
                onPressed: () {
                  getsearchmedicine(search);
                  Navigator.pop(context);
                },
                child: Text('تم'))
          ],
        ),
      );
      emit(ChangeMedicineSatteSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(ChangeMedicineSatteErrorState());
    });
  }

  void deletesearchpharmacymedicine(
      int medicineid, int pharmacyid, context, String search) {
    emit(ChangeMedicineSatteLoadingState());
    DioHelper.deletedata(
        url: 'PharmacyMedicine/$medicineid/$pharmacyid',
        data: {
          'medicineId': medicineid,
          'pharmacyId': pharmacyid,
          'price': 60,
          'quantity': 60,
          'productStatusId': 10,
        }).then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('تم تغيير حالة العلاج'),
          actions: [
            TextButton(
                onPressed: () {
                  getsearchmedicine(search);
                  Navigator.pop(context);
                },
                child: Text('تم'))
          ],
        ),
      );
      emit(ChangeMedicineSatteSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(ChangeMedicineSatteErrorState());
    });
  }

  bool isactive = false;
  void changeisactive() {
    isactive = !isactive;
    emit(ChangeMedicineSatteSuccesState());
  }

  void addpharmacymedicine(int medicineid, int pharmacyid, context, int id) {
    emit(ChangeMedicineSatteLoadingState());
    DioHelper.postData(url: postPharmacyMedicineEndPoint, data: {
      'medicineId': medicineid,
      'pharmacyId': pharmacyid,
      'price': 60,
      'quantity': 60,
      'productStatusId': 10,
    }).then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('تم تغيير حالة العلاج'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('تم'))
          ],
        ),
      );
      emit(ChangeMedicineSatteSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(ChangeMedicineSatteErrorState());
    });
  }

  void deletepharmacymedicine(int medicineid, int pharmacyid, context, int id) {
    emit(ChangeMedicineSatteLoadingState());
    DioHelper.deletedata(
        url: 'PharmacyMedicine/$medicineid/$pharmacyid',
        data: {
          'medicineId': medicineid,
          'pharmacyId': pharmacyid,
          'price': 60,
          'quantity': 60,
          'productStatusId': 10,
        }).then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('تم تغيير حالة العلاج'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('تم'))
          ],
        ),
      );
      emit(ChangeMedicineSatteSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(ChangeMedicineSatteErrorState());
    });
  }

  Future<Map<String, dynamic>> updatepharmacymedicinelist(
      List<String> pharmacymedicines, String type) async {
    Map<String, dynamic> data = {};
    var search = jsonEncode(pharmacymedicines);
    print(search);
    emit(UpdatePharmacyMedicineLoadingState());
    await DioHelper.updatedata(
            url: 'PharmacyMedicine/$type/${pharmamodel!.id}', data: search)
        .then((value) {
      data = value.data;
      emit(UpdatePharmacyMedicineSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdatePharmacyMedicineErrorState());
    });
    return data;
  }

  /* void changeproductstatus(
      int pharmacyid, int medicineid, int status, int id, context) {
    emit(ChangeMedicineSatteLoadingState());
    DioHelper.updatedata(
      url: 'PharmacyMedicine/36/34',
      data: {
        "medicineId": medicineid,
        "pharmacyId": pharmacyid,
        "price": 50,
        "quantity": 100,
        "productStatusId": status
      },
    ).then((value) {
      getdoctorpharmacy();

      print('success');
      emit(ChangeMedicineSatteSuccesState());
    }).then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('تم تغيير حالة العلاج'),
          actions: [
            TextButton(
                onPressed: () {
                  getmpharmacymedicinesbyid(id);
                  Navigator.pop(context);
                },
                child: Text('تم'))
          ],
        ),
      );
    }).catchError((error) {
      print(error.toString());
      emit(ChangeMedicineSatteErrorState());
    });
  }

  List<int> mediciensid = [];
  List<int> productstatusid = [];*/
  void getdoctorpharmacy(String licenceid, {String}) {
    emit(GetDoctorPharmacyLoadingState());
    DioHelper.getData(url: getPharmacyEndPoint).then((value) {
      value.data['data'].forEach((element) {
        if (element['licenceId'] == licenceid) {
          pharmamodel = PharmacyModel.fromJson(element);
          print(pharmamodel!.licenseId);
          print(pharmamodel!.address);
          print(pharmamodel!.areaId);
          print(pharmamodel!.id);
          print(pharmamodel!.localityId);
          print(pharmamodel!.location);
          print(pharmamodel!.phone);
        }
      });
      /*pharmamodel!.medicines!.forEach((element) {
        productstatusid.add(element['productStatusId']);
        mediciensid.add(element['medicineId']);
      });*/
      emit(GetDoctorPharmacySuccesState());
    }).catchError((error) {
      print(error);
      emit(GetDoctorPharmacyErrorState());
    });
  }
/*
  List<MedicineModel> pharmacymedicines = [];
  Future<List<MedicineModel>> getmpharmacymedicinesbyid(int genericId) async {
    pharmacymedicines = [];
    emit(GetDoctorPharmacyMedicineLoadingState());
    await DioHelper.getData(url: getMedicineEndPoint).then((value) {
      value.data['data'].forEach((element) {
        if (element['genericId'] == genericId) {
          for (int i = 0; i < mediciensid.length; i++) {
            if (mediciensid[i] == element['id']) {
              pharmacymedicines.add(MedicineModel(
                  id: element['id'].toString(),
                  image: element['image'],
                  name: element['name'],
                  status: productstatusid[i].toString()));
            }
          }
        }
      });
      print(pharmacymedicines[0].status.toString());
      emit(GetDoctorPharmacyMedicineSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDoctorPharmacyMedicineErrorState());
    });
    return pharmacymedicines;
  }*/

  void updatepharmacy(int pharmacyId, String newlocation, String newaddress,
      String phone, String licenceId, context) {
    emit(UpdatePharmacyLoadingState());
    if (licenceId == pharmamodel!.licenseId) {
      DioHelper.updatedata(url: 'Pharmacy/$pharmacyId', data: {
        "id": int.parse(pharmamodel!.id.toString()),
        "licenceId": licenceId,
        "email": "ostaz@gmai.com",
        "mobile": "01111111123",
        "phone": phone,
        "street": pharmamodel!.street,
        "name": pharmamodel!.name,
        "image": "ممممممممممممم",
        "description": "SDSADSAD",
        "originCountryName": "SADSAD",
        "productStatus": true,
        "address": newaddress,
        "location": newlocation,
        "longitude": pharmamodel!.long.toString(),
        "latitude": pharmamodel!.lat.toString(),
        "workTime": "2023-05-24T21:26:21.808Z",
        "block": pharmamodel!.block,
        "areaId": pharmamodel!.areaId,
        "localityId": pharmamodel!.localityId
      }).then((value) {
        showmydialog(context, 'تم تغيير بيانات الصيجلية', Icons.verified);
        emit(UpdatePharmacySuccesState());
      }).catchError((error) {
        showmydialog(context, 'حدث خطأ في تحديث البيانات', Icons.warning);
        print(error);
        emit(UpdatePharmacyErrorState());
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('رقم الرخضة غير صحيح'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('تم'))
          ],
        ),
      );
    }
  }

  void changeBottomNAv(int index, PageController? _pageController) {
    currentIndex = index;
    _pageController!.animateToPage(currentIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    emit(changeBottomNAvState());
  }

  bool? ExpanasionTouche;
  void changeExpanasionTouche(
    bool value,
  ) {
    value != ExpanasionTouche;
    emit(changeExpanasionToucheState());
  }

  String? result;
  void changeBarCodeResult(String ScanMethodResult) {
    this.result = ScanMethodResult;
    emit(changeBarCodeResultState());
  }
}
