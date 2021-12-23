import 'dart:ffi';

import 'package:creoittask/model/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, this.index, this.data, this.months}) : super(key: key);

  List<ComicModel>? data;
  var index;
  var months;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  PageController controller = PageController();

  var initalPage,currentPageValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initalPage = widget.index;
      currentPageValue = widget.index.toDouble();
      controller  =       PageController(viewportFraction: 1, keepPage: true,initialPage: initalPage);
    });


  }

  void changePageViewPostion(var index , var type) {
    if(controller != null){
      var jumpPosition = 0.0;
      if(type == "next" ){
        jumpPosition = index + 1.0;
        controller.jumpTo(jumpPosition);
      }else if(type == "old"){
        jumpPosition = index - 1.0;
        controller.jumpTo(jumpPosition);
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
      floatingActionButton: floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // AppBar
  buildAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Detail page",
        style: GoogleFonts.pattaya(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 25),
      ),
      elevation: 0.0,
    );
  }

  //Page Body
  buildBody() {
    return PageView.builder(
        controller: controller,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 4),
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          image:
                              NetworkImage(widget.data![index].img.toString()),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                ),
                ExpansionTile(

                    title: Text(
                      widget.data![index].title.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                  subtitle: Text(
                    'Published On : ${widget.data![index].day} - ${widget.months[int.parse(widget.data![index].month.toString()) - 1]} - ${widget.data![index].year}',
                    style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                  children: [
                     Text(
                      widget.data![index].transcript.toString().replaceAll("[", "").replaceAll("]", "").replaceAll("{", "").replaceAll("}", ""),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),




                // Padding(padding: const EdgeInsets.only(left: 2,right: 2),child: Divider(),)
              ],
            ),
          );
        });
  }


  //floating button
  floatingButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              currentPageValue = currentPageValue - 1.0;
              if(currentPageValue > 0){
                controller.animateToPage(currentPageValue.toInt(), curve: Curves.decelerate, duration: Duration(milliseconds: 300));
              }
            });
          },
          child: Container(
              height: 40,
              width: 120,
              decoration: const BoxDecoration(
                  color: Colors.black ,

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Previous',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              )),
        ),
        SizedBox(width: 3,),
        GestureDetector(
          onTap: () {
            setState(() {
              currentPageValue = currentPageValue + 1.0;
              if(currentPageValue < 20){
                controller.animateToPage(currentPageValue.toInt(), curve: Curves.decelerate, duration: Duration(milliseconds: 300));
              }
            });
          },
          child: Container(
              width: 120,
              height: 40,
              decoration:const BoxDecoration(
                  color:
                   Colors.black,

                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Align(
                alignment: Alignment.center,
                child: Text('next',
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16)),
              )),
        ),
      ],
    );
  }
}
