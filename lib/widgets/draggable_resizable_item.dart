import 'dart:convert';
import 'package:flutter/material.dart';

class DraggableResizableItem extends StatefulWidget {
  final Widget? child;
  final String? content;
  final double initialTop;
  final double initialLeft;
  final double initialWidth;
  final double initialHeight;

  const DraggableResizableItem({
    Key? key,
    this.child,
    this.content,
    this.initialTop = 100,
    this.initialLeft = 100,
    this.initialWidth = 150,
    this.initialHeight = 150,
  }) : super(key: key);

  @override
  DraggableResizableItemState createState() => DraggableResizableItemState();
}

class DraggableResizableItemState extends State<DraggableResizableItem> {
  late double top;
  late double left;
  late double width;
  late double height;
  bool resizing = false;

  @override
  void initState() {
    super.initState();
    top = widget.initialTop;
    left = widget.initialLeft;
    width = widget.initialWidth;
    height = widget.initialHeight;
  }

  double getTop() => top;
  double getLeft() => left;
  double getWidth() => width;
  double getHeight() => height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (!resizing) {
            setState(() {
              top += details.delta.dy;
              left += details.delta.dx;
            });
          }
        },
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                color: Colors.white,
              ),
              child: widget.content != null
                  ? Text(widget.content!)
                  : widget.child,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onPanStart: (_) => resizing = true,
                onPanEnd: (_) => resizing = false,
                onPanUpdate: (details) {
                  setState(() {
                    width += details.delta.dx;
                    height += details.delta.dy;
                  });
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(Icons.open_in_full, size: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
