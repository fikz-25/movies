class Film {
  int? id;
  String? backdrop_path;
  String? original_title;
  String? overview;
  String? poster_path;
  double? popularity;
  String? release_date;
  String? vote_average;

  Film(
      {this.id,
      this.backdrop_path,
      this.original_title,
      this.overview,
      this.poster_path,
      this.popularity,
      this.release_date,
      this.vote_average});

  factory Film.fromJSON(Map<String, dynamic> jsonMap) {
    return Film(
        id: jsonMap['id'],
        backdrop_path: jsonMap['backdrop_path'],
        original_title: jsonMap['original_title'],
        overview: jsonMap['overview'],
        poster_path: jsonMap['poster_path'],
        popularity: jsonMap['popularity'],
        release_date: jsonMap['release_date'],
        vote_average: jsonMap['vote_average'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "backdrop_path": this.backdrop_path,
      "first_name": this.original_title,
      "last_name": this.overview,
      "poster_path": this.poster_path,
      "release_date": this.release_date,
      "vote_average": this.vote_average
    };
  }
}
