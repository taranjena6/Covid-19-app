import 'package:covid_19/constant.dart';
import 'package:covid_19/info_screen.dart';
import 'package:covid_19/networkModel.dart';
import 'package:covid_19/onboarding/onboard1.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'stateModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen $initScreen');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid 19',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: "Poppins",
            textTheme: TextTheme(
              bodyText1: TextStyle(color: kBodyTextColor),
            )),
        initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",
        routes: {
          '/': (context) => HomeScreen(),
          "first": (context) => OnBoard1(),
        });
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var mydata;
  int index = 5;
  int active = 0;
  int deaths = 0;
  int recovered = 0;
  String stateName = "Delhi";
  int activeCases = 0;
  int recoveredCases = 0;
  int deathCases = 0;
  String number = "108";
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    countrydataCaller();
    statedataCaller(index);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  void countrydataCaller() async {
    NetWorkModel netWorkModel = NetWorkModel();
    mydata = await netWorkModel.getCountryData();

    setState(() {
      active = mydata['active'];
      deaths = mydata['deaths'];
      recovered = mydata['recovered'];
    });
  }

  Future<void> makingPhoneCall() async {
    const url = 'tel:108';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  statedataCaller(int index) async {
    NetWorkModel netWorkModel = NetWorkModel();
    mydata = await netWorkModel.getStateData();
    StateModel stateModel = StateModel();
    index = stateModel.getIndex(stateName);
    setState(() {
      stateName = mydata[index]['state'];
      activeCases = mydata[index]['active'];
      recoveredCases = mydata[index]['recovered'];
      deathCases = mydata[index]['deaths'];
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var time = DateFormat.yMMMMd('en_US').format(now);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader(
                image: "assets/icons/Drcorona.svg",
                textTop: "All you need",
                textBottom: "is stay at home.",
                offset: offset,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                    SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                        value: stateName,
                        items: [
                          "Andhra Pradesh",
                          "Arunachal Pradesh",
                          "Assam",
                          "Bihar",
                          "Chhattisgarh",
                          "Goa",
                          "Gujarat",
                          "Haryana",
                          "Himachal Pradesh",
                          "Jammu and Kashmir",
                          "Jharkhand",
                          "Karnataka",
                          "Kerala",
                          "Madhya Pradesh",
                          "Maharashtra",
                          "Manipur",
                          "Meghalaya",
                          "Mizoram",
                          "Nagaland",
                          "Odisha",
                          "Punjab",
                          "Rajasthan",
                          "Sikkim",
                          "Tamil Nadu",
                          "Telangana",
                          "Tripura",
                          "Uttarakhand",
                          "Uttar Pradesh",
                          "West Bengal",
                          "Andaman and Nicobar Islands",
                          "Chandigarh",
                          "Dadra and Nagar Haveli",
                          "Daman and Diu",
                          "Delhi",
                          "Lakshadweep",
                          "Puducherry"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            stateName = value;

                            statedataCaller(index);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "India\n",
                                style: kTitleTextstyle,
                              ),
                              TextSpan(
                                text: "Cases Update $time",
                                style: TextStyle(
                                  color: kTextLightColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Counter(
                              color: kInfectedColor,
                              number: active,
                              title: "Infected",
                            ),
                          ),
                          Expanded(
                            child: Counter(
                              color: kDeathColor,
                              number: deaths,
                              title: "Deaths",
                            ),
                          ),
                          Expanded(
                            child: Counter(
                              color: kRecovercolor,
                              number: recovered,
                              title: "Recovered",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "State: $stateName",
                            style: kTitleTextstyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: kInfectedColor,
                            number: activeCases,
                            title: "Infected",
                          ),
                          Counter(
                            color: kDeathColor,
                            number: deathCases,
                            title: "Deaths",
                          ),
                          Counter(
                            color: kRecovercolor,
                            number: recoveredCases,
                            title: "Recovered",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Prevention", style: kTitleTextstyle),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoScreen(),
                          ),
                        );
                      },
                      child: PreventCard(
                        text:
                            "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                        image: "assets/18795-coronavirus.json",
                        title: "Wear face mask",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: makingPhoneCall,
        child: Icon(Icons.call),
      ),
    );
  }
}
