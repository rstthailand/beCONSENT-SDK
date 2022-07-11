library beconsent_sdk;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;
import 'package:beconsent_sdk/model/toggle_switch.dart';
import 'package:beconsent_sdk/model/getWorkspace.dart';
import 'package:http/src/response.dart';

class BeConsent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BeConsentState();
  }
}

class _BeConsentState extends State<BeConsent> {
  bool val = false;
  String Decline = 'Decline';
  changestate(bool newv) {
    setState(() {
      val = newv;
    });
    if(val == true){
      Decline = 'Save Setting';
    }
    else{
      Decline = 'Decline';
    }
    
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
          child: Text(
            'BeConsent',
            style: TextStyle(fontSize: 20,fontFamily: 'Kanit'),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Toggle_btn('test1', val, changestate),
              Toggle_btn('test2', val, changestate)
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  child: Text("Accept All"))
            ],
          ),
        )
      ],
    )
    );
  }

  void cancel() {
    print("press cancel");
    Navigator.of(context).pop();
  }

  void Accept() {
    print("press Accept");
    Future<Response> uuid = response.beconsent_api().getUUID();
    print("$uuid");
    Navigator.of(context).pop();
  }
}
