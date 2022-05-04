import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/profile_events.dart';
import 'package:arithmetic_pvp/bloc/states/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile_bloc.dart';

class ProfileEdit extends StatelessWidget {
  final _userNameController = TextEditingController();

  ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _dismissEditDialog() {
      Navigator.pop(context);
    }

    submitUserName() {
      _profileBloc.add(ProfileEventChangeUsername(_userNameController.text));
    }

    _handleState(context, state){
      log(state.toString());
      if (state is ProfileChangeUsernameStateLoaded){
        if (state.changeNameResponse.status){
          _dismissEditDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Success"),
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.changeNameResponse.error??"Error! Please try again later"),
            ),
          );
        }
      }
    }

    _showEditDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BlocConsumer(
            bloc: _profileBloc,
            listener: (context, state) => _handleState(context, state),
            builder: (context, state) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Change username'),
                  content: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _userNameController,
                          maxLength: 30,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type desired username',
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: (state is ProfileChangeUsernameStateLoading)
                          ? null
                          : _dismissEditDialog,
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: (state is ProfileChangeUsernameStateLoading)
                          ? null
                          : submitUserName,
                      child: const Text('Apply'),
                    )
                  ],
                );
              });
            },
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: OutlinedButton(
        onPressed: _showEditDialog,
        child: const Text(
          "Edit profile",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
