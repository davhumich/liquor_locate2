/*

main.dart

Contains the main function to run the application and
the tab controller so we can switch between tabs.

*/


// Flutter tool packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:liquor_locate2/ListView/list_view.dart';
import 'package:liquor_locate2/Onboarding/auth_gate.dart';
import 'package:liquor_locate2/firebase_options.dart';
import 'package:liquor_locate2/CartView/cart_view.dart';

// External packages from pub.dev
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// Internal files located in this directory
import 'package:liquor_locate2/MapView/map_view.dart';
import 'package:liquor_locate2/ProfileView/profile_view.dart';

import 'package:firebase_core/firebase_core.dart';


// Main function to run the application
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const LiquorLocate());
}

// First widget on the tree (Stateless because its data will never change)
class LiquorLocate extends StatelessWidget {
  const LiquorLocate({super.key});

// The actual widget that creates the interface
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiquorLocate',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Theme data (if we want to change font or color scheme for entire app, this is where we do it)
      theme: ThemeData(
        fontFamily: 'SFPro',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthGate()
    );
  }
}

// Widget for building tab controller at bottom of screen, also manages switching between tabs
// (Stateful because its data will change i.e. the "tabs")
class TabView extends StatefulWidget {
  const TabView({super.key, required this.title, required this.currentUserId});
  final String title;
  final String currentUserId;

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = widget.currentUserId;
  }


  // The controller to manage everything involved with the TabView
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      hideNavigationBarWhenKeyboardShows: true,
      controller: _controller,
      screens: [
        MapView(userId: userId),
        ListScreen(userId: userId,),
        const CartView(),
        ProfileView(userId: userId, profilePic: const AssetImage('lib/assets/fireball.png'), headerImage: const AssetImage(''), username: 'davidh', firstName: 'David', lastName: 'Harrell',),
      ],
      items: _navBarsItems(), // Referenced below
      navBarStyle: NavBarStyle.style1,
      decoration: NavBarDecoration(
        border: const Border(
          top: BorderSide(width: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }

// This is a list of the tab bar items that the tab view uses to create the bottom tab
List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.map),
      title: ("Map"),
      activeColorPrimary: const Color(0xFF7D6756),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.list_dash),
      title: ("Stores"),
      activeColorPrimary: const Color(0xFF7D6756),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.shopping_cart),
      title: ("My Cart"),
      activeColorPrimary: const Color(0xFF7D6756),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.profile_circled),
      title: ("Profile"),
      activeColorPrimary: const Color(0xFF7D6756),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
}
