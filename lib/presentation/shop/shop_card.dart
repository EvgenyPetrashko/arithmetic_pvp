import 'package:arithmetic_pvp/data/models/skin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        return const Text(
          "IN USE",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        );
      } else {
        return const Text(
          "SELECT",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        );
      }
    } else {
      return Wrap(
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(skin.cost.toString()),
            const SizedBox(
              width: 3,
            ),
            const Icon(
              Icons.monetization_on,
              color: Colors.amber,
              size: 16,
            ),
          ]),
        ],
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
    return InkWell(
      onTap: () => onTapFunction(skin),
      child: Card(
        child: SafeArea(
          child: Container(
            height: 100,
            color: Colors.white,
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CachedNetworkImage(
                        height: 64,
                        width: 64,
                        imageUrl: skin.assetUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator.adaptive(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error)),
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
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(top: 4, right: 4),
                  child: pricePlaceHolder(skin),
                ),
              ],
            ),
          ),
        ),
        elevation: 8,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
