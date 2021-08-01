import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/group_family_blocs.dart';
import 'package:personhealth/events/group_family_events.dart';
import 'package:personhealth/models/user_family_group.dart';
import 'package:personhealth/screens/group_detail_screen.dart';

class ConservationList extends StatefulWidget {
  final UserFamilyGroup userFamilyGroup;
  const ConservationList({Key? key, required this.userFamilyGroup}) : super(key: key);

  @override
  _ConservationListState createState() => _ConservationListState();
}

class _ConservationListState extends State<ConservationList> {
  late UserFamilyGroup _userFamilyGroup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userFamilyGroup = widget.userFamilyGroup;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(
          create: (context) => GroupFamilyBloc()..add(GroupFamilyFetchEvent(familyId: _userFamilyGroup.id)),
          child: GroupDetailScreen(familyId: _userFamilyGroup.id, roleInGroup: _userFamilyGroup.roleInTheGroup, groupName: _userFamilyGroup.name,),
        )));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(_userFamilyGroup.avatar),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_userFamilyGroup.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
