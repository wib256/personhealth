import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogForEditSharing extends StatefulWidget {
  const AlertDialogForEditSharing({Key? key}) : super(key: key);

  @override
  _AlertDialogForEditSharingState createState() => _AlertDialogForEditSharingState();
}

class _AlertDialogForEditSharingState extends State<AlertDialogForEditSharing> {
  late bool valueFirst = false;
  late bool valueSecond = false;
  late bool valueThird = false;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Edit Sharing')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Edit'),
        ),
      ],
      content: Container(
        height: 200,
        child: Column(
          children: [
            CheckboxListTile(
              secondary: const Icon(Icons.person),
              title: const Text('Basic information'),
              subtitle: Text('name, date of birth, blood group,...'),
              value: this.valueFirst,
              onChanged: (bool? value) {
                setState(() {
                  this.valueFirst = value!;
                });
              },

            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              secondary: const Icon(Icons.info),
              title: const Text('Body information'),
              subtitle: Text('height, weight, eyesight,...'),
              value: this.valueSecond,
              onChanged: (bool? value) {
                setState(() {
                  this.valueSecond = value!;
                  print(this.valueSecond);
                });
              },

            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              secondary: const Icon(Icons.medical_services),
              title: const Text('Medical history'),
              subtitle: Text('diseases that have been acquired'),
              value: this.valueThird,
              onChanged: (bool? value) {
                setState(() {
                  this.valueThird = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
