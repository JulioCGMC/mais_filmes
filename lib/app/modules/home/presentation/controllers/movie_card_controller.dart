import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import 'home_controller.dart';

part 'movie_card_controller.g.dart';

class MovieCardController = MovieCardControllerBase with _$MovieCardController;

abstract class MovieCardControllerBase with Store {
  final HomeController baseController;

  MovieCardControllerBase(this.baseController);

  Future<void> showMovie(Movie movie) async {
    Modular.to.pushNamed("./details", arguments: movie);
  }
}