import 'package:arithmetic_pvp/presentation/profile/profile_info.dart';
import 'package:arithmetic_pvp/presentation/profile/profile_stats_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/events/profile_events.dart';
import '../../bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(ProfileEventUserLoad());
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const <Widget>[
              SizedBox(
                height: 40,
              ),
              ProfileInfo(),
              SizedBox(
                height: 40,
              ),
              ProfileStatsPreview(),
            ],
          ),
        ),
      ),
    );
  }
}
