import 'package:flutter/material.dart';

class LoginSignUpCard extends StatefulWidget {
  const LoginSignUpCard({Key? key}) : super(key: key);

  @override
  _LoginSignUpCardState createState() => _LoginSignUpCardState();
}

class _LoginSignUpCardState extends State<LoginSignUpCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Center(
        child: Card(
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
