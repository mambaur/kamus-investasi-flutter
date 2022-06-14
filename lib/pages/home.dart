import 'package:flutter/material.dart';
import 'package:kamus_investasi/pages/text_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(top: (size.height * 0.2) + 50),
                itemBuilder: (context, index) {
                  return Container(
                    width: size.width,
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            'A',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (builder) {
                                    return TextDetailScreen();
                                  }));
                                },
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'OJK',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Otoritas Jasa Keuangan'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'ROA',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Return On Asset'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Container(
              color: Color.fromRGBO(65, 83, 181, 1),
              width: size.width,
              height: size.height * 0.2,
              child: Center(
                child: Text(
                  'Kamus Investasi',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: size.height * 0.16, left: 15, right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade700),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.grey.shade700),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            hintText: 'Cari Keyword Investasimu..'),
                      ),
                    ),
                    Icon(Icons.close, color: Colors.grey.shade700),
                  ]),
            ),

            // Icon(
            //   Iconsax.box_search,
            //   color: Colors.red,
            //   size: 100,
            // )
          ],
        ),
      ),
    );
  }
}
