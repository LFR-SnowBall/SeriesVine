import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:seriesvine/screens/serieDescription.dart';

part 'seriesvine_event.dart';
part 'seriesvine_state.dart';

class SeriesVineBloc extends Bloc<SeriesVineEvent, SeriesVineState> {
  SeriesVineBloc() : super(SeriesVineState());

  @override
  Stream<SeriesVineState> mapEventToState(SeriesVineEvent event) async* {
    if (event is SerieDescription) {
      yield* _SeriesDescription(event.id, event.context);
    }
  }

  Stream<SeriesVineState> _SeriesDescription(id, context) async* {
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://comicvine.gamespot.com/api/series/4075-${id}/?api_key=b381f398979c82f4e221c53303b9ca3d924689e9&format=json'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      Map<String, dynamic> resultSerieDescription = jsonDecode(result);
      print(resultSerieDescription['results']['name']);
      yield state.copyWith(
          titulo: resultSerieDescription['results']['name'],
          img: resultSerieDescription['results']['image']['medium_url'],
          company: resultSerieDescription['results']['publisher'] == null
              ? 'Desconocido'
              : resultSerieDescription['results']['publisher']['name'],
          publication: resultSerieDescription['results']['start_year'],
          description: resultSerieDescription['results']['description'],
          episodes: resultSerieDescription['results']['episodes']);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => SeriesDescriptionScreen()));
    } else {
      print(response.reasonPhrase);
    }
  }
}

class SeriesListBloc extends Bloc<SeliesListEvent, SeriesListState> {
  SeriesListBloc() : super(SeriesListState());

  @override
  Stream<SeriesListState>  mapEventToState(SeliesListEvent event) async* {
    if (event is SeriesListCount) {
      if (state.listCount < event.lengthList) {
        yield state.copyWith(listCount: (state.listCount + event.listCount));
      } else {
        yield state.copyWith(listCount: event.lengthList);
      }
    }
  }
}
