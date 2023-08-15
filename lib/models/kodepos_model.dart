class KodePosModel {
  String province, city, subdistrict, urban, postalCode;
  KodePosModel(
      {required this.province,
      required this.city,
      required this.urban,
      required this.postalCode,
      required this.subdistrict});
  factory KodePosModel.fromJson(dynamic json) {
    return KodePosModel(
        province: json['province'],
        city: json['city'],
        urban: json['urban'],
        postalCode: json['postalcode'],
        subdistrict: json['subdistrict']);
  }
}
