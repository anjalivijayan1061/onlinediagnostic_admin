import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final Color? color;
  final Color hoverBorderColor;
  final double borderRadius;
  final Function()? onPressed;

  const CustomCard({
    super.key,
    required this.child,
    this.onPressed,
    this.color = Colors.white,
    this.hoverBorderColor = Colors.blue,
    this.borderRadius = 0,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.color,
            border: Border.all(
              width: 1,
              color: _isHovering ? widget.hoverBorderColor : Colors.grey[300]!,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
