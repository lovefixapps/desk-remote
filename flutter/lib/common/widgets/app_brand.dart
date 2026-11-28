import 'package:flutter/material.dart';
import 'package:flutter_hbb/common.dart';

class AppBrand extends StatelessWidget {
  const AppBrand({
    Key? key,
    this.iconSize = 32,
    this.fontSize = 18,
  }) : super(key: key);

  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(iconSize * 0.18),
          child: loadIcon(iconSize),
        ),
        SizedBox(width: iconSize * 0.22),
        Text(
          kAppDisplayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
              ),
        ),
      ],
    );
  }
}
