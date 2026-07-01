
enum UserRole { citizen, admin, entity }

class MenuItemModel {
  final String label;
  final String route;
  final String iconKey;
  final List<UserRole> allowedRoles;

  const MenuItemModel({
    required this.label,
    required this.route,
    required this.iconKey,
    required this.allowedRoles
  });
}