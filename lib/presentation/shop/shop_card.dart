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

  Widget actionButton(Skin skin) {
    if (skin.isOwner) {
      if (skin.isSelected) {
        return const TextButton(onPressed: null, child: Text("SELECTED"));
      } else {
        return TextButton(
          child: const Text("SELECT"),
          onPressed: () => onSelectFunction(skin),
        );
      }
    } else {
      return TextButton(
        child: Text("BUY (${skin.cost})"),
        onPressed: () => onBuyFunction(skin),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(skin.name),
                        subtitle: Text(skin.description),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          actionButton(skin),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
}
