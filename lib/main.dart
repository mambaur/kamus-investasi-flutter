import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kamus_investasi/pages/bookmark.dart';
import 'package:kamus_investasi/pages/history.dart';
import 'package:kamus_investasi/pages/home.dart';
import 'package:kamus_investasi/utils/datasets.dart';
// import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataSets dataSets = DataSets();
  await dataSets.initDictionaries();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamus Indonesia',
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: UpgradeAlert(
      //   upgrader: Upgrader(
      //       showIgnore: false, showLater: false, showReleaseNotes: false),
      //   child: const MyHomePage(),
      // ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BookmarkScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedFontSize: 12,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
                margin: EdgeInsets.only(bottom: 3), child: Icon(Iconsax.home)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Icon(Iconsax.bookmark)),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Icon(Iconsax.repeat_circle)),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(65, 83, 181, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
