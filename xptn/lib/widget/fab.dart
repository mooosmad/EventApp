import 'package:flutter/material.dart';

class TabBarMaterialWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const TabBarMaterialWidget({
    required this.index,
    required this.onChangedTab,
    Key? key,
  }) : super(key: key);

  @override
  _TabBarMaterialWidgetState createState() => _TabBarMaterialWidgetState();
}

class _TabBarMaterialWidgetState extends State<TabBarMaterialWidget> {
  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
      opacity: 0,
      child: IconButton(icon: Icon(Icons.no_cell), onPressed: null),
    );

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      elevation: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTabItem(
            index: 0,
            icon: const Icon(Icons.calendar_today),
          ),
          buildTabItem(
            index: 1,
            icon: const Icon(Icons.search),
          ),
          placeholder,
          buildTabItem(
            index: 2,
            icon: const Icon(Icons.space_dashboard),
          ),
          buildTabItem(
            index: 3,
            icon: const Icon(Icons.manage_accounts),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
  }) {
    final isSelected = index == widget.index;

    return IconTheme(
      data: IconThemeData(
        size: double.maxFinite,
        color: isSelected ? Colors.lime.shade600 : Colors.white,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () => widget.onChangedTab(index),
      ),
    );
  }
}
