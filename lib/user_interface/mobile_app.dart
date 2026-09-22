import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:system_mapper/user_interface/screens/mobile/graph_view.dart';
import 'package:system_mapper/user_interface/screens/mobile/information_view.dart';
import 'package:system_mapper/user_interface/screens/mobile/settings_view.dart';
import 'package:system_mapper/user_interface/widgets/app_bars/mobile_app_bar.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class MobileAppHome extends StatefulWidget {
  const MobileAppHome({super.key});

  @override
  State<MobileAppHome> createState() => _MobileAppHomeState();
}

class _MobileAppHomeState extends SafeState<MobileAppHome> {
  HomeTab _tab = HomeTab.systemInfo;

  void setHomeTab(HomeTab tab) {
    safeSetState(() {
      _tab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileAppBar(
        tab: _tab,
        contextWidth: MediaQuery.widthOf(context),
      ),
      body: Stack(
        children: [
          LazyLoadIndexedStack(
            preloadIndexes: [],
            index: HomeTab.values.indexOf(_tab),
            children: HomeTab.values.map((tab) => tab.getScreen()).toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setHomeTab(HomeTab.values[value]);
        },
        items: [
          ...HomeTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: tab.icon,
              label: tab.displayName,
            );
          }),
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
  map(
    screen: GraphView(),
    displayName: 'Info View',
    icon: Icon(Icons.auto_graph_rounded),
  ),
  systemInfo(
    screen: InformationView(),
    displayName: 'Home',
    icon: Icon(Icons.home),
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
