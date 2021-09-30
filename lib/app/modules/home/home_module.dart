import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mais_filmes/app/modules/home/data/repositories/movies_repository.dart';
import 'package:mais_filmes/app/modules/home/external/moviedb_data_source.dart';
import 'package:mais_filmes/app/modules/home/presentation/pages/movie_details_page.dart';
import 'presentation/controllers/favorites_controller.dart';
import 'presentation/controllers/home_controller.dart'; 

import 'presentation/controllers/movie_card_controller.dart';
import 'presentation/controllers/movie_details_controller.dart';
import 'presentation/controllers/movies_controller.dart';
import 'presentation/pages/home_page.dart';
 
class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MovieDetailsController(i.get(),i.get())),
    Bind.lazySingleton((i) => FavoritesController(i.get())),
    Bind.lazySingleton((i) => MoviesController(i.get())),
    Bind.lazySingleton((i) => MovieCardController(i.get())),
    Bind.lazySingleton((i) => HomeController(i.get(),i.get())),
    $MoviesRepository,
    $MoviedbDataSource,
    Bind.lazySingleton((i) => Dio())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute('/details', child: (_,args) => MovieDetailsPage(args.data))
  ];
}