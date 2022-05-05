import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/profile_events.dart';
import 'package:arithmetic_pvp/bloc/states/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile_bloc.dart';

class UsernameDialogConstants {
  UsernameDialogConstants._();

  static const double topContainerPadding = 30;
  static const double topContainerTopRadius = 25;
  static const double topContainerBottomRadius = 40;

  static const double labelPadding = 20;
  static const double labelTopRadius = 30;
  static const double labelBottomRadius = 60;

  static const double bottomContainerPadding = 15;
  static const double bottomContainerRadius = 40;

  static const double buttonRadius = 40;
  static const double buttonPadding = 20;
}

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

    _handleState(context, state) {
      log(state.toString());
      if (state is ProfileChangeUsernameStateLoaded) {
        if (state.changeNameResponse.status) {
          _dismissEditDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Success"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.changeNameResponse.error ??
                  "Error! Please try again later"),
            ),
          );
        }
      }
    }

    __showEditDialog() {
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

    _contentBox(context, state) {
      return Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: UsernameDialogConstants.topContainerPadding,
                top: UsernameDialogConstants.labelPadding +
                    UsernameDialogConstants.topContainerPadding,
                right: UsernameDialogConstants.topContainerPadding,
                bottom: UsernameDialogConstants.topContainerPadding),
            margin: const EdgeInsets.only(
                top: UsernameDialogConstants.labelPadding,
                bottom: UsernameDialogConstants.buttonPadding +
                    UsernameDialogConstants.bottomContainerPadding),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                    UsernameDialogConstants.topContainerTopRadius),
                topRight: Radius.circular(
                    UsernameDialogConstants.topContainerTopRadius),
                bottomLeft: Radius.circular(
                    UsernameDialogConstants.topContainerBottomRadius),
                bottomRight: Radius.circular(
                    UsernameDialogConstants.topContainerBottomRadius),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(
                        0, UsernameDialogConstants.topContainerPadding / 2),
                    blurRadius: UsernameDialogConstants.topContainerPadding),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          controller: _userNameController,
                          maxLength: 30,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: 'Your username',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 40,
            right: 40,
            child: Container(
              height: UsernameDialogConstants.labelPadding * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(UsernameDialogConstants.labelTopRadius),
                  topRight:
                      Radius.circular(UsernameDialogConstants.labelTopRadius),
                  bottomLeft: Radius.circular(
                      UsernameDialogConstants.labelBottomRadius),
                  bottomRight: Radius.circular(
                      UsernameDialogConstants.labelBottomRadius),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 2),
                      blurRadius: 15),
                ],
              ),
              alignment: Alignment.center,
              child: const ClipRect(
                child: Text(
                  'Enter Your Name',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: UsernameDialogConstants.buttonPadding,
            left: 30,
            right: 30,
            height: UsernameDialogConstants.bottomContainerPadding * 2,
            child: ClipRect(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).dialogBackgroundColor,
                  // color: Colors.grey,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(
                        UsernameDialogConstants.bottomContainerRadius),
                    bottomRight: Radius.circular(
                        UsernameDialogConstants.bottomContainerRadius),
                  ),
                  // boxShadow: const [
                  //   BoxShadow(
                  //       color: Colors.black,
                  //       offset: Offset(0, UsernameDialogConstants.bottomContainerPadding),
                  //       blurRadius: 2),
                  // ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 80,
            right: 80,
            height: UsernameDialogConstants.buttonPadding * 2,
            child: ClipRect(
              child: OutlinedButton(
                onPressed: (state is ProfileChangeUsernameStateLoading)
                    ? null
                    : submitUserName,
                child: const Text(
                  'OK',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  // primary: Colors.white,
                  backgroundColor: Colors.lightGreen,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(UsernameDialogConstants.buttonRadius),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Positioned(
          //   top: UsernameDialogConstants.topContainerPadding * 0.75,
          //   right: 5,
          //   // height: UsernameDialogConstants.buttonPadding * 2,
          //   child: ClipRect(
          //     child: IconButton(
          //       icon: const Icon(
          //         Icons.close,
          //         color: Colors.black,
          //         size: 20,
          //       ),
          //       onPressed: (state is ProfileChangeUsernameStateLoading)
          //           ? null
          //           : _dismissEditDialog,
          //     ),
          //   ),
          // ),
        ],
      );
    }

    _showEditDialog() {
      showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return BlocConsumer(
            bloc: _profileBloc,
            listener: (context, state) => _handleState(context, state),
            builder: (context, state) {
              return StatefulBuilder(builder: (context, setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        UsernameDialogConstants.topContainerPadding),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  // backgroundColor: Colors.black,
                  child: _contentBox(context, state),
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
