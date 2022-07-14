import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class toggle_switch extends StatefulWidget {
  var text;
  toggle_switch(String txt) {
    text = txt;
  }
  @override
  State<StatefulWidget> createState() {
    return _toggle_switchState(text);
  }
}

class _toggle_switchState extends State<toggle_switch> {
  var consent_name;
  _toggle_switchState(String text) {
    consent_name = text;
  }

  bool val = false;
  String Decline = 'Decline';

  changestate(bool newv) {
    setState(() {
      val = newv;
    });
    if (val == true) {
      Decline = 'Save Setting';
    } else {
      Decline = 'Decline';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(consent_name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        trailing: CupertinoSwitch(
            value: val,
            onChanged: (newValue) {
              changestate(newValue);
            },
            trackColor: Colors.grey,
            activeColor: Colors.blue),
      ),
    );
  }
}



// Padding(
//     padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(text1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//         Spacer(),
//         CupertinoSwitch(
//             value: val,
//             onChanged: (newValue) {
//               changestate(newValue);
//             },
//             trackColor: Colors.grey,
//             activeColor: Colors.blue)
//       ],
//     ),
//   );