import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final int cost;
  final bool isOwner;

  const ShopCard(
      {Key? key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.cost,
      required this.isOwner})
      : super(key: key);

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
                    imageUrl: imageUrl,
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
                        title: Text(name),
                        subtitle: Text(description),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (isOwner)
                              ? TextButton(
                                  child: const Text("SELECT"),
                                  onPressed: () {},
                                )
                              : TextButton(
                                  child: Text("BUY ($cost)"),
                                  onPressed: () {},
                                ),
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
