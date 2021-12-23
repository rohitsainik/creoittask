import 'package:creoittask/model/comic_model.dart';
import 'package:creoittask/repository/comic_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;
  List<ComicModel> comicData = [];
  var months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  void initState() {
    getData();
    super.initState();
    isLoading = true;
    getData();
  }

  // Get data
  getData() async {
    var data = await getComicData();
    setState(() {
      comicData.addAll(data!);
    });
    print("data is " + comicData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppbar(),
        body: Scaffold(
          body: buidBody(),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  // AppBar
  buildAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        widget.title,
        style: GoogleFonts.pattaya(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 25),
      ),
      elevation: 0.0,
    );
  }

  //App body
  buidBody() {
    return Stack(
      children: [
        ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: comicData.length,
            itemBuilder: (_, index) {
              return index == comicData.length
                  ? _buildProgressIndicator()
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailPage(
                                      data: comicData,
                                      index: index,
                                  months: months,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 4),
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          comicData[index].img.toString()),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width,
                            ),
                            Text(
                              'Published On : ${comicData[index].day} - ${months[int.parse(comicData[index].month.toString()) - 1]} - ${comicData[index].year}',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              comicData[index].title.toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.justify,
                            ),

                            // Padding(padding: const EdgeInsets.only(left: 2,right: 2),child: Divider(),)
                          ],
                        ),
                      ),
                    );
            }),
        comicData.length != 0
            ? Container()
            : Center(child: CircularProgressIndicator())
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
