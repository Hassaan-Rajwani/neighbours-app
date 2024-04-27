// ignore_for_file: unused_local_variable, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Favorites/widget/ProfileCardWidget.dart';
import 'package:neighbour_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static const routeName = '/favoritesPage';

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    _onrefresh();
    super.initState();
  }

  Future<void> _onrefresh() async {
    sl<FavoriteBloc>().add(GetFavoriteListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        var isGetFavoriteListEmpty = false;
        if (state is FavoriteListError) {
          Container(
            height: 400,
            width: SizeHelper.screenWidth,
            color: Colors.amber,
          );
          snackBarComponent(context, color: persimmon, message: state.error);
        }
        if (state is FavoriteListSuccessFull) {
          isGetFavoriteListEmpty = state.list.isEmpty;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: backButtonAppbar(
            context,
            icon: const Icon(Icons.arrow_back),
            backgroundColor: Colors.white,
            text: 'Favorites',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is GetFavoriteListInprogress)
                  const CircularLoader(
                    height: 80,
                  ),
                if (state is FavoriteListSuccessFull)
                  isGetFavoriteListEmpty
                      ? const Center(
                          heightFactor: 45,
                          child: Text('Favorite List is empty.'),
                        )
                      : RefreshIndicator(
                          onRefresh: _onrefresh,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeHelper.moderateScale(25),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.list.length,
                              itemBuilder: (context, index) {
                                return ProfileCard(
                                  firstName: state.list[index].firstName,
                                  lastName: state.list[index].lastName,
                                  imagePath:
                                      state.list[index].imageUrl.toString(),
                                  name:
                                      '${state.list[index].firstName} ${state.list[index].lastName}',
                                  rating: double.parse(
                                    state.list[index].rating.toStringAsFixed(1),
                                  ),
                                  onRemovePressed: () async {
                                    sl<FavoriteBloc>().add(
                                      DeleteFavoriteEvent(
                                        favoriteID: state.list[index].id,
                                      ),
                                    );
                                    setState(() {
                                      state.list.removeAt(index);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
              ],
            ),
          ),
        );
      },
    );
  }
}
