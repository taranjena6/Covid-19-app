import 'package:covid_19/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                    child: Lottie.asset("assets/27441-bar-graph.json"))),
            SizedBox(height: 10.0),
            Expanded(
                child: Container(
              child: Text(
                "Track Covid Data",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 15.0, right: 10.0),
              child: Container(
                child: Text(
                  "We provide most recent data of covid-19 of your country.You can track covid data of your country's state.",
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
                  child: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
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
