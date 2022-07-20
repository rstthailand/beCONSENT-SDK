import 'package:http/http.dart' as http;


cancelConsent(String uuid) async{
  String workspace = uuid;
    final url = Uri.parse("http://dev.beconsent.tech/api/v1/$workspace/user-consents");
    var response = await http.post(url, body: {
      "consentId": 3.toString(),
      "uid": "real_test",
      "name":"Test customAPI",
      "consentVersion": "2",
      "action": "NONE",
      "language": "th",
      "collectionChannel": "Mobile App"
    });
    print(response.statusCode);
    print(response.body);
  }