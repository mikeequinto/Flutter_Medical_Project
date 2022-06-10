class AppUrl {
  static const String baseURL = "https://gabana.ch/popi/";

  // Login and registration
  static const String login = baseURL + "login";
  static const String register = baseURL + "comptes";
  static const String verifyEmail = baseURL + "email_existe";
  static const String forgotPassword = baseURL + "generer_passe";
  static const String getUser = baseURL + "comptes/";
  static const String updateUser = baseURL + "comptes/";

  // Password recovery
  static const String recoverPassword = baseURL + "generer_passe/";

  // Pathologies
  static const String getPathologies = baseURL + "pathologies";

  // Prescriptions
  static const String getPrescriptions = baseURL + "prescriptions";

  // Patients / Cas
  static const String addCas = baseURL + "patients";
  static const String updateOrDeleteCas = baseURL + "patients/";
}
