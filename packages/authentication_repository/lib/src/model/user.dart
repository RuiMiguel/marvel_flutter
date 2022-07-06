class User {
  User({
    required this.privateKey,
    required this.publicKey,
  });

  const User.anonymous()
      : privateKey = '',
        publicKey = '';

  final String privateKey;
  final String publicKey;
}
