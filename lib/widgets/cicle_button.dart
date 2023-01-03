import 'package:flutter/material.dart';



class CircleButton extends StatelessWidget {
  bool mini;
  IconData icon;
  double iconSize;
  Color color;

  CircleButton(this.mini, this.icon, this.iconSize, this.color, {super.key});

  @override
  Widget build(BuildContext context) {    
    return Expanded(
      child: FloatingActionButton(
        backgroundColor: color,
        // mini: widget.mini,
        onPressed: () {          
          
        },
        child: Icon(
          icon,
          size: iconSize,
          color: const Color(0xFF4268D3),
        ),
      )
    );
  }
}