import 'package:http/http.dart' as http;

class beconsent_api{
  beconsent_api({
    this.url,
  });

  String? url;

  void getInfo() async{
    final link = Uri.parse('https://fakestoreapi.com/carts');
    http.Response response = await http.get(link);

    print(response);
  }
}
