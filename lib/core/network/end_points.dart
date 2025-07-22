class EndPoints {
  static String userLogin() => 'user/login';
  static String userProfile() => 'user/profile';
  static String userRegister() => 'user/register';
  static String userUploadPhoto() => 'user/upload_photo';

  static String movieFavorite(String id) => 'movie/favorite/$id';
  static String movieFavorites() => 'movie/favorites';
  static String movieList(int page) => 'movie/list?page=$page';
}

class Params {
  static const String page = 'page';
  static const String email = 'email';
  static const String file = 'file';
  static const String password = 'password';
  static const String name = 'name';
  static const String apiKey = 'api_key';
}
