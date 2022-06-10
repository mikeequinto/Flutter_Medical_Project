import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:popi/api/AppUrl.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/shared_preferences/UserPreferences.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  Updating,
  DoneUpdating,
  LoggedOut,
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, String> loginData = {'email': email, 'passe': password};

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(AppUrl.login, body: jsonEncode(loginData));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      var loginSuccessful = responseMap['statut'];

      if (loginSuccessful) {
        var userId = responseMap['message'];

        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {
          'status': true,
          'message': 'Connexion réussie',
          'userId': userId
        };
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        // Login unsuccessful
        result = {'status': false, 'message': 'wrong credentials'};
      }
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      // Server connection failed
      result = {'status': false, 'message': 'server timeout'};
    }

    return result;
  }

  Future<Map<String, dynamic>> getInfoCompte(id) async {
    var result;

    final Response response = await get(AppUrl.getUser + id);

    if (response.statusCode == 200) {
      Map<String, dynamic> compteMap = jsonDecode(response.body);

      Compte authUser = Compte.fromJson(compteMap);
      UserPreferences().saveUser(authUser);
      result = {'status': true, 'compte': authUser};
    } else {
      result = {'status': false, 'message': 'User not found'};
    }
    return result;
  }

  Future<Map<String, dynamic>> register(Compte compte) async {
    var result;

    _registeredInStatus = Status.Registering;
    notifyListeners();

    final Response response =
        await post(AppUrl.register, body: jsonEncode(compte));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      // return true = register successful | false = failed
      result = {'status': responseMap['statut']};
    } else {
      result = {'status': false};
    }

    return result;
  }

  Future<Map<String, dynamic>> verifyEmail(String email) async {
    var result;

    final Map<String, dynamic> data = {
      'email': email,
      'id': "-1" // Nouveau compte : -1 | compte en cours de modif : 1
    };

    final Response response =
        await post(AppUrl.verifyEmail, body: jsonEncode(data));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      return result = {'status': 'OK', 'taken': responseMap['statut']};
    } else {
      result = {
        'status': 'NOT OK',
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> editCompte(Compte compte) async {
    var result;

    _registeredInStatus = Status.Updating;
    notifyListeners();

    final Response response =
        await put(AppUrl.updateUser + compte.id, body: jsonEncode(compte));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      // return true = register successful | false = failed
      result = {'status': responseMap['statut']};
    } else {
      result = {'status': false};
    }

    return result;
  }

  Future<Map<String, dynamic>> generatePassword(String email) async {
    var result;

    final Map<String, dynamic> data = {
      'email': email,
    };

    final Response response =
        await post(AppUrl.recoverPassword, body: jsonEncode(data));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      // return true = register successful | false = failed
      result = {'status': responseMap['statut']};
    } else {
      result = {'status': false};
    }

    return result;
  }
}
