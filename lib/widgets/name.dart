import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriesvine/bloc/seriesvine/seriesvine_bloc.dart';

class Resultname extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesVineBloc, SeriesVineState>(
        builder: (context, state) {
      return Text(state.titulo);
    });
  }
}
