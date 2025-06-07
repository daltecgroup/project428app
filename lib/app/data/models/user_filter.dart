import 'user.dart';

class UserFilter {
  String? keyword;
  bool showActive,
      showDeactive,
      showAdmin,
      showFranchisee,
      showSpvarea,
      showOperator,
      newestFirst;

  UserFilter({
    required this.keyword,
    this.showActive = false,
    this.showDeactive = false,
    this.showAdmin = false,
    this.showFranchisee = false,
    this.showSpvarea = false,
    this.showOperator = false,
    this.newestFirst = true
  });

  // setter for keyword
  void setKeyword(String? newKeyword) {
    keyword = newKeyword;
  }

  // setter for showActive
  void setShowActive(bool newShowActive) {
    showActive = newShowActive;
  }

  // setter for showDeactive
  void setShowDeactive(bool newShowDeactive) {
    showDeactive = newShowDeactive;
  }

  // setter for showAdmin
  void setShowAdmin(bool newShowAdmin) {
    showAdmin = newShowAdmin;
  }

  // setter for showFranchisee
  void setShowFranchisee(bool newShowFranchisee) {
    showFranchisee = newShowFranchisee;
  }

  // setter for showSpvarea
  void setShowSpvarea(bool newShowSpvarea) {
    showSpvarea = newShowSpvarea;
  }

  // setter for showOperator
  void setShowOperator(bool newShowOperator) {
    showOperator = newShowOperator;
  }

  // setter for newestFirst
  void setNewestFirst(bool newNewestFirst) {
    newestFirst = newNewestFirst;
  }

  // Method to reset all filters
  void resetFilters() {
    keyword = null;
    showActive = false;
    showDeactive = false;
    showAdmin = false;
    showFranchisee = false;
    showSpvarea = false;
    showOperator = false;
  }

  // Method to check if any filter is active
  bool isFilterActive() {
    return keyword != null ||
        showActive ||
        showDeactive ||
        showAdmin ||
        showFranchisee ||
        showSpvarea ||
        showOperator;
  }

  // get filtered users list from input user list, the list can input an empty list and it will return an empty list, if newestFirst is true then the list will be the new to old
  List<User> getFilteredUsers(List<User> users) {

    if (users.isEmpty) {
      return [];
    }

    List<User> result = users.where((user) {
      bool matchesKeyword =
          keyword == null ||
          user.name.trim().toLowerCase().contains(
            keyword!.trim().toLowerCase(),
          );
      bool matchesActiveStatus =
          (showActive && user.isActive) ||
          (showDeactive && !user.isActive) ||
          (!showActive && !showDeactive);
      bool matchesRole =
          (showAdmin && user.role.contains('admin')) ||
          (showFranchisee && user.role.contains('franchisee')) ||
          (showSpvarea && user.role.contains('spvarea')) ||
          (showOperator && user.role.contains('operator')) ||
          (!showAdmin && !showFranchisee && !showSpvarea && !showOperator);

      return matchesKeyword && matchesActiveStatus && matchesRole;
    }).toList();

    if (newestFirst) {
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } 
    return result;
  }
}
