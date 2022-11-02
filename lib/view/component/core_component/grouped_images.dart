import 'package:flutter/material.dart';

class GroupedImage extends StatelessWidget {
  const GroupedImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
                child: Image.asset(
                    'assets/images/Group 7.png')),
            Expanded(
                child: Image.asset(
                    'assets/images/Group 8.png')),
          ],
        ),
        Image.asset('assets/images/Group 5.png'),
      ],
    );
  }
}
