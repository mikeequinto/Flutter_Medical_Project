import 'package:flutter/material.dart';
import 'package:popi/Components/Pathologies/pathologie_prescriptions.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/models/Prescription.dart';
import 'package:provider/provider.dart';

import '../../constraints.dart';

class PathologiePrescriptionsScreen extends StatelessWidget {
  const PathologiePrescriptionsScreen({
    this.pathologie,
  });

  final Pathologie pathologie;

  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    // Get all prescriptions
    List<Prescription> allPrescriptions =
        FetchMethods().getPrescriptions(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(

            // Set width and height of container
            width: double.infinity, // As big as the parent
            height: size.height,

            //Background color
            color: kBackgroundColor,
            child: ListView(
              children: [
                // Screen title
                Container(
                  color: kPrimaryColor,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(pathologie.pathologie, style: screenTitle),
                      )),
                ),
                // Screen body
                Column(children: [
                  Consumer<DataProvider>(
                      builder: (context, dataProvider, child) {
                    if (dataProvider.fetchingPrescriptionsStatus ==
                        Status.fetched) {
                      // Get prescriptions for specific pathologie
                      List<Prescription> prescriptions = FetchMethods()
                          .getPrescriptionsByPathologie(
                              allPrescriptions, pathologie.pathologie);
                      // When pathologies are fetched
                      return PathologiePrescriptions(
                        prescriptions: prescriptions,
                      );
                    } else {
                      // While pathologies are being fetched
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[CircularProgressIndicator()]);
                    }
                  })
                ]),
              ],
            )));
  }
}
