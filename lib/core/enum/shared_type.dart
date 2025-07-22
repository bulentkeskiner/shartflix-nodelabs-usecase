enum SharedType {
  userModel("_userModel"),

  userEmail("_userEmail"),

  login("/login"),

  profile("/profile"),

  photoUpload("/photoUpload"),

  discover("/discover"),

  limiterOffer("/limiterOffer"),

  notFound("/notFound");

  final String name;
  const SharedType(this.name);
}
