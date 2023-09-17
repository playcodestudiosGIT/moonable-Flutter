import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:moonable/settings/constants.dart';

// ignore: must_be_immutable
class CustomMenuItem extends StatefulWidget {
  final String text;
  final Function onPressed;
  final int delay;
  final double width;
  final double padding;
  IconData? icon;

  CustomMenuItem({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.padding,
    this.delay = 0,
    this.icon,
  }) : super(key: key);

  @override
  CustomMenuItemState createState() => CustomMenuItemState();
}

class CustomMenuItemState extends State<CustomMenuItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      from: 10,
      duration: const Duration(milliseconds: 150),
      delay: Duration(milliseconds: widget.delay),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: GestureDetector(
          onTap: () => widget.onPressed(),
          child: AnimatedContainer(
            color: (isHover) ? primary(context).withOpacity(0.3) : bgColor(context),
            alignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            height: 50,
            child: Row(
              children: [
                const SizedBox(width: 15),
                if (widget.icon != null) Icon(widget.icon),
                Padding(
                  padding: EdgeInsets.only(left: widget.padding),
                  child: Text(widget.text, style: text14BodyM(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
