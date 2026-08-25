import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:system_mapper/user_interface/screens/system_info.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('System Mapper'),
      ),
      body: LazyLoadIndexedStack(
        preloadIndexes: [HomeTab.values.indexOf(HomeTab.systemInfo)],
        index: HomeTab.values.indexOf(HomeTab.systemInfo),
        children: HomeTab.values.map((tab) => tab.getScreen()).toList(),
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
  systemInfo(screen: SystemInformationView()),
  map(screen: Placeholder()),
  settings(screen: Placeholder());

  final Widget screen;
  const HomeTab({required this.screen});

  Widget getScreen() {
    return screen;
  }
}
