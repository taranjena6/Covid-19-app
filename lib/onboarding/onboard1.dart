import 'package:covid_19/onboarding/onboard2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    child: Lottie.asset("assets/17902-covid19.json"))),
            SizedBox(height: 30.0),
            Expanded(
                child: Container(
              child: Text(
                "Covid-19",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 15.0),
              child: Container(
                child: Text(
                  "Coronaviruses are a group of related RNA viruses that cause diseases in mammals and birds.",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Container(
                child: FloatingActionButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OnBoard2();
                    }));
                  },
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
