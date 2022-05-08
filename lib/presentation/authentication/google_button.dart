import 'package:arithmetic_pvp/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/events/auth_events.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return OutlinedButton(
      onPressed: () => _authBloc.add(AuthEventStartLoading()),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/google_icon.png",
              width: 32,
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                AppLocalizations.of(context)?.sign_in_with_google ??
                    "Sign in with Google",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
