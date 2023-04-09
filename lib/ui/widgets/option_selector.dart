import 'package:flutter/material.dart';

import 'custom_radio_button.dart';

class OptionSelector extends StatefulWidget {
  final Function(bool) onSelect;
  final bool selected;
  const OptionSelector({
    super.key,
    required this.onSelect,
    this.selected = false,
  });

  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  late bool _selected;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomRadioButton(
            onPressed: () {
              widget.onSelect(!_selected);
              _selected = !_selected;
              setState(() {});
            },
            label: 'Yes',
            isSelected: _selected,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomRadioButton(
            onPressed: () {
              widget.onSelect(!_selected);
              _selected = !_selected;
              setState(() {});
            },
            label: 'No',
            isSelected: !_selected,
          ),
        ),
      ],
    );
  }
}
