import 'package:arithmetic_pvp/presentation/profile/stats_see_all_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/profile_bloc.dart';
import '../../bloc/states/profile_states.dart';

class ProfileStatsPreview extends StatelessWidget {
  const ProfileStatsPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)?.statistics_title ?? 'Statistics',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SvgPicture.asset('assets/fight.svg', width: 80),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (AppLocalizations.of(context)?.rating_title ?? 'Rating') + ": ",
                style: const TextStyle(fontSize: 18),
              ),
              BlocBuilder(
                bloc: _profileBloc,
                buildWhen: (previous, current) {
                  return current is ProfileStateLoaded;
                },
                builder: (context, state) {
                  return Text(
                    (state is ProfileStateLoaded)
                        ? state.profile?.rating.toString() ?? "500"
                        : "Loading",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const RedirectToStats()
      ],
    );
  }
}
