class User {
  final String id;
  final String username;
  final String avatarUrl;
  final List<String> projectsIds;
  final List<String> ownerProjectsIds;

  User({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.projectsIds,
    required this.ownerProjectsIds
  });
}