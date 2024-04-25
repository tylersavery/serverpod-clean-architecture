import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_flutter/features/app_user/presentation/widgets/app_user_dropdown.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_edit_page.dart';
import 'package:movieapp_flutter/features/movie/presentation/widgets/movie_list_widget.dart';

class MovieListPage extends StatelessWidget {
  static String route() => "/movies";

  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: const [
          AppUserDropdown(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(MovieEditPage.routeNew());
        },
        child: const Icon(Icons.add),
      ),
      body: const MovieListWidget(),
    );
  }
}
