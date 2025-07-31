import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final double width;
  final double height;

  const CustomDropdown({
    super.key,
    required this.options,
    this.initialValue,
    required this.onChanged,
    this.width = 200,
    this.height = 150,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedOption;
  late LayerLink _layerLink;
  OverlayEntry? _overlayEntry;
  bool isDropdownOpen = false;

  final double itemHeight = 48.0;
  final double maxDropdownHeight = 150.0;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue ?? 'Select an option';
    _layerLink = LayerLink();
  }

  void _toggleDropdown() {
    if (isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;

    // Available space below the dropdown button with margin
    final availableHeightBelow = screenHeight - offset.dy - size.height - 20;

    // Height needed to show all options
    final totalOptionsHeight = widget.options.length * itemHeight;

    // Choose height: all options or max available height
    final dropdownHeight = totalOptionsHeight <= availableHeightBelow
        ? totalOptionsHeight.toDouble()
        : availableHeightBelow.toDouble();

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: widget.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: dropdownHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: totalOptionsHeight > dropdownHeight
                    ? const ClampingScrollPhysics() // Scroll if needed
                    : const NeverScrollableScrollPhysics(), // No scroll if fits
                children: widget.options.map((option) {
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                      });
                      widget.onChanged(option);
                      _closeDropdown();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          width: widget.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  selectedOption,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Icon(
                isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
