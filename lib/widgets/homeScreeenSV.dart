import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SeriesVinehomeScreen extends StatelessWidget {
  final String img;
  final String titulo;
  final String publicacion;
  final String company;
  final Function onpressed;
  final int episodes;

  const SeriesVinehomeScreen(
      {Key? key,
      required this.img,
      required this.titulo,
      required this.publicacion,
      required this.company,
      required this.onpressed,
      required this.episodes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(0.1),
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.blueAccent.withOpacity(0.2),
      elevation: 8.0,
      margin: EdgeInsets.only(bottom: 25.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextButton(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    color: Colors.white,
                    child: FractionallySizedBox(
                      widthFactor: 1.2,
                      heightFactor: 1.1,
                      child: _imageSerie(img),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ListTile(
                contentPadding: EdgeInsets.all(5.0),
                title: Text(
                  titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _style,
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5.0),
                          child: Text(
                            company,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: _style2,
                          ),
                        ),
                        Container(
                          width: 30,
                          margin: EdgeInsets.all(5.0),
                          child: Text(
                            publicacion,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: _style2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5.0),
                          child: Text(
                            '$episodes Episodes',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _style2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        onPressed: () => this.onpressed(),
      ),
    );
  }

  Widget _imageSerie(String img) {
    return Image.network(img, fit: BoxFit.values.first);
  }
}

final _style = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final _style2 = TextStyle(
  fontSize: 10,
);
