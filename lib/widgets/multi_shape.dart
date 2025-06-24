import 'package:flutter/material.dart';

class ResizableLShape extends StatefulWidget {
  @override
  State<ResizableLShape> createState() => _ResizableLShapeState();
}

class _ResizableLShapeState extends State<ResizableLShape> {
  double width = 200;
  double height = 200;

  Offset position = Offset(50, 50);

  void updateSize(DragUpdateDetails details, bool isWidth) {
    setState(() {
      if (isWidth) {
        width += details.delta.dx;
      } else {
        height += details.delta.dy;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                position += details.delta;
              });
            },
            child: CustomPaint(
              size: Size(width, height),
              painter: LShapePainter(),
              child: Container(), // important to allow painting
            ),
          ),
        ),
        // Resize handles (right)
        Positioned(
          left: position.dx + width - 10,
          top: position.dy + height / 2 - 10,
          child: GestureDetector(
            onPanUpdate: (details) => updateSize(details, true),
            child: ResizeHandle(),
          ),
        ),
        // Resize handles (bottom)
        Positioned(
          left: position.dx + width / 2 - 10,
          top: position.dy + height - 10,
          child: GestureDetector(
            onPanUpdate: (details) => updateSize(details, false),
            child: ResizeHandle(),
          ),
        ),
      ],
    );
  }
}

class LShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 3, 0)
      ..lineTo(size.width / 3, size.height * 2 / 3)
      ..lineTo(size.width, size.height * 2 / 3)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant LShapePainter oldDelegate) => false;
}

class ResizeHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}