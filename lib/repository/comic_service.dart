import 'dart:convert';
import 'package:creoittask/model/comic_model.dart';
import 'package:http/http.dart' as http;

Future<List<ComicModel>?> getComicData() async {
  List<ComicModel> comicData = [];

  for (var i = 1; i < 21; i++) {
    var url = "https://xkcd.com/$i/info.0.json";
    var response = await http.get(Uri.parse(url));
    String responeBody = response.body;

    if (response.statusCode == 200) {
      var comic = comicModelFromJson(responeBody);
      if (!comicData.contains(comic)) {
        comicData.add(comic);
      }
    }
  }

  return comicData;
}
