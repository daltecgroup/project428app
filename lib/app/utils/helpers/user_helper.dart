import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import '../constants/app_constants.dart';

bool get isAdmin {
  return box.getValue(AppConstants.KEY_CURRENT_ROLE) == AppConstants.ROLE_ADMIN;
}

bool get isFranchisee {
  return box.getValue(AppConstants.KEY_CURRENT_ROLE) ==
      AppConstants.ROLE_FRANCHISEE;
}

bool get isSpvArea {
  return box.getValue(AppConstants.KEY_CURRENT_ROLE) ==
      AppConstants.ROLE_SPVAREA;
}

bool get isOperator {
  return box.getValue(AppConstants.KEY_CURRENT_ROLE) ==
      AppConstants.ROLE_OPERATOR;
}
