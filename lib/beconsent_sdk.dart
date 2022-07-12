library beconsent_sdk;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;
import 'package:beconsent_sdk/model/toggle_switch.dart';
import 'package:beconsent_sdk/model/getWorkspace.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;





press(var context) async {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) => BeConsent(),
  );
}

class BeConsent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BeConsentState();
  }
}

class _BeConsentState extends State<BeConsent> {
  late Future<String?> code;
  String? label = "";
  var consent = ['1', '2', '3', '4'];
  late GetWorkspace _ws;
  add_toogle() {
    for (int i = 0; i < consent.length; i++) {
      toggle_switch('$i[i]');
    }
  }

  Dataload() async {
  response.beconsent_api().getuuid().then((value){
    setState(() {
      label = value;
    });
  } );
}

  String Decline = 'Decline';


  @override
  void initState(){
    code = Dataload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                child: Column(
              children: [
                Text(
                  'MUTSARI DELIVERY User Data Collection Consent',
                  style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                ),
                Text(
                    'to store information MUTSARI DELIVERY User Data Collection Consent'),
              ],
            )),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  toggle_switch('collect user information $label')
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => cancel(),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                    child: Text('$Decline'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => Accept(),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                      child: Text("Accept All"))
                ],
              ),
            ),
            // Container(
            //   child: Column(children: [
            //     Image(image: NetworkImage('https://github.com/RealRavip/beconsent-sdk/blob/main/img/beconsent_logo.png')),
            //   ]),
            // )
          ],
        ));
  }

  void cancel() {
    print("press cancel");
    Navigator.of(context).pop();
  }

  void Accept() {
    print("press Accept");
    // setState(() {
    //   Future<String?> uuid = response.beconsent_api().getStatus();
    //   print('$uuid');
    // });
    Navigator.of(context).pop();
  }
}
