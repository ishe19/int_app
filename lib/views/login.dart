import 'package:flutter/material.dart';
import 'package:int_app/views/widgets/login_signup.dart';
import 'package:int_app/views/widgets/login_tab.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'widgets/signup_tab.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _isSelected = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: const Hero(
                        tag: "avatar",
                        child: Image(
                          image: AssetImage("assets/img/index.jpg"),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Interview App",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                // height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.blueAccent,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isSelected = 0;
                              });
                            },
                            child: Container(
                              height: 40,
                              color: _isSelected == 0
                                  ? Colors.greenAccent.withOpacity(0.5)
                                  : Colors.transparent,
                              child: Column(
                                children: [
                                  Text("Login",
                                      style: _isSelected == 0
                                          ? TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)
                                          : TextStyle(
                                              color: Colors.black,
                                            )),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: _isSelected == 0
                                            ? Colors.amber
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)),
                                    height: 2,
                                    width: 100,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isSelected = 1;
                              });
                            },
                            child: Container(
                              height: 40,
                              color: _isSelected == 1
                                  ? Colors.greenAccent.withOpacity(0.5)
                                  : Colors.transparent,
                              child: Column(
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: _isSelected == 1
                                        ? TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: Colors.black,
                                          ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: _isSelected == 1
                                            ? Colors.amber
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)),
                                    height: 2,
                                    width: 100,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: _isSelected == 0 ? LoginTab() : SignUpTab(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
