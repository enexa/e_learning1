import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';

import 'package:e_learning/controller/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homewillbe extends StatefulWidget {
  const Homewillbe({super.key});

  @override
  State<Homewillbe> createState() => _HomewillbeState();
}

class _HomewillbeState extends State<Homewillbe> {
  int _activepageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const ImageIcon(
              AssetImage('assets/menu-bar.png'),
              size: 24,
              color: Color.fromARGB(255, 29, 82, 31),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        
        centerTitle: true,
        title: const Text(
          'Bahir Dar University',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black
            
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _activepageIndex = index;
          });
        },
        children: [
          pageDetails[0]['pageName'],
          pageDetails[1]['pageName'],
          pageDetails[2]['pageName'],
          pageDetails[3]['pageName'],
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _activepageIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
        height: 50.0,
        items: const <Widget>[
        Icon(Icons.home,size: 20),
        Icon(Icons.search,size: 20),
        Icon(Icons.play_arrow,size: 20),
        Icon(Icons.message,size: 20),
        Icon(Icons.person,size: 20),
        
          // Icon(Icons.perm_identity, size: 20),
        ],
        backgroundColor: Colors.blue,
      ),
      drawer: SafeArea(
        child: Drawer(
          width: 230,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const UserAccountsDrawerHeader(
                accountEmail: Text("enex@gmail.com"),
                accountName: Text("enex"),
                decoration: BoxDecoration(
                    ),
                currentAccountPicture: CircleAvatar(
                  radius: 100.0,
                 child: Icon(Icons.person),
                ),
                // otherAccountsPictures: const [],
              ),
              ListTile(
                title: const Text('home'),
                leading: const Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 29, 82, 31),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Color.fromARGB(255, 29, 82, 31),
                ),
              ),
              ListTile(
                title: const Text('developer'),
                leading: const Icon(
                  Icons.developer_mode,
                  color: Color.fromARGB(255, 29, 82, 31),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Color.fromARGB(255, 29, 82, 31),
                ),
              ),
              ListTile(
                title: const Text('help'),
                leading: const Icon(
                  Icons.help,
                  color: Color.fromARGB(255, 29, 82, 31),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Color.fromARGB(255, 29, 82, 31),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
