import 'package:http/http.dart' as http;

class beconsent_api{
  beconsent_api({
    this.url,
  });

  String? url;

  void getInfo(String url) async{
    final link = Uri.parse(url);
    http.Response response = await http.get(link);

    print(response);
  }
}