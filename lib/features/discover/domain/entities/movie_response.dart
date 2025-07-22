import 'package:shartflix/models/movie_model.dart';

class MovieResponse {
  List<MovieModel>? movies;
  Pagination? pagination;

  MovieResponse({this.movies, this.pagination});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      movies: (json['movies'] as List?)?.map((e) => MovieModel.fromJson(e)).toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movies': movies?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class Pagination {
  int? totalCount;
  int? perPage;
  int? maxPage;
  int? currentPage;

  Pagination({this.totalCount, this.perPage, this.maxPage, this.currentPage});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalCount: json['totalCount'],
      perPage: json['perPage'],
      maxPage: json['maxPage'],
      currentPage: json['currentPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'perPage': perPage,
      'maxPage': maxPage,
      'currentPage': currentPage,
    };
  }
}
