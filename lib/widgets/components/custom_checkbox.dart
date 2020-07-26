import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCheckBox extends StatelessWidget {
  // no padding checkbox
  final bool isMarked;
  final Function(bool newValue) onChange;
  final double size;
  final Color color;

  CustomCheckBox({
    @required this.color,
    @required this.isMarked,
    @required this.onChange,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size,
        maxWidth: size,
      ),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          _getIconData(),
          size: size,
          color: color,
        ),
        onPressed: () => onChange(!isMarked),
      ),
    );
  }

  IconData _getIconData() {
    if (isMarked) {
      return FontAwesomeIcons.checkSquare;
    }

    return Icons.check_box_outline_blank;
  }
}
