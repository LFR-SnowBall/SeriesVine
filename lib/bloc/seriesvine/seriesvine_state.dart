part of 'seriesvine_bloc.dart';

class SeriesVineState {
  final String description;
  final String img;
  final String titulo;
  final String company;
  final String publication;
  final List<dynamic> episodes;

  SeriesVineState(
      {this.description = "Descripcción",
      this.img = "https://picsum.photos/250?image=9",
      this.titulo = "titulo",
      this.episodes = const [],
      this.company = "CN",
      this.publication = "2021"});

  SeriesVineState copyWith(
          {String? description,
          String? titulo,
          String? img,
          List<dynamic>? episodes,
          String? publication,
          String? company}) =>
      SeriesVineState(
          description: description ?? this.description,
          company: company ?? this.company,
          publication: publication ?? this.publication,
          titulo: titulo ?? this.titulo,
          img: img ?? this.img,
          episodes: episodes ?? this.episodes);
}

class SeriesListState {
  final int listCount;
  SeriesListState({this.listCount = 20});

  SeriesListState copyWith({int? listCount}) =>
      SeriesListState(listCount: listCount ?? this.listCount);
}
