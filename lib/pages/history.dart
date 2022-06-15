import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kamus_investasi/pages/dictionary_detail.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Riwayat'),
          backgroundColor: Color.fromRGBO(65, 83, 181, 1),
          centerTitle: true,
          elevation: 0,
          actions: [IconButton(onPressed: () {}, icon: Icon(Iconsax.trash))],
        ),
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
            // controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: Icon(
                  Iconsax.info_circle,
                  color: Colors.grey.shade800,
                ),
                floating: true,
                title: Text(
                  'Kamus yang Terakhir Kamu Lihat',
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                ),
                centerTitle: true,
                elevation: 0.5,
                backgroundColor: Colors.white,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 10),
                  itemCount: 10,
                  shrinkWrap: true,
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
                              '28 Juli 2022',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 5),
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
                                      return DictionaryDetailScreen();
                                    }));
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'OJK',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('Otoritas Jasa Keuangan'),
                                  trailing: Icon(
                                    Iconsax.close_circle,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'ROA',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('Return On Asset'),
                                  trailing: Icon(
                                    Iconsax.close_circle,
                                    color: Colors.grey.shade300,
                                  ),
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
