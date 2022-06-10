import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popi/Components/large_button.dart';
import 'package:popi/Screens/Cas/ajout_cas_screen.dart';
import 'package:popi/Screens/Cas/menu_cas_screen.dart';
import 'package:popi/Screens/Pathologies/menu_pathologies_screen.dart';
import 'package:popi/Screens/Compte/menu_compte_screen.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/constraints.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Variables for bottom bar navigation
  int _selectedIndex = 0;
  String _title = _listScreens[0];

  // Bottom bar options
  static const List<String> _listScreens = <String>[
    "Cas",
    "Pathologies",
    "Compte",
  ];

  // Bottom bar screens
  static List<Widget> _widgetOptions;

  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    // Init pages
    _widgetOptions = <Widget>[
      MenuCas(),
      MenuPathologies(),
      MenuCompte(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        // Set width and height of container
        width: double.infinity, // As big as the parent
        height: size.height,
        color: kBackgroundColor,
        child: Column(
          children: [
            // Top Bar indicating screen name
            Container(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(_title, style: screenTitle),
                ),
              ),
            ),
            Expanded(
              child: _selectedIndex == 0
                  ? Stack(
                      children: [
                        ListView(children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: _widgetOptions.elementAt(_selectedIndex),
                          ),
                        ]),
                        new Positioned(
                          left: size.width * 10 / 100,
                          bottom: 20.0,
                          child: LargeButton(
                            text: "AJOUTER UN CAS",
                            color: kPrimaryColor,
                            size: 80,
                            onPressed: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AjoutCasScreen()),
                              ).then(onGoBack);
                            }),
                          ),
                        ),
                      ],
                    )
                  : ListView(children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ]),
            ),
          ],
        ),
      ),

      // Bottom bar display
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // Cas
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/stethoscope.png')),
              label: 'Cas'),
          //Pathologies
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/medical-note.png')),
              label: 'Pathologies'),
          // Compte
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/user.png')),
              label: 'Compte')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _title = _listScreens[index];
    });
  }
}
