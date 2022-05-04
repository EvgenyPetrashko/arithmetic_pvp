import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../data/models/skin.dart';

class Constants {
  Constants._();

  static const double padding = 10;
  static const double skinRadius = 48;
}

class SkinDialog extends StatelessWidget {
  final Skin skin;
  final Function buyButtonFunction;

  const SkinDialog(
      {Key? key, required this.skin, required this.buyButtonFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(
            left: Constants.padding,
            top: Constants.skinRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding),
        margin: const EdgeInsets.only(top: Constants.skinRadius),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 5), blurRadius: 15),
            ]),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            skin.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            skin.description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  primary: Colors.green,
                ),
                onPressed: () {
                  buyButtonFunction(skin);
                },
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    skin.cost.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(
                    Icons.monetization_on,
                    color: Colors.amber,
                    size: 20,
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
      Positioned(
        left: Constants.padding,
        right: Constants.padding,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: Constants.skinRadius,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(Constants.skinRadius),
            ),
            child: CachedNetworkImage(
              height: 96,
              width: 96,
              imageUrl: skin.assetUrl,
              placeholder: (context, url) => Center(
                child: JumpingText(
                  '···',
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    ]);
  }
}
