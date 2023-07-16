import 'dart:convert';
import 'package:milkcollection/models/destboard.dart';
import 'package:http/http.dart' as http;

class Deshboard_helper {
  Future<Deshboard_model> getDestbordData() async {
    var headers = {
      'Authorization': 'Basic SFBNSUxLRkVEOkhQTUlMS0ZFRA=='
    };

    final response = await http.get(
        Uri.parse('http://milkfed.demoalight.com/api/FarmerAPI/GetFarmerDashBoardDetails?FarmerCode=F01'), headers: headers);

    if (response.statusCode != 200) {
      print(response.reasonPhrase);
    }
    var temp = json.decode(response.body);
    return Deshboard_model(
      temp['dashBoard']['SubmittedMilk'],
      temp['dashBoard']['TotalPayment'],
      temp['dashBoard']['ReceivedPayment'],
      temp['dashBoard']['RemainingPayment'],
    );
  }
   
}
