import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
         this.firstName,
         this.lastName,
         this.dob,
         this.phoneNumber,
         this.nationality,
         this.email,
         this.password,
    });

    String? firstName;
    String? lastName;
    DateTime? dob;
    String? phoneNumber;
    String? nationality;
    String? email;
    String? password;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: DateTime.parse(json["dob"]),
        phoneNumber: json["phoneNumber"],
        nationality: json["nationality"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "phoneNumber": phoneNumber,
        "nationality": nationality,
        "email": email,
        "password": password,
    };
}
