import 'package:flutter/material.dart';
import 'domain/entities/tab_info.dart';

class RecipeInfoToggle extends StatefulWidget {
  const RecipeInfoToggle({super.key, this.tabs = const []});
  
  final List<TabInfo> tabs;

  @override
  State<RecipeInfoToggle> createState() => _RecipeInfoToggleState();
}

class _RecipeInfoToggleState extends State<RecipeInfoToggle> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Find initial selected tab
    if (widget.tabs.isNotEmpty) {
      selectedIndex = widget.tabs.indexWhere((tab) => tab.active);
      if (selectedIndex == -1) selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ["Ingredient", "Procedure"];

    
    return SizedBox(
      height: 33, // row height
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return SizedBox(
            width: 150,
            height: 33,
            child: ChoiceChip(
              label: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isSelected ? Colors.white : const Color(0xFF129575),
                  ),
                ),
              ),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selectedIndex = index;
                });
              },
              backgroundColor: isSelected
                  ? const Color(0xFF129575)
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.transparent),
              ),
              padding: EdgeInsets.zero,
              materialTapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
            ),
          );
        },
      ),
    );
  }
}
