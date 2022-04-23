part of persistent_bottom_nav_bar;

class BottomNavStyle1 extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;

  const BottomNavStyle1({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height) {
    return navBarEssentials!.navBarHeight == 0
        ? const SizedBox.shrink()
        : AnimatedContainer(
            width: isSelected ? 120 : 50,
            height: height! / 1.6,
            duration: navBarEssentials!.itemAnimationProperties?.duration ??
                const Duration(milliseconds: 400),
            curve:
                navBarEssentials!.itemAnimationProperties?.curve ?? Curves.ease,
            padding: EdgeInsets.all(item.contentPadding),
            decoration: BoxDecoration(
              color: isSelected
                  ? item.activeColorPrimary.withOpacity(0.2)
                  : navBarEssentials!.backgroundColor!.withOpacity(0.0),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Container(
              alignment: Alignment.center,
              height: height / 1.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: item.title == null ? 0.0 : 8),
                      child: IconTheme(
                        data: IconThemeData(
                            size: item.iconSize,
                            color: isSelected
                                ? (item.activeColorSecondary ??
                                    item.activeColorPrimary)
                                : item.inactiveColorPrimary ??
                                    item.activeColorPrimary),
                        child: isSelected
                            ? item.icon
                            : item.inactiveIcon ?? item.icon,
                      ),
                    ),
                  ),
                  item.title == null
                      ? const SizedBox.shrink()
                      : isSelected
                          ? Flexible(
                              child: Material(
                                type: MaterialType.transparency,
                                child: FittedBox(
                                    child: Text(
                                  item.title!,
                                  style: item.textStyle != null
                                      ? (item.textStyle!.apply(
                                          color: isSelected
                                              ? (item.activeColorSecondary ??
                                                  item.activeColorPrimary)
                                              : item.inactiveColorPrimary))
                                      : TextStyle(
                                          color: (item.activeColorSecondary ??
                                              item.activeColorPrimary),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0),
                                )),
                              ),
                            )
                          : const SizedBox.shrink()
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: navBarEssentials!.navBarHeight,
        padding: navBarEssentials!.padding == null
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
                vertical: navBarEssentials!.navBarHeight! * 0.15,
              )
            : EdgeInsets.only(
                top: navBarEssentials!.padding?.top ??
                    navBarEssentials!.navBarHeight! * 0.15,
                left: navBarEssentials!.padding?.left ??
                    MediaQuery.of(context).size.width * 0.07,
                right: navBarEssentials!.padding?.right ??
                    MediaQuery.of(context).size.width * 0.07,
                bottom: navBarEssentials!.padding?.bottom ??
                    navBarEssentials!.navBarHeight! * 0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: navBarEssentials!.items!.map((item) {
            int index = navBarEssentials!.items!.indexOf(item);
            return Flexible(
              flex: navBarEssentials!.selectedIndex == index ? 2 : 1,
              child: GestureDetector(
                onTap: () {
                  if (navBarEssentials!.items![index].onPressed != null) {
                    navBarEssentials!.items![index].onPressed!(
                        navBarEssentials!.selectedScreenBuildContext);
                  } else {
                    navBarEssentials!.onItemSelected!(index);
                  }
                },
                child: _buildItem(
                    item,
                    navBarEssentials!.selectedIndex == index,
                    navBarEssentials!.navBarHeight),
              ),
            );
          }).toList(),
        ));
  }
}
