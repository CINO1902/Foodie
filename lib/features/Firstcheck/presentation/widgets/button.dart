import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class buttonprofile extends StatelessWidget {
  buttonprofile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(25)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            SizedBox(child: icon),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(
            child: SvgPicture.asset('images/svg/Vector-6.svg',
                color: Theme.of(context).primaryColorDark)),
      ]),
    );
  }
}
