import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/app.dart';

class MenuSelect extends StatefulWidget {
  final void Function(HomeTab tab) callback;
  const MenuSelect({super.key, required this.callback});

  @override
  State<MenuSelect> createState() => _MenuSelectState();
}

class _MenuSelectState extends State<MenuSelect> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 60,
            maxHeight: MediaQuery.heightOf(context),
          ),
          color: ColorScheme.of(context).inversePrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (HomeTab tab in HomeTab.values)
                if (tab.index != HomeTab.values.last.index)
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: IconButton(
                      onPressed: () {
                        widget.callback(tab);
                      },
                      icon: tab.icon,
                    ),
                  ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: 60,
            width: 60,
            child: IconButton(
              onPressed: () {
                widget.callback(
                  HomeTab.homeTabFromIndex(HomeTab.values.last.index),
                );
              },
              icon: HomeTab.homeTabFromIndex(HomeTab.values.last.index).icon,
            ),
          ),
        ),
      ],
    );
  }
}
