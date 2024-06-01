
class Todo {
  String? fullName;
  String? yourRelationToThePerson;
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

  Todo({
    this.fullName,
    this.yourRelationToThePerson,
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
    this.age
    
  });

  Todo.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        yourRelationToThePerson = json['yourRelationToThePerson'],
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
        age = json['age'] as int?;
        

  Todo copyWith({
    String? fullName,
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
    int? age
  }) {
    return Todo(
      fullName: fullName ?? this.fullName,
      yourRelationToThePerson:
          yourRelationToThePerson ?? this.yourRelationToThePerson,
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
      'yourRelationToThePerson': yourRelationToThePerson,
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
      'age':age
    };
  }
}
