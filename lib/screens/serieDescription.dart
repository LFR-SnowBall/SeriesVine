import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriesvine/bloc/seriesvine/seriesvine_bloc.dart';
import 'package:seriesvine/widgets/descriptionScreeenSV.dart';

class SeriesDescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seriesVineBloc = BlocProvider.of<SeriesVineBloc>(context);

    return SafeArea(
        child: SeriesVineDescriptionScreen(
      img: seriesVineBloc.state.img,
      titulo: seriesVineBloc.state.titulo,
      publicacion: seriesVineBloc.state.publication,
      company: seriesVineBloc.state.company,
      Description: seriesVineBloc.state.description,
      episodes: seriesVineBloc.state.episodes,
    ));
  }
}
