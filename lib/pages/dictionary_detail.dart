import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kamus_investasi/databases/bookmarks/bookmark_repository.dart';
import 'package:kamus_investasi/databases/dictionaries/dictionary_repository.dart';
import 'package:kamus_investasi/databases/histories/history_repository.dart';
import 'package:kamus_investasi/models/bookmark_model.dart';
import 'package:kamus_investasi/models/dictionary_model.dart';
import 'package:kamus_investasi/models/history_model.dart';
import 'package:kamus_investasi/utils/date_instance.dart';
import 'package:share_plus/share_plus.dart';

enum StatusAd { initial, loaded }

class DictionaryDetailScreen extends StatefulWidget {
  final int? id;
  final bool? isSetHistory;
  const DictionaryDetailScreen({super.key, this.id, this.isSetHistory});

  @override
  State<DictionaryDetailScreen> createState() => _DictionaryDetailScreenState();
}

class _DictionaryDetailScreenState extends State<DictionaryDetailScreen> {
  final DictionaryRepository _dictionaryRepo = DictionaryRepository();
  final BookmarkRepository _bookmarkRepo = BookmarkRepository();
  final HistoryRepository _historyRepo = HistoryRepository();
  InterstitialAd? _interstitialAd;

  BannerAd? myBanner;

  StatusAd statusAd = StatusAd.initial;

  BannerAdListener listener() => BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          if (kDebugMode) {
            print('Ad Loaded.');
          }
          setState(() {
            statusAd = StatusAd.loaded;
          });
        },
      );

  DictionaryModel? dictionaryModel;
  bool isBookmark = false;
  List<DictionaryModel> listRelated = [];

  Future getDictionary() async {
    DictionaryModel? data = await _dictionaryRepo.find(widget.id!);
    BookmarkModel? bookmark = await _bookmarkRepo.hasDictionary(widget.id!);
    if (bookmark != null) {
      isBookmark = true;
    }
    if (data != null) {
      dictionaryModel = data;
      getRelated();
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

  Future<void> getRelated() async {
    List<DictionaryModel>? data =
        await _dictionaryRepo.related(dictionaryModel?.category ?? '');
    if (data != null) {
      setState(() {
        listRelated = data;
      });
    }
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
        "updated_at": DateInstance.timestamp()
      });
    }
    // await _historyRepo.getAll();
  }

  @override
  void initState() {
    getDictionary();
    addHistory();

    myBanner = BannerAd(
      // test banner
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      //
      adUnitId: 'ca-app-pub-2465007971338713/1073462187',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener(),
    );
    myBanner!.load();

    InterstitialAd.load(
        adUnitId: kDebugMode
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-2465007971338713/6674449865',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));

    super.initState();
  }

  @override
  void dispose() {
    myBanner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dictionaryModel != null ? dictionaryModel!.title! : ''),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(65, 83, 181, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                    if (_interstitialAd != null) {
                      await _interstitialAd!.show();
                    }

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
                  onPressed: () async {
                    if (_interstitialAd != null) {
                      await _interstitialAd!.show();
                    }

                    Share.share(
                        '${dictionaryModel?.title} \n\n${dictionaryModel?.description}\n\nDownload aplikasi Kamus Investasi Sekarang!\nhttps://bit.ly/kamus-investasi',
                        subject: dictionaryModel?.title ?? '');
                  },
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
                : const SizedBox(),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        color: dictionaryModel?.category == 'investasi'
                            ? const Color.fromRGBO(65, 83, 181, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Text('Investasi',
                        style: TextStyle(
                          color: dictionaryModel?.category == 'investasi'
                              ? Colors.white
                              : Colors.grey.shade800,
                        )),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        color: dictionaryModel?.category == 'trading'
                            ? const Color.fromRGBO(65, 83, 181, 1)
                            : Colors.white,
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Text('Trading',
                        style: TextStyle(
                          color: dictionaryModel?.category == 'trading'
                              ? Colors.white
                              : Colors.grey.shade800,
                        )),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        color: dictionaryModel?.category == 'kripto'
                            ? const Color.fromRGBO(65, 83, 181, 1)
                            : Colors.white,
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Text('Kripto',
                        style: TextStyle(
                          color: dictionaryModel?.category == 'kripto'
                              ? Colors.white
                              : Colors.grey.shade800,
                        )),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                        color: dictionaryModel?.category == 'saham'
                            ? const Color.fromRGBO(65, 83, 181, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Text('Saham',
                        style: TextStyle(
                          color: dictionaryModel?.category == 'saham'
                              ? Colors.white
                              : Colors.grey.shade800,
                        )),
                  ),
                ],
              ),
            ),
            // Divider(
            //   color: Color.fromRGBO(65, 83, 181, 1),
            // ),
            statusAd == StatusAd.loaded
                ? Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    alignment: Alignment.center,
                    width: myBanner!.size.width.toDouble(),
                    height: myBanner!.size.height.toDouble(),
                    child: AdWidget(ad: myBanner!),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('Deskripsi',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey.shade800)),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                    onTap: () {
                      FlutterClipboard.copy(dictionaryModel?.description ?? '')
                          .then((value) {
                        Fluttertoast.showToast(msg: 'Deskripsi telah disalin');
                      });
                    },
                    child: const Icon(Iconsax.copy, color: Colors.grey))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            dictionaryModel?.description != null
                ? Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(dictionaryModel!.description ?? '',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            // fontSize: 16,
                            height: 1.5,
                            color: Colors.grey.shade800)),
                  )
                : const SizedBox(),
            Text('Kata Terkait',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey.shade800)),
            const SizedBox(
              height: 15,
            ),
            Wrap(
              children: [
                for (DictionaryModel item in listRelated)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return DictionaryDetailScreen(
                          id: item.id,
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: Text(item.title ?? ''),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
