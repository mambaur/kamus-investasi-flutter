import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kamus_investasi/pages/bookmark.dart';
import 'package:kamus_investasi/pages/feedback.dart';
import 'package:kamus_investasi/pages/history.dart';
import 'package:kamus_investasi/pages/home.dart';
import 'package:kamus_investasi/utils/datasets.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamus Indonesia',
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert(
        showIgnore: false,
        showLater: false,
        showReleaseNotes: false,
        upgrader: Upgrader(),
        child: const MyHomePage(),
      ),
      // home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool isInitializeDatasets = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future setupDatasets() async {
    DataSets dataSets = DataSets();
    bool result = await dataSets.initDictionaries();
    setState(() {
      isInitializeDatasets = result;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BookmarkScreen(),
    HistoryScreen(),
    FeedbackScreen(),
  ];

  @override
  void initState() {
    setupDatasets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isInitializeDatasets
        ? Scaffold(
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              backgroundColor: Colors.white,
              selectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: const Icon(Iconsax.home)),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: const Icon(Iconsax.bookmark)),
                  label: 'Bookmark',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: const Icon(Iconsax.repeat_circle)),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: const Icon(Iconsax.message)),
                  label: 'Feedback',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color.fromRGBO(65, 83, 181, 1),
              onTap: _onItemTapped,
            ),
          )
        : Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Color.fromRGBO(65, 83, 181, 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Loading 👾',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800)),
                const SizedBox(
                  height: 5,
                ),
                const Text('Mohon tunggu...',
                    style: TextStyle(color: Colors.grey)),
              ],
            )),
          );
  }
}
