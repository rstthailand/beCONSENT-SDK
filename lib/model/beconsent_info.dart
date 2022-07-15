import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/getWorkspace.dart';



Future <GetWorkspace> getData(GetWorkspace _ws) async{
    final url = Uri.parse("http://sit-consent.beconsent.tech:3003/api/v1/workspaces/1");
    var response = await http.get(url);
    print(response.body);
    _ws = getWorkspaceFromJson(response.body);
    return _ws;
  }

cancelConsent() async{
    final url = Uri.parse("http://dev.beconsent.tech/api/v1/03a29a62-eb39-4d7b-895c-7e900d893e37/user-consents");
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