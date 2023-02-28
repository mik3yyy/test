part of persistent_bottom_nav_bar;

class PersistentBottomNavBar extends StatelessWidget {
  const PersistentBottomNavBar({
    Key? key,
    this.margin,
    this.confineToSafeArea,
    this.customNavBarWidget,
    this.hideNavigationBar,
    this.onAnimationComplete,
    this.navBarEssentials,
    this.navBarDecoration,
    this.navBarStyle,
    this.isCustomWidget = false,
  }) : super(key: key);

  final NavBarEssentials? navBarEssentials;
  final EdgeInsets? margin;
  final NavBarDecoration? navBarDecoration;
  final NavBarStyle? navBarStyle;

  final Widget? customNavBarWidget;
  final bool? confineToSafeArea;
  final bool? hideNavigationBar;
  final Function(bool, bool)? onAnimationComplete;
  final bool? isCustomWidget;

  Widget _navBarWidget() => Padding(
        padding: margin!,
        child: isCustomWidget!
            ? margin!.bottom > 0
                ? SafeArea(
                    top: false,
                    bottom: navBarEssentials!.navBarHeight == 0.0 ||
                            (hideNavigationBar ?? false)
                        ? false
                        : confineToSafeArea ?? true,
                    child: Container(
                      color: navBarEssentials!.backgroundColor,
                      height: navBarEssentials!.navBarHeight,
                      child: customNavBarWidget,
                    ),
                  )
                : Container(
                    color: navBarEssentials!.backgroundColor,
                    child: SafeArea(
                        top: false,
                        bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                (hideNavigationBar ?? false)
                            ? false
                            : confineToSafeArea ?? true,
                        child: SizedBox(
                            height: navBarEssentials!.navBarHeight,
                            child: customNavBarWidget)),
                  )
            : navBarStyle == NavBarStyle.style15 ||
                    navBarStyle == NavBarStyle.style16
                ? margin!.bottom > 0
                    ? SafeArea(
                        top: false,
                        right: false,
                        left: false,
                        bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                (hideNavigationBar ?? false)
                            ? false
                            : confineToSafeArea ?? true,
                        child: Container(
                          decoration: getNavBarDecoration(
                            decoration: navBarDecoration,
                            color: navBarEssentials!.backgroundColor,
                            opacity: navBarEssentials!
                                .items![navBarEssentials!.selectedIndex!]
                                .opacity,
                          ),
                          child: getNavBarStyle(),
                        ),
                      )
                    : Container(
                        decoration: getNavBarDecoration(
                          decoration: navBarDecoration,
                          color: navBarEssentials!.backgroundColor,
                          opacity: navBarEssentials!
                              .items![navBarEssentials!.selectedIndex!].opacity,
                        ),
                        child: SafeArea(
                          top: false,
                          right: false,
                          left: false,
                          bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                  (hideNavigationBar ?? false)
                              ? false
                              : confineToSafeArea ?? true,
                          child: getNavBarStyle()!,
                        ),
                      )
                : Stack(
                    children: [
                      Container(
                        decoration: getNavBarDecoration(
                          decoration: navBarDecoration,
                          showBorder: false,
                          color: navBarEssentials!.backgroundColor,
                          opacity: navBarEssentials!
                              .items![navBarEssentials!.selectedIndex!].opacity,
                        ),
                        child: ClipRRect(
                          borderRadius: navBarDecoration!.borderRadius ??
                              BorderRadius.zero,
                          child: BackdropFilter(
                            filter: navBarEssentials!
                                    .items![navBarEssentials!.selectedIndex!]
                                    .filter ??
                                ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            child: Container(
                              decoration: getNavBarDecoration(
                                showOpacity: false,
                                decoration: navBarDecoration,
                                color: navBarEssentials!.backgroundColor,
                                opacity: navBarEssentials!
                                    .items![navBarEssentials!.selectedIndex!]
                                    .opacity,
                              ),
                              child: SafeArea(
                                top: false,
                                right: false,
                                left: false,
                                bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                        (hideNavigationBar ?? false)
                                    ? false
                                    : confineToSafeArea ?? true,
                                child: getNavBarStyle()!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      );

  @override
  Widget build(BuildContext context) {
    return hideNavigationBar == null
        ? _navBarWidget()
        : OffsetAnimation(
            hideNavigationBar: hideNavigationBar,
            navBarHeight: navBarEssentials!.navBarHeight,
            onAnimationComplete: (isAnimating, isComplete) {
              onAnimationComplete!(isAnimating, isComplete);
            },
            child: _navBarWidget(),
          );
  }

  PersistentBottomNavBar copyWith(
      {int? selectedIndex,
      double? iconSize,
      int? previousIndex,
      Color? backgroundColor,
      Duration? animationDuration,
      List<PersistentBottomNavBarItem>? items,
      ValueChanged<int>? onItemSelected,
      double? navBarHeight,
      EdgeInsets? margin,
      NavBarStyle? navBarStyle,
      double? horizontalPadding,
      Widget? customNavBarWidget,
      Function(int)? popAllScreensForTheSelectedTab,
      bool? popScreensOnTapOfSelectedTab,
      NavBarDecoration? navBarDecoration,
      NavBarEssentials? navBarEssentials,
      bool? confineToSafeArea,
      ItemAnimationProperties? itemAnimationProperties,
      Function? onAnimationComplete,
      bool? hideNavigationBar,
      bool? isCustomWidget,
      EdgeInsets? padding}) {
    return PersistentBottomNavBar(
        confineToSafeArea: confineToSafeArea ?? this.confineToSafeArea,
        margin: margin ?? this.margin,
        navBarStyle: navBarStyle ?? this.navBarStyle,
        hideNavigationBar: hideNavigationBar ?? this.hideNavigationBar,
        customNavBarWidget: customNavBarWidget ?? this.customNavBarWidget,
        onAnimationComplete:
            onAnimationComplete as dynamic Function(bool, bool)? ??
                this.onAnimationComplete,
        navBarEssentials: navBarEssentials ?? this.navBarEssentials,
        isCustomWidget: isCustomWidget ?? this.isCustomWidget,
        navBarDecoration: navBarDecoration ?? this.navBarDecoration);
  }

  bool opaque(int? index) {
    return navBarEssentials!.items == null
        ? true
        : !(navBarEssentials!.items![index!].opacity < 1.0);
  }

  Widget? getNavBarStyle() {
    if (isCustomWidget!) {
      return customNavBarWidget;
    } else {
      switch (navBarStyle) {
        case NavBarStyle.style1:
          return BottomNavStyle1(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style2:
          return BottomNavStyle2(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style3:
          return BottomNavStyle3(
            navBarEssentials: navBarEssentials,
          );

        default:
          return BottomNavSimple(
            navBarEssentials: navBarEssentials,
          );
      }
    }
  }
}
