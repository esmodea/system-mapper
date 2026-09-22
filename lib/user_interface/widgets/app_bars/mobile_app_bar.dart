import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/settings/settings.dart';
import 'package:system_mapper/user_interface/mobile_app.dart';
import 'package:system_mapper/utils/current.dart';

class MobileAppBar extends StatefulWidget implements PreferredSizeWidget {
  final HomeTab tab;
  final double contextWidth;
  const MobileAppBar({
    super.key,
    required this.tab,
    required this.contextWidth,
  });

  @override
  Size get preferredSize => Size(contextWidth, 60);

  @override
  State<MobileAppBar> createState() => _MobileAppBarState();
}

class _MobileAppBarState extends State<MobileAppBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.settingsListenable,
      builder: (context, value, child) {
        // debugPrint((value is Box).toString());
        if (Current.settings is Settings) {
          if (Current.settings!.themeMode == null) {
            return AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('System Mapper > ${widget.tab.displayName}'),
              ),
              actions: [
                // IconButton(onPressed: () {}, icon: Icon(value.themeMode!.isDark ? Icons.light_mode : Icons.dark_mode)),
                SizedBox(width: 10),
              ],
            );
          } else {
            return AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('System Mapper > ${widget.tab.displayName}'),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Current.settings!.toggleThemeMode();
                  },
                  icon: Icon(
                    ThemeMode.system.parse(Current.settings!.themeMode!).isDark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                ),
                SizedBox(width: 10),
              ],
            );
          }
        } else {
          return AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(widget.tab.displayName),
            ),
            actions: [
              // IconButton(onPressed: () {}, icon: Icon(value.themeMode!.isDark ? Icons.light_mode : Icons.dark_mode)),
              SizedBox(width: 10),
            ],
          );
        }
      },
    );
  }
}
