import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/getWorkspace.dart';



Future <GetWorkspace> getData(GetWorkspace _ws) async{
    final url = Uri.parse("http://sit-consent.beconsent.tech:3003/api/v1/workspaces/1");
    var response = await http.get(url);
    print(response.body);
    _ws = getWorkspaceFromJson(response.body);
    return _ws;
  }