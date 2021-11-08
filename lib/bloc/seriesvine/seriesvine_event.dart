part of 'seriesvine_bloc.dart';

@immutable
abstract class SeriesVineEvent {}

class SerieDescription extends SeriesVineEvent {
  final int id;
  final BuildContext context;
  SerieDescription(this.id, this.context);
}

@immutable
abstract class SeliesListEvent {}

class SeriesListCount extends SeliesListEvent {
  final int listCount;
  final int lengthList;
  final BuildContext context;
  SeriesListCount(this.listCount, this.lengthList,this.context);
}
