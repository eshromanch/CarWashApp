class SignUpBody {
  String? phone;
  String? password;

  SignUpBody({this.phone,required this.password});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
}
