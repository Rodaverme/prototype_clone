// ignore_for_file: library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

abstract class Shape {
  int x;
  int y;
  String color;

  Shape(this.x, this.y, this.color);

  Shape clone();
}

class Rectangle extends Shape {
  int width;
  int height;

  Rectangle(int x, int y, String color, this.width, this.height)
      : super(x, y, color);

  @override
  Rectangle clone() {
    return Rectangle(x, y, color, width, height);
  }
}


class Circle extends Shape {
  int radius;

  Circle(int x, int y, String color, this.radius) : super(x, y, color);

  @override
  Circle clone() {
    return Circle(x, y, color, radius);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text('FORMAS CLONADAS'),
            centerTitle: true,
            elevation: 0),
        body: const ShapeScreen(),
      ),
    );
  }
}

class ShapeScreen extends StatefulWidget {
  const ShapeScreen({super.key});

  @override
  _ShapeScreenState createState() => _ShapeScreenState();
}

class _ShapeScreenState extends State<ShapeScreen> {
  final List<Shape> shapes = [];

  @override
  void initState() {
    super.initState();

    shapes.add(Circle(100, 100, "", 150));
    shapes.add(Rectangle(0, 0, "red", 50, 30));
    shapes.add(Rectangle(50, 50, "green", 80, 40));
  }

  void cloneShape(int index) {
    setState(() {
      shapes.add(shapes[index].clone());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shapes.length,
      itemBuilder: (context, index) {
        return ShapeWidget(
          shapes[index],
          onClonePressed: () => cloneShape(index),
        );
      },
    );
  }
}

class ShapeWidget extends StatelessWidget {
  final Shape shape;
  final VoidCallback onClonePressed;

  const ShapeWidget(this.shape, {super.key, required this.onClonePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: shape is Circle
              ? BounceInDown(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: (shape as Circle).x.toDouble(),
                      height: (shape as Circle).y.toDouble(),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: getColor()),
                    ),
                  ),
              )
              : BounceInUp(
                child: Container(
                    width: (shape as Rectangle).width.toDouble(),
                    height: (shape as Rectangle).height.toDouble(),
                    color: getColor(),
                  ),
              ),
        ),
        SlideInRight(
          child: IconButton(
            icon: const Icon(Icons.add_circle,color: Colors.blueAccent, size: 35),
            onPressed: onClonePressed,
          ),
        ),
      ],
    );
  }

  Color getColor() {
    switch (shape.color) {
      case "red":
        return Colors.red;
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
