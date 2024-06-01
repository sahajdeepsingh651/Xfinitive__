class Todo2 {
  String? fullName;
  String? hospitalname;
  int? doctormobilenumber;
  String? doctortype;

  String? country;
  String? city;
  String? state;
  String? address;
  int? zip;

  Todo2({
    this.fullName,
    this.doctormobilenumber,
    this.country,
    this.city,
    this.state,
    this.address,
    this.zip,
    this.hospitalname,
    this.doctortype,
  });

  Todo2.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        hospitalname = json['hospitalname'],
        doctormobilenumber = json['doctormobilenumber'] as int?,
        doctortype = json['doctortype'],
        country = json['country'],
        city = json['city'],
        state = json['state'],
        address = json['address'],
        zip = json['zip'] as int? ;

  Todo2 copyWith({
    String? fullName,
    String? hospitalname,
    int? doctormobilenumber,
    String? doctortype,
    String? country,
    String? city,
    String? state,
    String? address,
    int? zip,
  }) {
    return Todo2(
      fullName: fullName ?? this.fullName,
      hospitalname: hospitalname ?? this.hospitalname,
      doctormobilenumber: doctormobilenumber ?? this.doctormobilenumber,
      doctortype: doctortype ?? this.doctortype,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      address: address ?? this.address,
      zip: zip ?? this.zip,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'hospitalname': hospitalname,
      'doctormobilenumber': doctormobilenumber,
      'doctortype': doctortype,
      'country': country,
      'city': city,
      'state': state,
      'address': address,
      'zip': zip,
    };
  }
}
