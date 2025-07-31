import 'package:flutter/material.dart';

class MutipleSelectPage extends StatefulWidget {
  const MutipleSelectPage({super.key});

  @override
  State<MutipleSelectPage> createState() => _MutipleSelectPageState();
}

class _MutipleSelectPageState extends State<MutipleSelectPage> {
  final List<String> itemsMutiple = ['Cash', 'ABA', 'ACLIDA'];
  final Set<String> selectedItems = {};

  void toggleSelection(String item) {
    setState(() {
      // debugPrint('toggle :${selectedItems.contains(item)}');

      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Select Page')),
      body: Column(
        children: [
          //
          Wrap(
            runSpacing: 8.0,
            spacing: 8.0,
            direction: Axis.horizontal,
            children: itemsMutiple.map((item) {
              return MySelectableContainer(
                title: item,
                isSelected: selectedItems.contains(item),
                onTap: () => toggleSelection(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

//
class MySelectableContainer extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const MySelectableContainer({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: isSelected
              // ignore: deprecated_member_use
              ? Colors.blueAccent.withOpacity(0.3)
              : Colors.amberAccent,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.blue[800] : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
