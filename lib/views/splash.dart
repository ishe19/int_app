import 'package:flutter/material.dart';
import 'package:int_app/views/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => const LoginPage()));
    });
    return SafeArea(
        child: Scaffold(
            body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 55, vertical: 100),
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: const Image(
                                image: AssetImage("assets/img/index.jpg"),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Interview App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      Expanded(
                          child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Loading...")
                          ],
                        ),
                      ))
                    ],
                  ),
                ))));
  }
}
