import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerPrescription extends StatelessWidget {
  BannerPrescription({
    this.pathologie,
    this.type,
  });

  final String pathologie;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey)),
      ),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          Text(
            pathologie,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            type,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
