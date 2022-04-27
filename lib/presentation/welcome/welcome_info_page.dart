import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeInfoPage extends StatelessWidget {
  const WelcomeInfoPage({Key? key, required this.text, required this.assetPath})
      : super(key: key);

  final String text;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(assetPath, height: 128, width: 128),
        const SizedBox(height: 100),
        SizedBox(
            width: 200,
            child: Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16.00,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic))),
      ],
    );
  }
}
