import 'package:flutter/material.dart';
import 'package:movies/UI/search/search_args.dart';
import 'package:movies/model/film_models.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Film> _listFilmSearch = [];
  SearchArgs? args;
  TextEditingController searchController = TextEditingController();

  void _onSearch() {
    _listFilmSearch.clear();
    if (searchController.text.isEmpty) {
      setState(() {});
      return;
    }

    args!.films.forEach((f) {
      if (f.original_title!.contains(searchController.text))
        _listFilmSearch.add(f);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      args = ModalRoute.of(context)!.settings.arguments as SearchArgs;
    }
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 15.0),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => _onSearch(),
                          child: Icon(Icons.search,
                              color: Colors.black.withOpacity(0.7)),
                        )),
                    Expanded(
                      flex: 7,
                      child: TextField(
                        onTap: () {},
                        controller: searchController,
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                        decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: "Search",
                          fillColor: Colors.transparent,
                          hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: _listFilmSearch.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
                                _listFilmSearch[index].poster_path!,
                            width: MediaQuery.of(context).size.width / 6,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_listFilmSearch[index].original_title!)
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
