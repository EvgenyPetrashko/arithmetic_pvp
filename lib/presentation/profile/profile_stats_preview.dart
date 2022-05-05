import 'package:arithmetic_pvp/presentation/profile/stats_see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileStatsPreview extends StatelessWidget {
  const ProfileStatsPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Stats',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SvgPicture.asset('assets/fight.svg', width: 80),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Your Rating:  ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "3829",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const RedirectToStats()
      ],
    );
  }
}
