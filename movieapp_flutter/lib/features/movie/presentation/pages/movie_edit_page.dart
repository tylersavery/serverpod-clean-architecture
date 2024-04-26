import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/utils/show_snackbar.dart';
import 'package:movieapp_flutter/core/widgets/loader.dart';
import 'package:movieapp_flutter/features/asset/presentation/widgets/upload_file_widget.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_manage/movie_manage_bloc.dart';

class MovieEditPage extends StatefulWidget {
  final int? movieId;

  static String route([int? movieId]) => "/movies/edit/${movieId ?? ':id'}";
  static String routeNew() => "/movies/new";

  const MovieEditPage({super.key, this.movieId});

  @override
  State<MovieEditPage> createState() => _MovieEditPageState();
}

class _MovieEditPageState extends State<MovieEditPage> {
  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final loglineController = TextEditingController();
  final directorNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String imageUrl = "";

  bool get isEditing {
    return widget.movieId != null && widget.movieId! > 0;
  }

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      context.read<MovieManageBloc>().add(MovieManageRetrieveEvent(widget.movieId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final movie = Movie(
                  id: widget.movieId,
                  title: titleController.text,
                  year: int.parse(yearController.text),
                  imageUrl: imageUrl,
                  logline: loglineController.text,
                  directorName: directorNameController.text,
                );

                context.read<MovieManageBloc>().add(MovieManageSaveEvent(movie));
              }
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: BlocConsumer<MovieManageBloc, MovieManageState>(
        listener: (context, state) {
          if (state is MovieManageStateFailure) {
            showSnackbar(context, state.message);
          } else if (state is MovieManageStateSaveSuccess) {
            context.read<MovieListBloc>().add(FetchMoviesEvent());

            if (isEditing) {
              context.read<MovieDetailBloc>().add(MovieDetailRetrieveEvent(id: widget.movieId!));
            }

            context.pop();
          } else if (state is MovieManageStateDeleteSuccess) {
            context.read<MovieListBloc>().add(FetchMoviesEvent());
            context.pop();
            context.pop();
          } else if (state is MovieManageStateRetrieveSuccess) {
            titleController.text = state.movie.title;
            yearController.text = state.movie.year.toString();
            loglineController.text = state.movie.logline;
            directorNameController.text = state.movie.directorName;
            setState(() {
              imageUrl = state.movie.imageUrl;
            });
          }
        },
        builder: (context, state) {
          if (state is MovieListStateLoading) {
            return const Loader();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title Required";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: yearController,
                      decoration: const InputDecoration(
                        label: Text("Year"),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Year Required";
                        }

                        if (int.tryParse(value) == null) {
                          return "Invalid Year";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: loglineController,
                      decoration: const InputDecoration(
                        label: Text("Logline"),
                      ),
                      minLines: 3,
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Logline Required";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: directorNameController,
                      decoration: const InputDecoration(
                        label: Text("Director Name"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Director Name Required";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
                      child: UploadFileWidget(
                        url: imageUrl,
                        label: "Movie Poster Image",
                        onComplete: (url) {
                          setState(() {
                            imageUrl = url;
                          });
                        },
                      ),
                    ),
                    if (isEditing)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<MovieManageBloc>().add(MovieManageDeleteEvent(widget.movieId!));
                            },
                            child: const Text("Delete")),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
