import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:popi/models/Cas.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/models/Prescription.dart';

import 'AppUrl.dart';

enum Status {
  notFetching,
  fetching,
  fetched,
  failed,
  updating,
  updated,
  deleting,
  deleted,
}

class DataProvider with ChangeNotifier {
  // Fetching pathologies status
  Status _fetchingStatus = Status.notFetching;
  Status get fetchingStatus => _fetchingStatus;

  // Fetching prescriptions status
  Status _fetchingPrescriptionsStatus = Status.notFetching;
  Status get fetchingPrescriptionsStatus => _fetchingPrescriptionsStatus;

  // Fetching cas status
  Status _fetchingCasStatus = Status.notFetching;
  Status get fetchingCasStatus => _fetchingCasStatus;

  // Update status
  Status _updateStatus = Status.updating;
  Status get updateStatus => _updateStatus;

  // Delete status
  Status _deleteStatus = Status.deleting;
  Status get deleteStatus => _deleteStatus;

  Future<Map<String, dynamic>> getPathologies() async {
    var result;

    final Response response = await get(AppUrl.getPathologies);

    // Notify listeners that pathologies are being fetched
    _fetchingStatus = Status.fetching;
    notifyListeners();

    if (response.statusCode == 200) {
      // Notify listeners that pathologies are fetched
      _fetchingStatus = Status.fetched;
      notifyListeners();

      // List of pathologies in Json
      List pathologiesMap = jsonDecode(response.body);

      // New list of converted pathologies
      List<Pathologie> pathologies = new List<Pathologie>();

      for (int i = 0; i < pathologiesMap.length; i++) {
        // From Json to Pathologie
        Pathologie pathologie = Pathologie.fromJson(pathologiesMap[i]);
        pathologies.add(pathologie);
      }

      result = {'status': true, 'pathologies': pathologies};
    } else {
      // Notify listeners that fetching failed
      _fetchingStatus = Status.failed;
      notifyListeners();

      result = {'status': false, 'message': 'Error fetching prescriptions'};
    }
    return result;
  }

  Future<Map<String, dynamic>> getPrescriptions() async {
    var result;

    final Response response = await get(AppUrl.getPrescriptions);

    // Notify listeners that prescriptions are being fetched
    _fetchingPrescriptionsStatus = Status.fetching;
    notifyListeners();

    if (response.statusCode == 200) {
      // Notify listeners that prescriptions are fetched
      _fetchingPrescriptionsStatus = Status.fetched;
      notifyListeners();

      // List of pathologies in Json
      List prescriptionsMap = jsonDecode(response.body);

      // New list of converted prescriptions
      List<Prescription> prescriptions = new List<Prescription>();

      for (int i = 0; i < prescriptionsMap.length; i++) {
        // From Json to Prescription
        Prescription prescription = Prescription.fromJson(prescriptionsMap[i]);
        prescriptions.add(prescription);
      }

      result = {'status': true, 'prescriptions': prescriptions};
    } else {
      // Notify listeners that fetching failed
      _fetchingPrescriptionsStatus = Status.failed;
      notifyListeners();

      result = {'status': false, 'message': 'Error fetching pathologies'};
    }
    return result;
  }

  Future<Map<String, dynamic>> getCas(String id) async {
    var result;

    final Response response = await get(AppUrl.getUser + id + "/patients");

    // Notify listeners that prescriptions are being fetched
    _fetchingCasStatus = Status.fetching;
    notifyListeners();

    if (response.statusCode == 200) {
      // Notify listeners that prescriptions are fetched
      _fetchingCasStatus = Status.fetched;
      notifyListeners();

      // List of pathologies in Json
      List casMap = jsonDecode(response.body);

      // New list of converted prescriptions
      List<Cas> listCas = new List<Cas>();

      for (int i = 0; i < casMap.length; i++) {
        // From Json to Prescription
        Cas cas = Cas.fromJson(casMap[i]);
        listCas.add(cas);
      }

      result = {'status': true, 'cas': listCas};
    } else {
      // Notify listeners that fetching failed
      _fetchingCasStatus = Status.failed;
      notifyListeners();

      result = {'status': false, 'message': 'Error fetching cas'};
    }
    return result;
  }

  Future<Map<String, dynamic>> addCas(Cas cas) async {
    var result;

    final Response response = await post(AppUrl.addCas, body: jsonEncode(cas));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      // return true = add successful | false = failed
      result = {'status': responseMap['statut']};
    } else {
      result = {'status': false};
    }

    return result;
  }

  Future<Map<String, dynamic>> updateCas(Cas cas) async {
    var result;

    final Response response = await put(
        AppUrl.updateOrDeleteCas + cas.id.toString(),
        body: jsonEncode(cas));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      // return true = add successful | false = failed
      result = {'status': responseMap['statut']};
    } else {
      result = {'status': false};
    }

    return result;
  }

  Future<Map<String, dynamic>> deleteCas(int casId) async {
    var result;

    final Response response =
        await delete(AppUrl.updateOrDeleteCas + casId.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      // return true = add successful | false = failed
      result = {'status': responseMap['statut']};
    } else {
      result = {'status': false};
    }

    return result;
  }
}
