import 'package:flutter_test/flutter_test.dart';

import 'package:beconsent_sdk/beconsent_sdk.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as res;
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/getWorkspace.dart';

late GetWorkspace _ws;
Future<void> main() async {
  int? code = await getData();
  print(code);
    test('adds one to input values', () {
  });
  
}


  Future<int?> getData() async {
  try {
    final url = Uri.parse("http://sit-consent.beconsent.tech:3003/api/v1/workspaces/1");
    http.Response response = await http.get(url);
    _ws = getWorkspaceFromJson(response.body);
    int? status = response.statusCode;
    return status;
  } catch (e) {
    print(e);
    return 0;
  }
}