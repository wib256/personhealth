import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personhealth/models/clinic.dart';

class ClinicDetailScreen extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailScreen({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.7,
        heightFactor: 0.7,
        child: Material(
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Text('${clinic.name}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Text('Address: ${clinic.address}, ${clinic.district}'),
                Text('Phone: ${clinic.phone}'),
                Text('Description: ${clinic.description}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
