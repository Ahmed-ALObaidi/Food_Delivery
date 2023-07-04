class SignUpBodyModel{
  String name;
  String email;
  String password;
  String phone;
  SignUpBodyModel({required this.password,required this.email,required this.phone,required this.name});

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = Map<String,dynamic>();
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}