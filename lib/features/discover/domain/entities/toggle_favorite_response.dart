import 'package:shartflix/models/movie_model.dart';

class ToggleFavoriteResponse {
  MovieModel? movie;
  String? action;

  ToggleFavoriteResponse({this.movie, this.action});

  factory ToggleFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return ToggleFavoriteResponse(
      movie: MovieModel.fromJson(json['movie']),
      action: json['action'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'movies': movie?..toJson(), 'action': action};
  }
}
