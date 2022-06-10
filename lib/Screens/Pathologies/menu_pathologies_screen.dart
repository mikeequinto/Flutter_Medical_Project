import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:popi/Components/Pathologies/pathologies_list.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:provider/provider.dart';

class MenuPathologies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HashMap<String, List<Pathologie>> listPathologies =
        FetchMethods().getPathologies(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<DataProvider>(builder: (context, pathologies, child) {
            if (pathologies.fetchingStatus == Status.fetched) {
              // When pathologies are fetched
              return ListPathologies(pathologies: listPathologies);
            } else {
              // While pathologies are being fetched
              return CircularProgressIndicator();
            }
          })
        ]);
  }
}
