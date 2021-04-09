import 'network.dart';

class NetWorkModel {
  var mydata;
  Future<dynamic> getCountryData() async {
    var url = "https://api.covidindiatracker.com/total.json";
    NetworkHelper networkHelper = NetworkHelper(url);
    mydata = await networkHelper.getData();
    return mydata;
  }

  Future<dynamic> getStateData() async {
    var url = "https://api.covidindiatracker.com/state_data.json";
    NetworkHelper networkHelper = NetworkHelper(url);
    mydata = await networkHelper.getData();
    return mydata;
  }
}
