import 'package:arithmetic_pvp/presentation/profile/profile_edit.dart';
import 'package:arithmetic_pvp/presentation/profile/profile_settings.dart';
import 'package:arithmetic_pvp/presentation/profile/stats_redirect.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/states/profile_states.dart';

class GeneralProfileInfo extends StatelessWidget {
  const GeneralProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    void showUserInfo(BuildContext context, ProfileState state) {
      if (state is ProfileStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      }
    }

    return Column(
      children: [
        BlocConsumer<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          listener: (context, state) => showUserInfo(context, state),
          buildWhen: (previousState, newState) {
            return newState is ProfilePageState;
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: (state is ProfileStateLoaded)
                      ? CachedNetworkImage(
                          height: 100,
                          width: 100,
                          imageUrl: state.profile?.assetUrl ?? "",
                          placeholder: (context, url) => Center(
                                child: JumpingText('···',
                                    style: const TextStyle(fontSize: 40)),
                              ),
                          errorWidget: (context, url, error) => ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child:
                                    Image.asset('assets/logo.png', width: 100),
                              ))
                      : Center(
                          child: JumpingText('···',
                              style: const TextStyle(fontSize: 40)),
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: (state is ProfileStateLoaded)
                      ? Text(state.profile?.user.username ?? "",
                          style: const TextStyle(fontSize: 20))
                      : JumpingText('···',
                          style: const TextStyle(fontSize: 20)),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amber),
                      Text(
                        (state is ProfileStateLoaded)
                            ? state.profile?.gold.toString() ?? "0"
                            : "0",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        ProfileEdit(),
        const ProfileSettings(),
        const RedirectToStats(),
      ],
    );
  }
}
