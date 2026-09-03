import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:system_mapper/user_interface/screens/graph_view.dart';
import 'package:system_mapper/user_interface/screens/information_view.dart';
import 'package:system_mapper/user_interface/screens/settings_view.dart';
import 'package:system_mapper/user_interface/widgets/app_bars/desktop_app_bar.dart';
import 'package:system_mapper/user_interface/widgets/menu_select.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends SafeState<AppHome> {
  HomeTab _tab = HomeTab.systemInfo;

  void setHomeTab(HomeTab tab) {
    safeSetState(() {
      _tab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesktopAppBar(
        tab: _tab,
        contextWidth: MediaQuery.widthOf(context),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: LazyLoadIndexedStack(
              preloadIndexes: [],
              index: HomeTab.values.indexOf(_tab),
              children: HomeTab.values.map((tab) => tab.getScreen()).toList(),
            ),
          ),

          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: MenuSelect(callback: setHomeTab),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: '',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

enum HomeTab {
  systemInfo(
    screen: InformationView(),
    displayName: 'Information View',
    icon: Icon(Icons.info_outline_rounded),
  ),
  map(
    screen: GraphView(),
    displayName: 'Map View',
    icon: Icon(Icons.auto_graph_rounded),
  ),
  settings(
    screen: SettingsView(),
    displayName: 'Settings',
    icon: Icon(Icons.settings),
  );

  final Widget screen;
  final String displayName;
  final Icon icon;
  const HomeTab({
    required this.screen,
    required this.displayName,
    required this.icon,
  });

  Widget getScreen() {
    return screen;
  }

  Icon iconFromHomeTab() {
    return icon;
  }

  static HomeTab homeTabFromIndex(int index) {
    return HomeTab.values[index];
  }
}
