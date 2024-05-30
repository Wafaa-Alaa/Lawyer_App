class UserModel {
  final String fullName;
  final String email;
  final String phone;
  final String location;
  final String specialization;
  final String workE;
  final String image;
  final int rateing;
  String? uid;
  String? id;
  UserModel({
    this.uid,
    this.id,
    required this.rateing,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.location,
    required this.specialization,
    required this.workE,
    required this.image,
  });
  factory UserModel.fromJson(jsonData) {
    return UserModel(
      fullName: jsonData['fullName'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      location: jsonData['location'],
      specialization: jsonData['specialization'],
      workE: jsonData['workE'],
      uid: jsonData['uid'],
      id: jsonData['id'],
      image:jsonData['image'],
      rateing:jsonData['rateing'],
    );
  }
}
