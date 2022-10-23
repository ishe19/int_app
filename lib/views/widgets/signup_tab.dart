import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:int_app/api/api_service.dart';
import 'package:int_app/models/user_model.dart';
import 'package:int_app/views/home.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:cool_datepicker/cool_datepicker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpTab extends StatefulWidget {
  const SignUpTab({Key? key}) : super(key: key);

  @override
  _SignUpTabState createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController passwordController1;
  String username = '';
  String password = '';
  String password1 = '';
  String nationality = "Pick Nationality";
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String dob = 'D.O.B';
  DateTime? dob2;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    passwordController1 = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();

    firstNameController.addListener(() {
      username = firstNameController.text;
    });

    passwordController.addListener(() {
      password = passwordController.text;
    });

    passwordController1.addListener(() {
      password1 = passwordController1.text;
    });

    // phoneNumberController.addListener(() { })
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          // color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: LoadingOverlay(
            isLoading: isLoading,
            child: Form(
              child: Column(
                children: [
                  // LoginField(usernameController, "Username"),
                  // LoginField(passwordController, "Password"),
                  _signupField(
                      controller: firstNameController,
                      title: "Username",
                      label: "First Name",
                      icon: Icon(Icons.person)),
                  _signupField(
                      controller: lastNameController,
                      title: "Username",
                      label: "Last Name",
                      icon: Icon(Icons.person)),
                  _signupField(
                      controller: emailController,
                      title: "E-mail",
                      label: "E-mail address",
                      icon: Icon(Icons.mail)),
                  _signupField(
                      controller: passwordController,
                      title: "PassWord",
                      label: "Password",
                      icon: Icon(Icons.lock),
                      isObsecured: true),
                  _signupField(
                      controller: passwordController1,
                      title: "PassWord",
                      label: "Confirm Password",
                      icon: Icon(Icons.lock),
                      isObsecured: true),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      child: IntlPhoneField(
                        controller: phoneNumberController,
                        textInputAction: TextInputAction.done,
                        countryCodeTextColor: Colors.black,
                        dropdownDecoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(20)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(.7),
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        initialCountryCode: 'ZW',
                        // onChanged: (phone) {
                        //   debugPrint(phone.completeNumber);
                        // },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Date of Birth",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      CoolDatepicker(
                          placeholder: dob,
                          placeholderTS: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          // format: "dd-mm-yyyy",
                          headerColor: Colors.blueAccent,
                          onSelected: (dateOfBirth) {
                            setState(() {
                              dob = dateOfBirth[0].toString().substring(0, 10);
                              dob2 = dateOfBirth[0];
                              debugPrint(dob);
                            });
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                debugPrint(
                                    'Select country: ${country.displayName}');
                                setState(() {
                                  nationality =
                                      country.displayNameNoCountryCode;
                                });
                              },
                            );
                          },
                          color: Colors.blue,
                          child: Text(nationality),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                ApiService apiService = ApiService();
                                UserModel userModel = UserModel();
                                userModel.firstName = firstNameController.text;
                                userModel.lastName = lastNameController.text;
                                userModel.dob = dob2;
                                userModel.nationality = nationality;
                                userModel.password = passwordController.text;
                                userModel.phoneNumber =
                                    phoneNumberController.text;
                                userModel.email = emailController.text;
                                apiService.register(userModel).then((value) {
                                  Future.delayed(const Duration(seconds: 3));
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              HomePage(userModel)));
                                }).catchError((e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  debugPrint(e.toString());
                                });
                              },
                              color: Colors.green,
                              child: Text("Sign Up")),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

_signupField({
  required TextEditingController controller,
  required String title,
  required String label,
  required Icon icon,
  bool isObsecured = false,
}) {
  return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          // obscureText: isObsecured,
          // keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          obscureText: isObsecured,
          decoration: InputDecoration(
              prefixIcon: icon,
              fillColor: Colors.white.withOpacity(.7),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 5, color: Colors.blue)),
              label: Text(
                label,
                // style: GoogleFonts.raleway(
                //     letterSpacing: 1,
                //     fontWeight: FontWeight.w600,
                //     color: Colors.amber),
              )),
          controller: controller));
}
