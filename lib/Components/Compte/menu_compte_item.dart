import 'package:flutter/material.dart';

class MenuCompteItem extends StatelessWidget {
  const MenuCompteItem({
    this.icon,
    this.label,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                child: Image.asset(icon),
              ),
              title: Text(
                label,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        onTap: onPressed);
  }
}
