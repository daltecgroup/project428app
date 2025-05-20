class OutletListItem {
  final String name;
  final String code;
  final bool isActive;
  final String imgUrl;
  final String street;
  final String village;
  final String district;
  final String regency;

  OutletListItem(
    this.name,
    this.code,
    this.isActive,
    this.imgUrl,
    this.street,
    this.village,
    this.district,
    this.regency,
  );

  OutletListItem.fromJson(Map<String, dynamic> json)
    : code = json['code'] as String,
      name = json['name'] as String,
      isActive = json['isActive'] as bool,
      imgUrl = json['imgUrl'] as String,
      street = json['address']['street'] as String,
      village = json['address']['village'] as String,
      district = json['address']['district'] as String,
      regency = json['address']['regency'] as String;
}
