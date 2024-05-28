import 'package:flutter/material.dart';

class StickyLabelNotifier extends ChangeNotifier {
  String dropdownValue = 'Team 1'; // Initially set the dropdown value

  // Method to update the dropdown value
  void updateDropdownValue(String newValue) {
    dropdownValue = newValue;
    notifyListeners(); // Notify listeners to rebuild
  }
}

class StickyLabelHeader extends SliverPersistentHeaderDelegate {
  final StickyLabelNotifier notifier;

  StickyLabelHeader(this.notifier);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      child: DropdownButton<String>(
        value: notifier.dropdownValue,
        onChanged: (String? newValue) {
          if (newValue != null) {
            notifier.updateDropdownValue(newValue);
          }
        },
        items: <String>[
          'Team 1',
          'Web Project',
          'GameDev Shooter',
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return notifier.dropdownValue !=
        (oldDelegate as StickyLabelHeader).notifier.dropdownValue;
  }
}
