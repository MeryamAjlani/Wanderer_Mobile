class ProfileModel {
  String id;
  String email;
  String name;
  String gender;
  String city;
  String dob;
  String img;

  ProfileModel(
      {String id,
      String email,
      String name,
      String gender,
      String city,
      String dob,
      String img})
      : this.id = id,
        this.email = email,
        this.name = name,
        this.gender = gender,
        this.city = city,
        this.dob = dob,
        this.img = img;

  factory ProfileModel.fromJson(dynamic json) {
    ProfileModel user = ProfileModel(
      id: json['_id'],
      email: json['email'],
      name: json['fullname'],
      gender: (json['profile'][0]['gender'] != null)
          ? json['profile'][0]['gender']
          : 'Male',
      city: (json['profile'][0]['city'] != null)
          ? json['profile'][0]['city']
          : 'Ariana',
      dob: (json['profile'][0]['dateOfBirth'] != null)
          ? json['profile'][0]['dateOfBirth']
          : '2001-01-01',
      img: (json['profile'][0]['img'] != null)
          ? json['profile'][0]['img']
          : 'profileImagePlaceholder',
    );
    return user;
  }
}
