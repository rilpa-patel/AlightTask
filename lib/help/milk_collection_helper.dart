import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:milkcollection/models/milk_collection.dart';

class MilkCollection_helper {
  List<Milk_Collection_model> milkData = [];
  Future<void> getMilkData() async {
    var headers = {'Authorization': 'Basic SFBNSUxLRkVEOkhQTUlMS0ZFRA=='};

    final response = await http.get(
        Uri.parse(
            'http://milkfed.demoalight.com/api/FarmerAPI/GetFarmerMilkCollectionDetails?FarmerCode=F01&Password=7490000624'),
        headers: headers);

    if (response.statusCode != 200) {
      print(response.reasonPhrase);
    }
    var temp = json.decode(response.body);
log(temp['farmerMilk'][0]['Collection_Date']);
    temp['farmerMilk'].forEach((element) {
      milkData.add(Milk_Collection_model(
        element['Collection_Date'],
        element['Qty'],
        element['Fat'],
        element['Per_ltr_Rate'],
        element['Net_Payble']
      ));
    });
  }
}
