enum RouteType {
  splash("/splash"),
  register("/register"),
  login("/login"),
  photoUpload("/photoUpload"),
  main("/main"),
  limiterOffer("/limiterOffer"),
  movieDetail("/movieDetail"),
  notFound("/notFound");

  final String name;
  const RouteType(this.name);
}

RouteType navigationFromJson(String? value) {
  if (value == null) return RouteType.notFound;
  for (var type in RouteType.values) {
    if (value == type.name) return type;
  }
  return RouteType.notFound;
}
