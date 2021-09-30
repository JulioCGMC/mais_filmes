import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import 'home_controller.dart';

part 'favorites_controller.g.dart';

class FavoritesController = FavoritesControllerBase with _$FavoritesController;

abstract class FavoritesControllerBase with Store {
  final HomeController baseController;

  FavoritesControllerBase(this.baseController);

  @computed
  ObservableList<Movie> get favorites => baseController.favorites;
}