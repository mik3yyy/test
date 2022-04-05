import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/expandable_widget/expanded.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class FaqAccodrionExpandable extends StatelessWidget {
  final String headerTitle;
  final Widget child;
  const FaqAccodrionExpandable({
    required this.child,
    required this.headerTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: const ExpandableThemeData(
          iconColor: AppColors.appColor, useInkWell: true),
      child: Column(
        children: [
          ExpandableNotifier(
            child: ScrollOnExpand(
              child: Column(
                children: [
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          headerTitle,
                          style: AppText.body2(
                            context,
                            AppColors.appColor,
                            18.sp,
                          ),
                        ),
                        const ExpandableIcon(
                          theme: ExpandableThemeData(
                            expandIcon: Icons.add,
                            collapseIcon: Icons.remove,
                            iconColor: AppColors.appColor,
                            iconSize: 23.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                    collapsed: Column(),
                    expanded: child,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
