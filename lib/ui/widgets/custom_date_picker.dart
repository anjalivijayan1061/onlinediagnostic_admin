import 'package:flutter/material.dart';

import 'custom_card.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onPick;
  final DateTime? defaultDate;
  final Function()? onClear;
  const CustomDatePicker({
    super.key,
    required this.onPick,
    this.defaultDate,
    this.onClear,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: () async {
        pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.defaultDate ?? DateTime.now(),
          firstDate: DateTime.now().subtract(
            const Duration(days: 365 * 100),
          ),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          widget.onPick(pickedDate!);
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Row(
          children: [
            Text(
              pickedDate != null
                  ? DateFormat('dd/MM/yyyy').format(pickedDate!)
                  : widget.defaultDate != null
                      ? DateFormat('dd/MM/yyyy').format(widget.defaultDate!)
                      : 'Select Date',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: pickedDate != null ? Colors.black54 : Colors.black45,
                    fontWeight: pickedDate != null
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
            ),
            if (widget.onClear != null && pickedDate != null)
              InkWell(
                onTap: () {
                  pickedDate = null;
                  setState(() {});
                  widget.onClear!();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.clear,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
