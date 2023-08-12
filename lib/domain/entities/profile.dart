class Profile {
  int? id;
  String name;
  String profilePicture;
  String serviceType;
  int? wineryCapacity;
  int quantity;

  Profile({
    this.id,
    required this.name,
    required this.profilePicture,
    required this.serviceType,
    required this.wineryCapacity,
    required this.quantity,
  });
}
