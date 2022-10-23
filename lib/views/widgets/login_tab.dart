import 'package:flutter/material.dart';
import 'package:int_app/api/api_service.dart';
import 'package:int_app/models/login_model.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../home.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({Key? key}) : super(key: key);

  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  late TextEditingController usernameController;
  TextEditingController passwordController = TextEditingController();
  String username = '';
  String password = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController();

    usernameController.addListener(() {
      username = usernameController.text;
    });
    passwordController.addListener(() {
      password = passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: LoadingOverlay(
          isLoading: isLoading,
          child: Form(
            child: Column(children: [
              _loginField(
                  controller: usernameController,
                  title: "E-mail",
                  label: "E-mail",
                  icon: Icon(Icons.person)),
              _loginField(
                  controller: passwordController,
                  title: "Username",
                  label: "Password",
                  icon: Icon(Icons.lock),
                  isObsecured: true),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          ApiService apiService = ApiService();
                          LoginRequestModel loginRequestModel =
                              LoginRequestModel();
                          loginRequestModel.email = usernameController.text;
                          loginRequestModel.password = passwordController.text;
                          apiService.login(loginRequestModel).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => HomePage(value)));
                          }).catchError((e) {
                            debugPrint(e.toString());
                          });
                          //
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text("Log in")),
                  )),
                  // Expanded(child: MaterialButton(onPressed: (){},
                  // color: Colors.green,
                  // child: Text(""),))
                ],
              )
            ]),
          ),
        ));
  }
}

_loginField({
  required TextEditingController controller,
  required String title,
  required String label,
  required Icon icon,
  bool isObsecured = false,
}) {
  return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return "Required";
            }
          },
          obscureText: isObsecured,
          decoration: InputDecoration(
              prefixIcon: icon,
              fillColor: Colors.white.withOpacity(.7),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(width: 5, color: Colors.blue)),
              label: Text(
                label,
              )),
          controller: controller));
}
