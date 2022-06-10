import 'package:flutter/material.dart';

class MenuPathologiesItem extends StatelessWidget {
  const MenuPathologiesItem({
    this.label,
    this.shadow,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String label;
  final bool shadow;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: ListTile(
                      title:
                          Text(label, style: TextStyle(color: Colors.black))))),
          decoration: this.shadow
              ? BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.grey[300], blurRadius: 5.0)
                ])
              : null,
          margin: EdgeInsets.only(top: 8.0),
        ),
        onTap: onPressed);
  }
}
