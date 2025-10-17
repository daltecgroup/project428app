part of '../views/admin_dashboard_view.dart';

class UserIndicator extends StatelessWidget {
  const UserIndicator({super.key, required this.controller});

  final AdminDashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ListTile(
        selected: true,
        selectedTileColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: CustomCircleAvatarImage(),
        title: Text(
          controller.currentUser!.name,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'ID ${controller.currentUser!.userId}',
          style: TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          onPressed: () => controller.auth.logout(),
          icon: Icon(Icons.logout_rounded),
        ),
      ),
    );
  }
}
