import 'package:arithmetic_pvp/data/models/skin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ShopCard extends StatelessWidget {
  final Skin skin;
  final Function onBuyFunction;
  final Function onSelectFunction;

  const ShopCard({
    Key? key,
    required this.skin,
    required this.onBuyFunction,
    required this.onSelectFunction,
  }) : super(key: key);

  Widget pricePlaceHolder(Skin skin) {
    if (skin.isOwner) {
      if (skin.isSelected) {
        return Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 28,
          ),
        );
      } else {
        return Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: const Icon(
            Icons.check_circle,
            color: Colors.grey,
            size: 28,
          ),
        );
      }
    } else {
      return Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.only(top: 8, right: 8),
        child: Wrap(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  skin.cost.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                SvgPicture.asset('assets/currency.svg', width: 20),
              ],
            ),
          ],
        ),
      );
    }
  }

  onTapFunction(skin) {
    if (skin.isOwner) {
      if (!skin.isSelected) {
        onSelectFunction(skin);
      }
    } else {
      onBuyFunction(skin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTapFunction(skin),
        child: SafeArea(
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CachedNetworkImage(
                      height: 64,
                      width: 64,
                      imageUrl: skin.assetUrl,
                      placeholder: (context, url) => Center(
                        child: JumpingText(
                          '···',
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Center(
                      child: ListTile(
                        title: Text(skin.name),
                        subtitle: Text(skin.description),
                      ),
                    ),
                  ),
                ),
                pricePlaceHolder(skin),
              ],
            ),
          ),
        ),
      ),
      elevation: 3,
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
    );
  }
}
