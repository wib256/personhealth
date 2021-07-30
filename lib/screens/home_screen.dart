import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/clinic_blocs.dart';
import 'package:personhealth/blocs/examination_blocs.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/blocs/patient_blocs.dart';
import 'package:personhealth/events/clinic_events.dart';
import 'package:personhealth/events/examination_events.dart';
import 'package:personhealth/events/group_event.dart';
import 'package:personhealth/events/patient_events.dart';
import 'package:personhealth/screens/clinic_screen.dart';
import 'package:personhealth/screens/personal_screen.dart';
import 'package:personhealth/screens/examination_screen.dart';
import 'package:personhealth/screens/group_screen.dart';

class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({Key? key, required this.index}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return BlocProvider(
        create: (context) => ClinicBloc()..add(ClinicFetchEvent()),
        child: FirstScreen(),
      );
    } else if (this.selectedIndex == 1) {
      return BlocProvider(
          create: (context) => ExaminationBloc()..add(ExaminationFetchEvent()),
          child: ExaminationScreen());
    }
    if (this.selectedIndex == 2) {
      return BlocProvider(
        create: (context) => GroupBloc()..add(GroupFetchEvent()),
        child: GroupScreen(),
      );
    } else {
      return BlocProvider(
        create: (context) => PatientBloc()..add(PatientViewEvent()),
        child: PersonalScreen(),
      );
    }
  }

  AppBar getAppBar() {
    switch (selectedIndex) {
      case 0:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Text('Personal Health'),
          centerTitle: true,
        );
      case 1:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Text('Personal Health'),
          centerTitle: true,
        );
      case 2:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Text('Personal Health'),
          centerTitle: true,
        );
      case 3:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Text('Personal Health'),
          centerTitle: true,
        );
    }
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Personal Health'),
      centerTitle: true,
    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.setState(() {
      selectedIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        backgroundColor: Colors.blue[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Clinics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Examination',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Personal',
          ),
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    ));
  }
}
