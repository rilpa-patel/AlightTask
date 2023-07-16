import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:milkcollection/models/login.dart';

class Login {
  Future<Login_modle> getLoginData() async {
    var headers = {
      'Authorization': 'Basic SFBNSUxLRkVEOkhQTUlMS0ZFRA=='
    };

    final response = await http.get(
        Uri.parse('http://milkfed.demoalight.com/api/FarmerAPI/GetValidateUser?FarmerCode=F01&MobileNo=7490000624'), headers: headers);

    if (response.statusCode != 200) {
      print(response.reasonPhrase);
    }
    var temp = json.decode(response.body);
    return Login_modle(
      temp[0]['Farmer_Code'],
      temp[0]['FarmerName'],
      temp[0]['Message']
    );
  }
   
}
