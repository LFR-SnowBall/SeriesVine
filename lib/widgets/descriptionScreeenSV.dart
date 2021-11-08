import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:seriesvine/widgets/homeScreeenSV.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeriesVineDescriptionScreen extends StatelessWidget {
  final String img;
  final String titulo;
  final String publicacion;
  final String company;
  final String Description;
  final List<dynamic> episodes;

  const SeriesVineDescriptionScreen(
      {Key? key,
      required this.img,
      required this.titulo,
      required this.publicacion,
      required this.company,
      required this.Description,
      required this.episodes})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          height: height / 3,
          width: width / 2,
          child: Image.network(this.img, fit: BoxFit.fill),
        ),
        Material(
          color: Colors.red.withOpacity(0),
          child: Container(
            child: ListTile(
              key: key,
              contentPadding: EdgeInsets.all(5.0),
              title: Text(
                this.titulo,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 25),
              ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(
                          this.publicacion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(
                          this.company,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: [
              Material(
                color: Colors.red.withOpacity(0),
                child: Container(
                  child: Text(removeAllHtmlTags(this.Description),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        Material(
            color: Colors.red.withOpacity(0),
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                "${this.episodes.length.toString()} Episodes",
                style: TextStyle(fontSize: 18),
              ),
            )),
        Divider(
          color: Colors.white,
        ),
        Flexible(
          flex: 2,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: this.episodes.length,
            itemBuilder: (BuildContext context, int index) => Card(
                color: Colors.red.withOpacity(0),
                clipBehavior: Clip.antiAlias,
                elevation: 8.0,
                margin: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebView(
                              initialUrl: this.episodes[index]
                                  ['site_detail_url'],
                            )));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.network(this.img),
                        ),
                        Material(
                          child: Text(this.episodes[index]['name']),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Material(
                            child: Text(
                                "Episode: ${this.episodes[index]['episode_number']}"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Material(
                            child: Text(
                              "${this.company}",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle),
                          child: Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
