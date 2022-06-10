import 'package:flutter/material.dart';
import 'package:popi/Components/Compte/compte_info_container.dart';
import 'package:popi/Components/dropdown_field_container.dart';
import 'package:popi/Components/submit_button.dart';
import 'package:popi/Components/text_field_container.dart';
import 'package:popi/Screens/Account_Creation/account_diplomas_screen.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/api/AuthProvider.dart';
import 'package:popi/data/form_data.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:popi/shared_preferences/UserPreferences.dart';
import 'package:provider/provider.dart';

import '../../../constraints.dart';

class NewAccountForm extends StatefulWidget {
  NewAccountForm({this.compte});

  final Compte compte;

  @override
  _NewAccountFormState createState() => new _NewAccountFormState();
}

class _NewAccountFormState extends State<NewAccountForm> {
  // formKey will look at the current state of the form
  // and check if all fields are validated
  static final _formKey = GlobalKey<FormState>();

  // Text editing controllers will let us retrieve field values
  TextEditingController etEmail = new TextEditingController();
  TextEditingController etMotDePasse = new TextEditingController();
  TextEditingController etNom = new TextEditingController();
  TextEditingController etAnneeNaissance = new TextEditingController();
  TextEditingController etFonctionAutre = new TextEditingController();
  TextEditingController etInstitutionAutre = new TextEditingController();
  TextEditingController etNomInstitution = new TextEditingController();
  TextEditingController etCodePostal = new TextEditingController();
  TextEditingController etVille = new TextEditingController();
  TextEditingController etPays = new TextEditingController();

  // variables with the dropdown field values
  String _selectedSexe = '';
  String _selectedFonction = '';
  String _selectedInstituteType = '';

  @override
  void initState() {
    // If compte exists
    if (widget.compte != null) {
      etNomInstitution.text = widget.compte.nomInstitution;
      etCodePostal.text = widget.compte.codePostal;
      etVille.text = widget.compte.ville;
      etPays.text = widget.compte.pays;

      // Check if fonction of user is autre
      for (var i = 0; i < fonctionList.length; i++) {
        if (widget.compte.fonction == fonctionList[i].value) {
          _selectedFonction = widget.compte.fonction;
          break;
        }
      }
      if (_selectedFonction == '') {
        _selectedFonction = "fonctionAutre";
        etFonctionAutre.text = widget.compte.fonction;
      }

      // Check if type d'institution is autre
      for (var i = 0; i < instituteTypeList.length; i++) {
        if (widget.compte.typeInstitution == instituteTypeList[i].value) {
          _selectedInstituteType = widget.compte.typeInstitution;
          break;
        }
      }
      if (_selectedInstituteType == '') {
        _selectedInstituteType = "institutionAutre";
        etInstitutionAutre.text = widget.compte.typeInstitution;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: new Column(children: getFormWidget()));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();
    // Email
    if (widget.compte == null) {
      formWidget.add(TextFormFieldContainer(
        controller: etEmail,
        text: "Email",
        hidden: false,
        lightBackground: widget.compte != null,
        inputType: TextInputType.emailAddress,
      ));
      formWidget.add(SizedBox(height: 30));

      // Mot de passe
      formWidget.add(TextFormFieldContainer(
        controller: etMotDePasse,
        text: "Mot de passe",
        hidden: true,
        lightBackground: widget.compte != null,
        inputType: TextInputType.text,
      ));
      formWidget.add(SizedBox(height: 30));

      // Nom
      formWidget.add(TextFormFieldContainer(
        controller: etNom,
        text: "Nom",
        hidden: false,
        lightBackground: widget.compte != null,
        inputType: TextInputType.text,
      ));
      formWidget.add(SizedBox(height: 30));

      // Sexe
      formWidget.add(addSexeDropdown());
      formWidget.add(SizedBox(height: 30));

      // Année de naissance
      formWidget.add(TextFormFieldContainer(
        controller: etAnneeNaissance,
        text: "Année de naissance",
        hidden: false,
        lightBackground: widget.compte != null,
        inputType: TextInputType.number,
      ));
      formWidget.add(SizedBox(height: 30));
    } else {
      // Display compte nom
      formWidget.add(
        CompteInfoContainer(
          label: "Nom",
          value: widget.compte.nom,
        ),
      );

      // Display compte sexe
      formWidget.add(
        CompteInfoContainer(
          label: "Sexe",
          value: int.parse(widget.compte.sexe) == 0 ? "Masculin" : "Féminin",
        ),
      );

      // Display compte Année de naissance
      formWidget.add(
        CompteInfoContainer(
          label: "Année de naissance",
          value: widget.compte.anneeNaissance,
        ),
      );
    }

    // Fonction
    formWidget.add(addFonctionDropdown());
    formWidget.add(SizedBox(height: 30));

    // Si fonction == autre, à préciser
    formWidget.add(addFonctionTextfield());

    // Type institution
    formWidget.add(addInstitutionDropdown());
    formWidget.add(SizedBox(height: 30));

    // Si institutionType == autre, à préciser
    formWidget.add(addInstitutionTextfield());

    // Nom de l'institution
    formWidget.add(TextFormFieldContainer(
      controller: etNomInstitution,
      text: "Nom de l'institution",
      hidden: false,
      lightBackground: widget.compte != null,
      inputType: TextInputType.text,
    ));
    formWidget.add(SizedBox(height: 30));

    // Code postal
    formWidget.add(TextFormFieldContainer(
      controller: etCodePostal,
      text: "Code postal de l'institution",
      hidden: false,
      lightBackground: widget.compte != null,
      inputType: TextInputType.number,
    ));
    formWidget.add(SizedBox(height: 30));

    // Ville
    formWidget.add(TextFormFieldContainer(
        controller: etVille,
        text: "Ville",
        hidden: false,
        lightBackground: widget.compte != null,
        inputType: TextInputType.text));
    formWidget.add(SizedBox(height: 30));

    // Pays
    formWidget.add(TextFormFieldContainer(
      controller: etPays,
      text: "Pays",
      hidden: false,
      lightBackground: widget.compte != null,
      inputType: TextInputType.text,
    ));
    formWidget.add(SizedBox(height: 30));

    // Suivant ou Valider
    if (widget.compte != null) {
      formWidget.add(SubmitButton(
        text: "VALIDER",
        lightBackground: widget.compte != null,
        onPressed: (() {
          handleUpdateButton();
        }),
      ));
    } else {
      formWidget.add(SubmitButton(
        text: "SUIVANT",
        lightBackground: widget.compte != null,
        onPressed: (() {
          handleSubmitButton();
        }),
      ));
    }

    formWidget.add(SizedBox(height: 30));

    return formWidget;
  }

  // Form methods

  addSexeDropdown() {
    return DropdownFieldContainer(
        lightBackground: widget.compte != null,
        child: DropdownButtonFormField(
            dropdownColor: widget.compte != null ? Colors.white : kPrimaryColor,
            decoration: dropdownUnderline,
            isExpanded: true,
            style: widget.compte != null
                ? dropdownLabelLightBackground
                : dropdownTextStyle,
            items: sexeList,
            value: 'label',
            onChanged: (value) {
              setState(() {
                _selectedSexe = value;
              });
            },
            validator: (value) =>
                value == 'label' ? 'Champ obligatoire' : null));
  }

  addFonctionDropdown() {
    return DropdownFieldContainer(
        lightBackground: widget.compte != null,
        child: DropdownButtonFormField(
            dropdownColor: widget.compte != null ? Colors.white : kPrimaryColor,
            decoration: dropdownUnderline,
            isExpanded: true,
            style: widget.compte != null
                ? dropdownLabelLightBackground
                : dropdownTextStyle,
            items: fonctionList,
            value: widget.compte != null ? _selectedFonction : 'label',
            hint: Text('Fonction'),
            onChanged: (value) {
              setState(() {
                _selectedFonction = value;
              });
            },
            validator: (value) =>
                value == 'label' ? 'Champ obligatoire' : null));
  }

  addFonctionTextfield() {
    return Visibility(
        visible: _selectedFonction == 'fonctionAutre',
        child: Column(children: [
          TextFormFieldContainer(
            controller: etFonctionAutre,
            text: "Précisez la fonction",
            lightBackground: widget.compte != null,
            hidden: false,
            inputType: TextInputType.text,
          ),
          SizedBox(
            height: 30,
          )
        ]));
  }

  addInstitutionDropdown() {
    return DropdownFieldContainer(
        lightBackground: widget.compte != null ? true : false,
        child: DropdownButtonFormField(
            dropdownColor: widget.compte != null ? Colors.white : kPrimaryColor,
            decoration: dropdownUnderline,
            isExpanded: true,
            style: widget.compte != null
                ? dropdownLabelLightBackground
                : dropdownTextStyle,
            items: instituteTypeList,
            value: widget.compte != null ? _selectedInstituteType : 'label',
            onChanged: (value) {
              setState(() {
                _selectedInstituteType = value;
              });
            },
            validator: (value) =>
                value == 'label' ? 'Champ obligatoire' : null));
  }

  addInstitutionTextfield() {
    return Visibility(
        visible: _selectedInstituteType == 'institutionAutre',
        child: Column(children: [
          TextFormFieldContainer(
            controller: etInstitutionAutre,
            text: "Précisez le type d'institution",
            hidden: false,
            lightBackground: widget.compte != null,
            inputType: TextInputType.text,
          ),
          SizedBox(
            height: 30,
          )
        ]));
  }

  handleUpdateButton() {
    if (_formKey.currentState.validate()) {
      //Update account
      Compte compte = new Compte(
          id: widget.compte.id,
          email: widget.compte.email,
          motDePasse: widget.compte.motDePasse,
          nom: widget.compte.nom,
          sexe: widget.compte.sexe,
          anneeNaissance: widget.compte.anneeNaissance,
          fonction: _selectedFonction == 'fonctionAutre'
              ? etFonctionAutre.text.trim()
              : _selectedFonction,
          typeInstitution: _selectedInstituteType == 'institutionAutre'
              ? etInstitutionAutre.text.trim()
              : _selectedInstituteType,
          nomInstitution: etNomInstitution.text.trim(),
          codePostal: etCodePostal.text.trim(),
          ville: etVille.text.trim(),
          pays: etPays.text.trim());

      // Set account diplomes
      compte.setDiplomes(widget.compte.diplomes);

      // new compte that we will set
      /*Compte updatedCompte = new Compte(
        id: widget.compte.id,
        motDePasse: widget.compte.motDePasse,
        email: compte.id,
        nom: compte.nom,
        sexe: compte.sexe,
        anneeNaissance: compte.anneeNaissance,
        fonction: compte.fonction,
        typeInstitution: compte.typeInstitution,
        nomInstitution: compte.nomInstitution,
        codePostal: compte.codePostal,
        ville: compte.ville,
        pays: compte.pays,
      );*/

      //updatedCompte.setDiplomes(widget.compte.diplomes);

      // Update account with new values
      AuthProvider().editCompte(compte).then((result) => {
            if (result['status'])
              {
                // Set new compte
                Provider.of<UserProvider>(context, listen: false)
                    .setUser(compte),
                UserPreferences().saveUser(compte),

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Succès"),
                        content: Text(accountUpdatedMessage),
                        actions: [
                          FlatButton(
                            child: Text("Retour aux informations"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }),
              }
            else
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Erreur"),
                        content: Text(alertFailMessage),
                        actions: [
                          FlatButton(
                            child: Text("Retour aux informations"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }),
              }
          });
    }
  }

  handleSubmitButton() {
    if (_formKey.currentState.validate()) {
      //Verify if email is taken
      AuthProvider().verifyEmail(etEmail.text).then((result) {
        if (result['status'] == "OK") {
          if (result['taken'] == false) {
            //Create account
            Compte newAccount = new Compte(
                email: etEmail.text.trim(),
                motDePasse: etMotDePasse.text.trim(),
                nom: etNom.text.trim(),
                sexe: _selectedSexe,
                anneeNaissance: etAnneeNaissance.text,
                fonction: _selectedFonction == 'fonctionAutre'
                    ? etFonctionAutre.text.trim()
                    : _selectedFonction,
                typeInstitution: _selectedInstituteType == 'institutionAutre'
                    ? etInstitutionAutre.text.trim()
                    : _selectedInstituteType,
                nomInstitution: etNomInstitution.text.trim(),
                codePostal: etCodePostal.text.trim(),
                ville: etVille.text.trim(),
                pays: etPays.text.trim());

            //Continue to diplomes screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountDiplomasScreen(
                  compte: newAccount,
                ),
              ),
            );
          } else {
            //Email already exists

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Attention"),
                    content: Text(emailExistsMessage),
                    actions: [
                      FlatButton(
                        child: Text("Fermer"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }
        } else {
          //Server timeout
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Attention"),
                  content: Text(registerFailedMessage),
                  actions: [
                    FlatButton(
                      child: Text("Fermer"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      });
    } else {
      //Some fields are not valid
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Attention"),
              content: Text(invalidFieldsMessage),
              actions: [
                FlatButton(
                  child: Text("Fermer"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
