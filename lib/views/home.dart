import 'package:flutter/material.dart';
import 'package:int_app/models/user_model.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  const HomePage(this.userModel, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime a = DateTime.now();
    DateTime b = widget.userModel.dob!;
    int totalDays1 = a.difference(b).inDays;
    int years = totalDays1 ~/ 365;
    int months = (totalDays1 - years * 365) ~/ 30;
    int days = totalDays1 - years * 365 - months * 30;
    debugPrint("$years $months $days $totalDays1");

    final firstDate = DateTime.now();
    final secondDate = widget.userModel.dob;

    final yearsDifference = firstDate.year - secondDate!.year;
    final monthsDifference = (firstDate.year - secondDate.year) * 12 +
        firstDate.month -
        secondDate.month;
    final totalDays = firstDate.difference(secondDate).inDays;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Interview App Home"),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Hero(
                tag: "avatar",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage("assets/img/index.jpg"),
                  ),
                ),
              ),
            ),
            Text(
              "Hi There " +
                  widget.userModel.firstName! +
                  " " +
                  widget.userModel.lastName!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "You are this old:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$yearsDifference in years",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$monthsDifference in months",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$totalDays in days",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Overall you are:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$years years, $months month(s) and $days day(s) old",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    child: const Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.red.shade900,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const LoginPage()));
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
