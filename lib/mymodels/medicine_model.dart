class MedicineModel {
  String? id;
  String? name;
  String? desc;
  String? categoryId;
  String? manufacturerName;
  String? originCountryName;
  String? image;
  String? status;
  double? price;
  int? quantity;
  List? pharmacyMedicines;

  MedicineModel(
      {this.id,
      this.name,
      this.desc,
      this.manufacturerName,
      this.categoryId,
      this.image,
      this.price,
      this.originCountryName,
      this.quantity,
      this.status,
      this.pharmacyMedicines});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    desc = json['description'];
    manufacturerName = json['manufacturer']['name'];
    image = json['image'];
    categoryId = json['genericId'].toString();
    status = json['productStatusId'].toString();
    originCountryName = json['originCountryName'];
    pharmacyMedicines = json['pharmacyMedicines'];
  }
}
