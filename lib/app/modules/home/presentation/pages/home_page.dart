import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mais_filmes/app/modules/home/presentation/components/bottom_bar_widget.dart';

import '../controllers/home_controller.dart';
import 'tabs/favorites_tab.dart';
import 'tabs/movies_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  int currentPage = 0;
  late final PageController _pageController = PageController(initialPage: 0);

  changeIndex(int newIndex, [bool updateController = false]) {
    if (updateController) {
      _pageController.animateToPage(newIndex, 
        duration: const Duration(microseconds: 300), curve: Curves.easeIn);
    }
    setState(() { currentPage = newIndex; });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(context, screenSize),
      body: PageView(
        controller: _pageController,
        onPageChanged: changeIndex,
        children: [
          MoviesTab(),
          FavoritesTab()
        ],
      ),
      bottomNavigationBar: BottomBarWidget(
        onTap: changeIndex,
        currentIndex: currentPage,
      ),
    );
  }

  AppBar _appBar(BuildContext context, Size screenSize) => AppBar(
    actions: [
      IconButton(
        onPressed: () => controller.authStore.logOut(),
        icon: const Icon(MaterialCommunityIcons.logout)
      )
    ],
    title: Row(
      children: [
        controller.user?.image != null ? Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: Image.network(controller.user!.image!,
              width: 0.075 * screenSize.height,
              fit: BoxFit.fitHeight
            ),
          ),
        ) : null,
        Text(controller.user?.name ?? ""),
      ].where((w) => w != null).toList().cast(),
    ),
  );
}