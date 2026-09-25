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
            children: HomeTab.values.map((tab) => tab.screen).toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // unselectedLabelStyle: TextTheme.of(
        //   context,
        // ).bodyMedium?.copyWith(color: ColorScheme.of(context).onSurface),
        // selectedLabelStyle: TextTheme.of(
        //   context,
        // ).bodyMedium?.copyWith(color: ColorScheme.of(context).onSurface),
        onTap: (value) {
          setHomeTab(HomeTab.values[value]);
        },
        currentIndex: _tab.index,
        items: [
          ...HomeTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: Icon(tab.icon),
              label: tab.displayName,
              backgroundColor: ColorScheme.of(context).onSurface,
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
    displayName: 'History',
    icon: Icons.auto_graph_rounded,
  ),
  medicine(
    screen: GraphView(),
    displayName: 'Medicine',
    icon: Icons.medication,
  ),
  systemInfo(screen: InformationView(), displayName: 'Home', icon: Icons.home),
  timeline(
    screen: GraphView(),
    displayName: 'Timeline',
    icon: Icons.timeline_rounded,
  ),
  settings(
    screen: SettingsView(),
    displayName: 'Settings',
    icon: Icons.settings,
  );

  final Widget screen;
  final String displayName;
  final IconData icon;
  const HomeTab({
    required this.screen,
    required this.displayName,
    required this.icon,
  });

  static HomeTab homeTabFromIndex(int index) {
    return HomeTab.values[index];
  }
}
