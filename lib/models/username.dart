class MyUser {
  int id;
  String? name;
  String? image;
  String? email;
  String? token;
  String? department;

  MyUser({
    required this.id,
    this.name,
    this.image,
    this.email,
    this.department,
    this.token,
  });
  factory MyUser.fromJson(Map<String, dynamic> json){
    return MyUser(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      department: json['user']['department'],
      token: json['token']
    );
  }

  // Rest of the code...
}
