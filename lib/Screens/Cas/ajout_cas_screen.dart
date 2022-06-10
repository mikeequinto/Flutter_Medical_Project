import 'package:flutter/material.dart';
import 'package:popi/Components/screen_title_banner.dart';
import 'CasComponents/ajout_form.dart';

class AjoutCasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(

            // Set width and height of container
            width: double.infinity, // As big as the parent
            height: size.height,

            //Background color
            color: Colors.white,
            child: Column(
              children: [
                ScreenTitleBanner(title: "Ajouter un cas"),
                // Ajout cas steps
                Expanded(
                  child: AjoutForm(),
                )
              ],
            )));
  }
}
