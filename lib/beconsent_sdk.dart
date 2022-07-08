library beconsent_sdk;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;

class BeConsent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BeConsentState();
  }
  
}

class _BeConsentState extends State<BeConsent>{
  bool val = false;
  changestate(bool newv){
    setState(() {
      val = newv;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            'BeConsent',
            style: TextStyle(fontSize: 20),
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
                child: Text('Decline'),
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                  onPressed: () => Accept(),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  child: Text("Accept All"))
            ],
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
        )
      ],
    );
  }

void cancel() {
  print("press cancel");
  Navigator.of(context).pop();
}
}

Widget Toggle_btn(String text, bool val, Function ChangeState){
  return Padding(
    padding: const EdgeInsets.only(top: 22.0,left: 16.0,right: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600
        )),
        Spacer(),
        CupertinoSwitch(
          value: val, 
          onChanged: (newValue) {
            ChangeState(newValue);
          },
          trackColor: Colors.grey,
          activeColor: Colors.blue)
      ],

    ),);
}

void Accept() {
  print("press Accept");
}

