import 'dart:convert';

import 'package:beconsent_sdk/model/Consent.dart';
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/globals.dart' as global;

cancelConsent(Consent _c) async {
  final url = Uri.parse(
      "http://dev.beconsent.tech/api/v1/03a29a62-eb39-4d7b-895c-7e900d893e37/user-consents");
  List<int> purpose = [];
  for (var i in global.record) {
    if (i.primary == true) {
      global.Action = "PARTIAL";
      purpose.add(i.id);
    }
  }
  Map<String, dynamic> args = {
    "consentId": _c.consentId.toString(),
    "uid": global.uid,
    "name": global.Name,
    "consentVersion": _c.version,
    "purposes": purpose,
    "action": global.Action,
    "language": "th",
    "collectionChannel": "Mobile App"
  };
  var body = json.encode(args);
  var response = await http
      .post(url, body: body, headers: {'Content-type': 'application/json'});
  print(response.statusCode);
  print(response.body);
}

saveConsent(Consent _c) async {
  final url = Uri.parse(
      "http://dev.beconsent.tech/api/v1/03a29a62-eb39-4d7b-895c-7e900d893e37/user-consents");
  final user_check = Uri.parse(
      "http://dev.beconsent.tech/api/v1/${_c.workspaceUUID}/user-consents/consent/${_c.consentUUID}/version/${_c.version}/get-user-consent");
  var res = await http.post(user_check, body: {"uid": global.uid});
  print(res.statusCode);

  if (res.statusCode == 404) {
    List<int> purpose = [];
    for (var i in global.record) {
      if (i.val == true) {
        global.Action = "PARTIAL";
        purpose.add(i.id);
      }
    }
    Map<String, dynamic> args = {
      "consentId": _c.consentId.toString(),
      "uid": global.uid,
      "name": global.Name,
      "consentVersion": _c.version,
      "purposes": purpose,
      "action": global.Action,
      "language": "th",
      "collectionChannel": "Mobile App"
    };
    var body = json.encode(args);
    var response = await http
        .post(url, body: body, headers: {'Content-type': 'application/json'});
    print(response.statusCode);
    print(response.body);
  }
  if (res.statusCode == 201) {
    List<int> purpose = [];
    for (var i in global.record) {
      if (i.val == true) {
        global.Action = "CHANGE_TO_PARTIAL";
        purpose.add(i.id);
      }
      if(global.accept_all = true){
        global.Action = "CHANGE_TO_ALL";
        purpose.add(i.id);
      }
    }
    Map<String, dynamic> args = {
      "consentId": _c.consentId.toString(),
      "uid": global.uid,
      "name": global.Name,
      "consentVersion": _c.version,
      "purposes": purpose,
      "action": global.Action,
      "language": "th",
      "collectionChannel": "Mobile App"
    };
    var body = json.encode(args);
    var response = await http
        .post(url, body: body, headers: {'Content-type': 'application/json'});
    print(response.statusCode);
    print(response.body);
  }
}

AcceptAllConsent(Consent _c) async {
  final url = Uri.parse(
      "http://dev.beconsent.tech/api/v1/03a29a62-eb39-4d7b-895c-7e900d893e37/user-consents");
  List<int> purpose = [];
  for (var i in global.record) {
    purpose.add(i.id);
  }
  Map<String, dynamic> args = {
    "consentId": _c.consentId.toString(),
    "uid": global.uid,
    "name": global.Name,
    "consentVersion": _c.version,
    "purposes": purpose,
    "action": "ALL",
    "language": "th",
    "collectionChannel": "Mobile App"
  };

  var body = json.encode(args);

  var response = await http
      .post(url, body: body, headers: {'Content-type': 'application/json'});
  print(response.statusCode);
  print(response.body);
}

// Future getData() async{
//     final url = Uri.parse("http://dev.beconsent.tech/api/v1/");

//     final user = Uri.parse()
//     _bc = consentFromJson(response[0].body);
//   }

//   String user_url = "http://dev.beconsent.tech/api/v1/03a29a62-eb39-4d7b-895c-7e900d893e37/user-consents/consent/ffe24470-ee39-4f9e-b87e-c56a99ef735f/version/2/get-user-consent";
//   final user = Uri.parse()