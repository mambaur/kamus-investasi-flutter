import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kamus_investasi/databases/bookmarks/bookmark_repository.dart';
import 'package:kamus_investasi/databases/dictionaries/dictionary_repository.dart';
import 'package:kamus_investasi/databases/histories/history_repository.dart';
import 'package:kamus_investasi/models/bookmark_model.dart';
import 'package:kamus_investasi/models/dictionary_model.dart';
import 'package:kamus_investasi/models/history_model.dart';
import 'package:kamus_investasi/utils/date_instance.dart';

class DictionaryDetailScreen extends StatefulWidget {
  final int? id;
  final bool? isSetHistory;
  const DictionaryDetailScreen({Key? key, this.id, this.isSetHistory})
      : super(key: key);

  @override
  State<DictionaryDetailScreen> createState() => _DictionaryDetailScreenState();
}

class _DictionaryDetailScreenState extends State<DictionaryDetailScreen> {
  final DictionaryRepository _dictionaryRepo = DictionaryRepository();
  final BookmarkRepository _bookmarkRepo = BookmarkRepository();
  final HistoryRepository _historyRepo = HistoryRepository();

  DictionaryModel? dictionaryModel;
  bool isBookmark = false;

  Future getDictionary() async {
    DictionaryModel? data = await _dictionaryRepo.find(widget.id!);
    BookmarkModel? bookmark = await _bookmarkRepo.hasDictionary(widget.id!);
    if (bookmark != null) {
      isBookmark = true;
    }
    if (data != null) {
      dictionaryModel = data;
    }
    setState(() {});
  }

  Future addBookmark() async {
    await _bookmarkRepo.insert({
      "dictionary_id": widget.id,
      "created_at": DateInstance.timestamp(),
      "updated_at": DateInstance.timestamp()
    });
    isBookmark = true;
    setState(() {});
  }

  Future deleteBookmark() async {
    await _bookmarkRepo.delete(widget.id!);
    isBookmark = false;
    setState(() {});
  }

  Future addHistory() async {
    HistoryModel? history =
        await _historyRepo.findByDate(widget.id!, DateInstance.timestamp());
    if (history == null &&
        widget.isSetHistory != null &&
        widget.isSetHistory == true) {
      await _historyRepo.insert({
        "dictionary_id": widget.id,
        "created_at": DateInstance.commonDate(),
        "updated_at": DateInstance.commonDate()
      });
    }
    // await _historyRepo.getAll();
  }

  @override
  void initState() {
    print(widget.id!);
    getDictionary();
    addHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dictionaryModel != null ? dictionaryModel!.title! : ''),
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
                  child: Text(
                      dictionaryModel != null ? dictionaryModel!.title! : '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.grey.shade800)),
                ),
                IconButton(
                  onPressed: () async {
                    if (isBookmark) {
                      await deleteBookmark();
                    } else {
                      await addBookmark();
                    }
                  },
                  icon: Icon(
                    Icons.star,
                    color: isBookmark
                        ? Colors.yellow.shade700
                        : Colors.grey.shade400,
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
            dictionaryModel?.fullTitle != null
                ? Text(dictionaryModel!.fullTitle ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // fontSize: 40,
                        color: Colors.grey.shade800))
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
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
            ),
            // Divider(
            //   color: Color.fromRGBO(65, 83, 181, 1),
            // ),
            SizedBox(
              height: 15,
            ),
            Text('Deskripsi',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey.shade800)),
            SizedBox(
              height: 15,
            ),
            dictionaryModel?.description != null
                ? Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(dictionaryModel!.description ?? '',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            // fontSize: 16,
                            color: Colors.grey.shade800)),
                  )
                : Container(),
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
