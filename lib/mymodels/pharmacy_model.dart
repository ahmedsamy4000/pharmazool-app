import 'package:pharmazool/mymodels/medicine_model.dart';

class PharmacyModel {
  String? id;
  String? name;
  String? licenseId;
  String? street;
  String? block;
  String? area;
  String? address;
  String? locality;
  String? location;
  String? phone;
  String? long;
  String? lat;
  String? worktime;
  bool? productstatues;
  int? areaId;
  int? localityId;
  List? medicines;
  int? distance;

  PharmacyModel(
      {this.id,
      this.name,
      this.area,
      this.block,
      this.address,
      this.worktime,
      this.licenseId,
      this.locality,
      this.long,
      this.productstatues,
      this.lat,
      this.localityId,
      this.areaId,
      this.location,
      this.phone,
      this.street,
      this.medicines,
      this.distance});

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    area = json['area']['name'].toString();
    address = json['address'].toString();
    street = json['street'].toString();
    licenseId = json['licenceId'];
    locality = json['locality']['name'].toString();
    phone = json['phone'].toString();
    block = json['block'].toString();
    long = json['longitude'].toString();
    lat = json['latitude'].toString();
    areaId = json['areaId'];
    localityId = json['localityId'];
    worktime = json['workTime'];
    location = json['location'];
    medicines = json['pharmacyMedicines'];
  }
}
