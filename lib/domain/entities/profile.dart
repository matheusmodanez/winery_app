class Profile {
  int? id;
  String name;
  String profilePicture;
  String serviceType;
  int? wineryCapacity;
  int? catalogId;

  Profile({
    this.id,
    required this.name,
    required this.profilePicture,
    required this.serviceType,
    required this.wineryCapacity,
    this.catalogId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'serviceType': serviceType,
      'wineryCapacity': wineryCapacity,
      'catalogId': catalogId,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      profilePicture: json['profilePicture'],
      serviceType: json['serviceType'],
      wineryCapacity: json['wineryCapacity'],
      catalogId: json['catalogId'],
    );
  }
}
