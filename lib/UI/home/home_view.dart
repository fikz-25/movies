import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movies/UI/details/details_args.dart';
import 'package:movies/UI/home/bloc/home_bloc.dart';
import 'package:movies/UI/home/bloc/home_state.dart';
import 'package:movies/UI/search/search_args.dart';
import 'package:movies/UI/search/search_view.dart';
import 'package:movies/model/film_models.dart';
import 'package:movies/repositories/film_repository.dart';
import 'package:movies/widget/cart_movie.dart';
import 'package:movies/widget/nav_drawer.dart';

import 'bloc/home_event.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<Film> _filmData = [];
  late HomeBloc _homeBloc;
  final dateFormat = new DateFormat('dd-MM-yyyy');
  late ScrollController _controller;

  @override
  void initState() {
    _homeBloc = HomeBloc(FilmRepository());
    _fetchFilm();
    super.initState();
  }

  void _fetchFilm() {
    _homeBloc.add(GetAll());
  }

  _goToDetails(Film film) {
    Navigator.pushNamed(context, '/detailsview',
        arguments: DetailsArgs(film: film));
  }

  _goToSearch() {
    Navigator.pushNamed(context, '/searchview',
        arguments: SearchArgs(films: _filmData));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.blue[700],
              title: Text("Home"),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _goToSearch()),
              ],
            ),
            body: BlocConsumer<HomeBloc, HomeState>(
                bloc: _homeBloc,
                listener: (context, state) => {
                      if (state is FilmLoaded)
                        {
                          _filmData.addAll(state.datas),
                          print(state.datas.length)
                        }
                    },
                builder: (context, state) => Container(
                      child: _filmData.isEmpty
                          ? _isLoading(state)
                          : SingleChildScrollView(
                              child: Column(
                              children: [
                                _nowPlaying(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _topRated(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _popular(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _upComing(),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            )),
                    ))));
  }

  Widget _isLoading(state) {
    if (state is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container();
  }

  Widget _nowPlaying() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Now Playing",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "MORE",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.7,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _filmData.length.toInt(),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: index == 0
                  ? EdgeInsets.only(left: 15.0)
                  : EdgeInsets.only(left: 0.0),
              child: CartMovie(
                image: _filmData[index].poster_path!.isNotEmpty
                    ? "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
                        _filmData[index].poster_path!
                    : "https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png",
                title: _filmData[index].original_title!.isNotEmpty
                    ? _filmData[index].original_title!
                    : "title",
                date: _filmData[index].release_date == null
                    ? "date"
                    : dateFormat
                        .format(DateTime.parse(_filmData[index].release_date!)),
                widths: MediaQuery.of(context).size.width / 2.5,
                navigation: () => _goToDetails(_filmData[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _topRated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Rated",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "MORE",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _filmData.length.toInt(),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: index == 0
                  ? EdgeInsets.only(left: 15.0)
                  : EdgeInsets.only(left: 0.0),
              child: CartMovie(
                image: _filmData[index].poster_path!.isNotEmpty
                    ? "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
                        _filmData[index].poster_path!
                    : "https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png",
                title: _filmData[index].original_title!.isNotEmpty
                    ? _filmData[index].original_title!
                    : "title",
                date: _filmData[index].release_date == null
                    ? "date"
                    : dateFormat
                        .format(DateTime.parse(_filmData[index].release_date!)),
                widths: MediaQuery.of(context).size.width / 3.5,
                navigation: () => _goToDetails(_filmData[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _popular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "MORE",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _filmData.length.toInt(),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: index == 0
                  ? EdgeInsets.only(left: 15.0)
                  : EdgeInsets.only(left: 0.0),
              child: CartMovie(
                image: _filmData[index].poster_path!.isNotEmpty
                    ? "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
                        _filmData[index].poster_path!
                    : "https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png",
                title: _filmData[index].original_title!.isNotEmpty
                    ? _filmData[index].original_title!
                    : "title",
                date: _filmData[index].release_date == null
                    ? "date"
                    : dateFormat
                        .format(DateTime.parse(_filmData[index].release_date!)),
                widths: MediaQuery.of(context).size.width / 3.5,
                navigation: () => _goToDetails(_filmData[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _upComing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Up Coming",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "MORE",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _filmData.length.toInt(),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: index == 0
                  ? EdgeInsets.only(left: 15.0)
                  : EdgeInsets.only(left: 0.0),
              child: CartMovie(
                image: _filmData[index].poster_path!.isNotEmpty
                    ? "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
                        _filmData[index].poster_path!
                    : "https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png",
                title: _filmData[index].original_title!.isNotEmpty
                    ? _filmData[index].original_title!
                    : "title",
                date: _filmData[index].release_date == null
                    ? "date"
                    : dateFormat
                        .format(DateTime.parse(_filmData[index].release_date!)),
                widths: MediaQuery.of(context).size.width / 3.5,
                navigation: () => _goToDetails(_filmData[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
