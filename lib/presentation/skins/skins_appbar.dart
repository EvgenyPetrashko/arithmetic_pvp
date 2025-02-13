import 'package:arithmetic_pvp/bloc/profile_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SkinsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SkinsAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)?.skins_title ?? 'Skins'),
      actions: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: Wrap(
              children: [
                BlocConsumer(
                  bloc: BlocProvider.of<ProfileBloc>(context),
                  buildWhen: (prevState, state) {
                    return state is ProfileBalanceState;
                  },
                  builder: (context, state) {
                    if (state is ProfileBalanceStateLoaded) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.balance.gold.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          SvgPicture.asset('assets/currency.svg', width: 20),
                        ],
                      );
                    } else if (state is ProfileBalanceStateError) {
                      return Text(
                          AppLocalizations.of(context)?.error ?? "Error");
                    } else {
                      return JumpingText(
                        '···',
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                      );
                    }
                  },
                  listener: (context, state) => {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
