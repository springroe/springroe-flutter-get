import 'package:flutter/material.dart';

class ImageCheckBox extends StatelessWidget {
  final bool check;
  final Widget? label;
  final ValueChanged<bool> onChange;

  const ImageCheckBox(
      {Key? key, required this.check, this.label, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String asset = check ? 'assets/ic_check_on.png' : 'assets/ic_check_off.png';
    return GestureDetector(
      onTap: () {
        onChange(!check);
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Image.asset(
              asset,
              width: 20,
              height: 20,
              color: Colors.pink,
            ),
            const SizedBox(
              width: 6,
            ),
            label ?? Container()
          ],
        ),
      ),
    );
  }
}
