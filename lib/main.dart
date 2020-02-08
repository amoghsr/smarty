import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smarty/auth.dart';
import 'package:smarty/home.dart';
import 'package:smarty/leaderboard.dart';
import 'package:smarty/security.dart';
import 'package:smarty/login.dart';

import 'Statistics.dart';
import 'constants.dart';

import 'package:provider/provider.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ChangeNotifierProvider<AuthService>(
        // Helps to look for AuthService in the entire widget tree
        child: MyApp(),
        create: (BuildContext context) {
          return AuthService();
        },
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Specifying UI theme in themeData
      theme: ThemeData(
        brightness: Brightness.dark, // UI style set to dark
//        primaryColor: Colors.lightGreen[500],
        accentColor: Colors.lightGreenAccent, // Setting accent colour
        fontFamily: 'Montserrat', // Setting the apps' font family to Montserrat
        platform: TargetPlatform.iOS, // Setting UI style to iOS
      ),

      home: FutureBuilder(
        // Getting the Provider, and call the getUser method
        future: Provider.of<AuthService>(context).getUser(),
        // Wait for the future to resolve and render the appropriate
        // Load the widget for Home page or LoginPage
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Log any errors to the console
            if (snapshot.error != null) {
              print("Error");
              return Text(snapshot.error.toString());
            }
            // Redirect to the Home() page
            return snapshot.hasData ? MyNavigationBar() : LoginPage();
          } else {
            // Show the loading indicator
            return LoadingCircle();
          }
        },
      ),
//      home: MyNavigationBar(),
    );
  }
}

// Navigation bar class, contains all the elements needed for the nav bar.
class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {

  // currentIndex stores the number of the current page the user is on. The underscore means this variable is private.
  int _currentIndex = 0;

  // A list of the pages (Widgets) the user can navigate to using the nav bar
  final List<Widget> _children = [
    Home(),
    Statistics(),
    Security(),
    Leaderboard(),
  ];

  // This function changes the value of the variable currentIndex when a nav bar item is tapped.
  // Called when one of the nav bar items is tapped.
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final controller = PageController(
    initialPage: 1,
  );

  Widget build(BuildContext context) {

    // The SafeArea widget stores the components inside it inside a safe area which keeps components well inside the viewport
    return SafeArea(

      // The scaffold widget holds all the necessary UI components just like <html> tag in HTML does
      child: Scaffold(

        // The body object where the widgets stored in the children list are created on tap based on the current index value
        body: _children[_currentIndex],

        // The nav bar is created using this object. The inbuilt BottomNavigationBar class is used.
        bottomNavigationBar: BottomNavigationBar(

          onTap: onTappedBar, // onTap changes the current page index when a nav bar item is tapped.
          currentIndex: _currentIndex, // Current index stores the value of the current page
          type: BottomNavigationBarType.fixed, // Defines the layout and behavior of the nav bar

          // Navigation bar items are stored in this list items[]. I will comment one item since all follow the same code.
          items: [
            // Creating a new nav bar item
            BottomNavigationBarItem(

              // Nav bar item's icon
              icon: Icon(
                AntDesign.home,
                // Set a semantic label which is useful for screen-readers or accessibility
                semanticLabel: 'Home page',
              ),
              // Title for the nav bar item
              title: Text(
                'Home',
                // Setting a text style for the nav bar item. This is stored in constants.dart
                style: kNavigationBarTextStyle,
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                FontAwesome5.chart_bar,
                semanticLabel: 'Energy Statistics',
              ),
              title: Text(
                'Stats',
                style: kNavigationBarTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesome5.eye,
                semanticLabel: 'Home Security',
              ),
              title: Text(
                'Security',
                style: kNavigationBarTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                AntDesign.up,
                semanticLabel: 'Community Leaderboard',
              ),
              title: Text(
                'Leaderboard',
                style: kNavigationBarTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// A loading animation that uses material components shown after the user initiates the login process.
class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
