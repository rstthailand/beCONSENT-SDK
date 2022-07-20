import 'dart:convert';

import 'package:beconsent_sdk/model/Consent.dart';
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/globals.dart' as global;


cancelConsent(Consent id) async{
    final url = Uri.parse("http://dev.beconsent.tech/api/v1/03a29a62-eb39-4d7b-895c-7e900d893e37/user-consents");
    for (var i in global.record){
      if(i.val == true){
        global.Action = "PARTIAL";
      }
    }
    var response = await http.post(url, body: {
      "consentId": id.consentId.toString(),
      "uid": "real_test",
      "name":"Test customAPI",
      "consentVersion": id.version,
      "action": global.Action,
      "language": "th",
      "collectionChannel": "Mobile App"
    });
    print(response.statusCode);
    print(response.body);
  }

  AcceptAllConsent(Consent _c) async{
    final url = Uri.parse("http://dev.beconsent.tech/api/v1/03a29a62-eb39-4d7b-895c-7e900d893e37/user-consents");
    List<int> purpose = [];
    for(var i in global.record){
        purpose.add(i.id);
    }
    Map<String, dynamic> args = {
      "consentId": _c.consentId.toString(),
      "uid": "real_test",
      "name":"Test customAPI",
      "consentVersion": _c.version,
      "purposes": purpose,
      "action": "ALL",
      "language": "th",
      "collectionChannel": "Mobile App"};

    var body = json.encode(args);

    var response = await http.post(url, body: body, headers: {'Content-type': 'application/json'}
    );
    print(response.statusCode);
    print(response.body);
  }