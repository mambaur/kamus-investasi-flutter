import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TextDetailScreen extends StatefulWidget {
  const TextDetailScreen({Key? key}) : super(key: key);

  @override
  State<TextDetailScreen> createState() => _TextDetailScreenState();
}

class _TextDetailScreenState extends State<TextDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OJK'),
        centerTitle: true,
        elevation: 0,
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Iconsax.share)),
          IconButton(onPressed: () {}, icon: Icon(Iconsax.sound))
        ],
        backgroundColor: Color.fromRGBO(65, 83, 181, 1),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('OJK',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.grey.shade800)),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.star,
                    color: Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: Colors.grey.shade400,
                  ),
                )
              ],
            ),
            Text('Otoritas Jasa Keuangan',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: 40,
                    color: Colors.grey.shade800)),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(65, 83, 181, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('Investasi',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('Saham',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('Trading',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      )),
                ),
              ],
            ),
            // Divider(
            //   color: Color.fromRGBO(65, 83, 181, 1),
            // ),
            SizedBox(
              height: 15,
            ),
            Text('Definitions',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey.shade800)),
            SizedBox(
              height: 15,
            ),
            Text(
                'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    // fontSize: 16,
                    color: Colors.grey.shade800)),

            SizedBox(
              height: 15,
            ),
            Text('Related',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey.shade800)),
            SizedBox(
              height: 15,
            ),
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  margin: EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('ROA'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  margin: EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('OJK'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  margin: EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('Robot Trading'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  margin: EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('Reksadana'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  margin: EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Text('Pasar Uang'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
