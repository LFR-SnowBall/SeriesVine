import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriesvine/bloc/seriesvine/seriesvine_bloc.dart';
import 'package:seriesvine/widgets/SV_buttons.dart';
import 'package:seriesvine/widgets/homeScreeenSV.dart';
import 'package:seriesvine/widgets/name.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class SeriesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final seriesVineBloc = BlocProvider.of<SeriesVineBloc>(context);
    final seriesListBloc = BlocProvider.of<SeriesListBloc>(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return FutureBuilder(
        future: _seriesList(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return SliverToBoxAdapter(
                child: Center(
                  child: Text('Error de conexión'),
                ),
              );

              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Scaffold(
                    body: SliverToBoxAdapter(
                  child: Center(
                    child: Text('Ocurrió un error'),
                  ),
                ));
              } else {
                if (snapshot.data == null) {
                  return Scaffold(
                    body: SafeArea(
                      child: WebView(
                        initialUrl: 'https://comicvine.gamespot.com',
                      ),
                    ),
                  );
                } else {
                  Map<String, dynamic> resultSerieList =
                      jsonDecode(snapshot.data.toString());
                  // print(resultSerieList['results'][0]['name']);
                  print((width / 2).toString());
                  return Scaffold(
                    body: SafeArea(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      (itemWidth/itemHeight),
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 2),
                          itemCount:  resultSerieList['results'].length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              children: [
                                SeriesVinehomeScreen(
                                    img: resultSerieList['results'][index]
                                        ['image']['medium_url'],
                                    titulo: resultSerieList['results'][index]
                                        ['name'],
                                    publicacion: resultSerieList['results']
                                        [index]['start_year'],
                                    company: resultSerieList['results'][index]['publisher'] == null
                                        ? 'Desconocido'
                                        : resultSerieList['results'][index]
                                            ['publisher']['name'],
                                    episodes: resultSerieList['results'][index]
                                        ['count_of_episodes'],
                                    onpressed: () => seriesVineBloc.add(SerieDescription(
                                        resultSerieList['results'][index]['id'],
                                        context))),
                                // seriesListBloc.state.listCount - 1 == index
                                //     ? Flexible(
                                //         child: Container(
                                //             child: TextButton(
                                //                 onPressed: () => seriesListBloc
                                //                     .add(SeriesListCount(
                                //                         20,
                                //                         resultSerieList[
                                //                                 'results']
                                //                             .length,
                                //                         context)),
                                //                 child: Material(
                                //                   color:
                                //                       Colors.red.withOpacity(0),
                                //                   child: Text(
                                //                     'Ver mas',
                                //                     style:
                                //                         TextStyle(fontSize: 2,color: Colors.white),
                                //                   ),
                                //                 ))))
                                //     : Container()
                              ],
                            );
                          }),
                    ),
                  );
                }
              }
              break;
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Material(
                    color: Colors.red.withOpacity(0),
                    child: Text('Cargando...'),
                  )
                ],
              );
              break;
            default:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Material(
                    color: Colors.red.withOpacity(0),
                    child: Text('Cargando...'),
                  )
                ],
              );
          }
        });
  }

  Future _seriesList(BuildContext context) async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://comicvine.gamespot.com/api/series_list/?api_key=b381f398979c82f4e221c53303b9ca3d924689e9&format=json'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        return result;
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (Route<dynamic> route) => false);
            });
            return AlertDialog(
              title: Text('Error'),
              content: Text('puede haber algún problema con su conexión'),
            );
          });
    } on WebSocket {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (Route<dynamic> route) => false);
            });
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Problema con el servidor o puede haber algún problema con su conexión'),
            );
          });
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (Route<dynamic> route) => false);
            });
            return AlertDialog(
              title: Text('Error'),
              content: Text('Error desconocido'),
            );
          });
    }
  }
}
