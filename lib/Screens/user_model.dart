class UserModel {
  String? fullName;
  String?  gender;
  int? mobilePhone;
  String? dob;
  String? maritalStatus;
  int? height;
  int? weight;
  String? nationality;
  String? country;
  String? city;
  String? state;
  String? address1;
  String? address2;
  int? zip;
  int? age;
  String? email;

  UserModel(
      {this.fullName,
    this.gender,
      this.mobilePhone,
      this.dob,
      this.maritalStatus,
      this.height,
      this.weight,
      this.nationality,
      this.country,
      this.city,
      this.state,
      this.address1,
      this.address2,
      this.zip,
      this.email,
      this.age});

  UserModel.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        
        mobilePhone = json['mobilePhone'] as int?,
        dob = json['dob'],
        maritalStatus = json['maritalStatus'],
        height = json['height'] as int?,
        weight = json['weight'] as int?,
        nationality = json['nationality'],
        country = json['country'],
        city = json['city'],
        state = json['state'],
        address1 = json['address1'],
        address2 = json['address2'],
        zip = json['zip'] as int?,
        email = json['email'],
          gender = json['gender'],
        age = json['age'] as int?;

  UserModel copyWith(
      {String? fullName,
      String?gender,
      String? yourRelationToThePerson,
      int? mobilePhone,
      String? dob,
      String? maritalStatus,
      int? height,
      int? weight,
      String? nationality,
      String? country,
      String? city,
      String? state,
      String? address1,
      String? address2,
      int? zip,
      String? email,
      int? age}) {
    return UserModel(
      fullName: fullName ?? this.fullName,
     
        gender: gender ?? this.gender,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      dob: dob ?? this.dob,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      nationality: nationality ?? this.nationality,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      zip: zip ?? this.zip,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'gender' : gender,
      'mobilePhone': mobilePhone,
      'dob': dob,
      'maritalStatus': maritalStatus,
      'height': height,
      'weight': weight,
      'nationality': nationality,
      'country': country,
      'city': city,
      'state': state,
      'address1': address1,
      'address2': address2,
      'zip': zip,
      'email': email,
      'age': age
    };
  }
}
