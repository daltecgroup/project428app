class Address {
  final String province, regency, district, village, street;

  Address({
    required this.province,
    required this.regency,
    required this.district,
    required this.village,
    required this.street,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      province: json['province'],
      regency: json['regency'],
      district: json['district'],
      village: json['village'],
      street: json['street'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'province': province,
      'regency': regency,
      'district': district,
      'village': village,
      'street': street,
    };
  }
}
