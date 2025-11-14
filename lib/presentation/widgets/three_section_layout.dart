import 'package:flutter/material.dart';

import '../styles/style_extensions.dart';

class ThreeSectionLayout extends StatelessWidget {
  const ThreeSectionLayout({
    required this.content,
    required this.header,
    required this.sidebar,
    super.key,
    this.dividerColor,
    this.dividerThickness,
    this.sectionSpacing,
  });

  final Widget header;
  final Widget sidebar;
  final Widget content;

  final double? sectionSpacing;
  final double? dividerThickness;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    final sectionSpacing =
        this.sectionSpacing ??
        context.appTheme.threeSectionLayoutTheme.sectionSpacing;
    final dividerThickness =
        this.dividerThickness ??
        context.appTheme.threeSectionLayoutTheme.dividerThickness;
    final dividerColor =
        this.dividerColor ??
        context.appTheme.threeSectionLayoutTheme.dividerColor;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: sectionSpacing / 2),
          child: header,
        ),
        Divider(
          height: dividerThickness,
          thickness: dividerThickness,
          color: dividerColor,
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: sectionSpacing / 2,
                  right: sectionSpacing / 2,
                ),
                child: sidebar,
              ),
              VerticalDivider(
                width: dividerThickness,
                thickness: dividerThickness,
                color: dividerColor,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: sectionSpacing / 2,
                    left: sectionSpacing / 2,
                  ),
                  child: content,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ThreeSectionLayoutTheme {
  const ThreeSectionLayoutTheme({
    required this.sectionSpacing,
    required this.dividerThickness,
    required this.dividerColor,
  });

  final double sectionSpacing;
  final double dividerThickness;
  final Color dividerColor;
}
