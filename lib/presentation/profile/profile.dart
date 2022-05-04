import 'package:arithmetic_pvp/presentation/profile/profile_info.dart';
import 'package:arithmetic_pvp/presentation/profile/profile_stats_preview.dart';
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
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              const ProfileInfo(),
              const SizedBox(
                height: 40,
              ),
              const ProfileStatsPreview(),
            ],
          ),
        ),
      ),
    );
  }
}
