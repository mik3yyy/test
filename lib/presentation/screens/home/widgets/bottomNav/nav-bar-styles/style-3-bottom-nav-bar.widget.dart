part of persistent_bottom_nav_bar;

class BottomNavStyle3 extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;

  const BottomNavStyle3({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height) {
    return navBarEssentials!.navBarHeight == 0
        ? const SizedBox.shrink()
        : AnimatedContainer(
            width: 40.0,
            height: height! / 1.0,
            duration: navBarEssentials!.itemAnimationProperties?.duration ??
                const Duration(milliseconds: 1000),
            curve:
                navBarEssentials!.itemAnimationProperties?.curve ?? Curves.ease,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: navBarEssentials!.itemAnimationProperties?.duration ??
                  const Duration(milliseconds: 1000),
              curve: navBarEssentials!.itemAnimationProperties?.curve ??
                  Curves.ease,
              alignment: Alignment.center,
              height: height / 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
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
                  item.title == null
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 4.5),
                          child: Material(
                            type: MaterialType.transparency,
                            child: DefaultTextStyle.merge(
                              style: TextStyle(
                                  color: item.textStyle != null
                                      ? item.textStyle!.apply(
                                              color: isSelected
                                                  ? (item.activeColorSecondary ??
                                                      item.activeColorPrimary)
                                                  : item.inactiveColorPrimary)
                                          as Color?
                                      : isSelected
                                          ? (item.activeColorSecondary ??
                                              item.activeColorPrimary)
                                          : item.inactiveColorPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0),
                              child: FittedBox(child: Text(item.title!)),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Color selectedItemActiveColor = navBarEssentials!
        .items![navBarEssentials!.selectedIndex!].activeColorPrimary;
    double itemWidth = ((MediaQuery.of(context).size.width -
            ((navBarEssentials!.padding?.left ??
                    MediaQuery.of(context).size.width * 0.05) +
                (navBarEssentials!.padding?.right ??
                    MediaQuery.of(context).size.width * 0.05))) /
        navBarEssentials!.items!.length);
    return Container(
      width: double.infinity,
      height: navBarEssentials!.navBarHeight,
      padding: EdgeInsets.only(
          top: navBarEssentials!.padding?.top ?? 0.0,
          left: navBarEssentials!.padding?.left ??
              MediaQuery.of(context).size.width * 0.05,
          right: navBarEssentials!.padding?.right ??
              MediaQuery.of(context).size.width * 0.05,
          bottom: navBarEssentials!.padding?.bottom ??
              navBarEssentials!.navBarHeight! * 0.1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: navBarEssentials!.itemAnimationProperties?.duration ??
                    const Duration(milliseconds: 300),
                curve: navBarEssentials!.itemAnimationProperties?.curve ??
                    Curves.ease,
                color: Colors.transparent,
                width: navBarEssentials!.selectedIndex == 0
                    ? MediaQuery.of(context).size.width * 0.0
                    : itemWidth * navBarEssentials!.selectedIndex!,
                height: 4.0,
              ),
              Flexible(
                child: AnimatedContainer(
                  duration:
                      navBarEssentials!.itemAnimationProperties?.duration ??
                          const Duration(milliseconds: 300),
                  curve: navBarEssentials!.itemAnimationProperties?.curve ??
                      Curves.ease,
                  width: itemWidth,
                  height: 1.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedItemActiveColor,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: this.navBarEssentials!.items!.map((item) {
                  int index = this.navBarEssentials!.items!.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        if (this.navBarEssentials!.items![index].onPressed !=
                            null) {
                          this.navBarEssentials!.items![index].onPressed!(this
                              .navBarEssentials!
                              .selectedScreenBuildContext);
                        } else {
                          this.navBarEssentials!.onItemSelected!(index);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: _buildItem(
                            item,
                            this.navBarEssentials!.selectedIndex == index,
                            this.navBarEssentials!.navBarHeight),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
