import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kamus_investasi/pages/text_detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Bookmark'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromRGBO(65, 83, 181, 1),
          actions: [IconButton(onPressed: () {}, icon: Icon(Iconsax.star_15))],
        ),
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
            // controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // SliverAppBar(
              //   automaticallyImplyLeading: false,
              //   leading: Icon(
              //     Iconsax.info_circle,
              //     color: Colors.grey.shade800,
              //   ),
              //   floating: true,
              //   title: Text(
              //     'Kamus yang Terakhir Kamu Lihat',
              //     style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
              //   ),
              //   centerTitle: true,
              //   elevation: 0.5,
              //   backgroundColor: Colors.white,
              // ),
              SliverList(
                  delegate: SliverChildListDelegate([
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 15),
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: size.width,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   margin: EdgeInsets.only(left: 5),
                          //   child: Text(
                          //     '28 Juli 2022',
                          //     style:
                          //         TextStyle(color: Colors.grey, fontSize: 12),
                          //   ),
                          // ),
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
                                  leading: Icon(Iconsax.star),
                                  title: Text(
                                    'OJK',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('Otoritas Jasa Keuangan'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ]))
            ]));
  }
}
