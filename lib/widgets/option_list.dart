import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets_movil/widgets/widgets.dart';

class optionList extends StatelessWidget {
  const optionList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 10.0
      ),
      child: Row(
        children: <Widget>[
          CircleButton(true, Icons.turned_in_not, 20.0, Color.fromRGBO(255, 255, 255, 1)),
          CircleButton(true, Icons.card_travel, 20.0, Color.fromRGBO(255, 255, 255, 0.6)),
          CircleButton(false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1)),
          CircleButton(true, Icons.mail_outline, 20.0, Color.fromRGBO(255, 255, 255, 0.6)),
          CircleButton(true, Icons.person, 20.0, Color.fromRGBO(255, 255, 255, 0.6))  
        ],
      ),
    );
  }
}