import 'package:arithmetic_pvp/presentation/profile/profile_achievements_short.dart';
import 'package:arithmetic_pvp/presentation/profile/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/events/profile_events.dart';
import '../../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(ProfileEventUserLoad());
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const <Widget>[
              SizedBox(
                height: 20,
              ),
              GeneralProfileInfo(),
              ProfileAchievements(),
            ],
          ),
        ),
      ),
    );
  }
}
