import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    _dismissEditDialog() {
      Navigator.pop(context);
    }

    _showEditDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Change username'),
              content: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      maxLength: 30,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type desired username',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(onPressed: () {}, child: const Text("Check"))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: _dismissEditDialog,
                  child: const Text('Cancel'),
                ),
                const TextButton(
                  onPressed: null,
                  child: Text('Apply'),
                )
              ],
            );
          });
    }

    _dismissDialog() {
      Navigator.pop(context);
    }

    _showMaterialDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 1'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 2'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 3'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 4'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(onPressed: _dismissDialog, child: const Text('Close')),
              TextButton(
                onPressed: _dismissDialog,
                child: const Text('Apply'),
              )
            ],
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset('assets/logo.png', width: 100),
          ),
        ),
        BlocConsumer<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          listener: (context, state) => showUserInfo(context, state),
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    (state is ProfileStateLoaded)
                        ? state.profile?.user.username ?? ""
                        : "Loading...",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amber),
                      Text(
                        (state is ProfileStateLoaded) ? state.profile?.gold.toString() ?? "0" : "0",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

              ],
            );
          },
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: OutlinedButton(
            onPressed: _showEditDialog,
            child: const Text(
              "Edit profile",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}
