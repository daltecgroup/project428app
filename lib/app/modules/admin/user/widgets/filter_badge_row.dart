import 'package:flutter/material.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../models/user_filter.dart';

class FilterBadgeRow extends StatelessWidget {
  final UserFilter filter;
  final VoidCallback onClear;

  const FilterBadgeRow({
    super.key,
    required this.filter,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (!filter.isFilterActive()) return const SizedBox();

    final badges = <Widget>[
      if (filter.showActive && !filter.showDeactive)
        _buildBadge(StringValue.ACTIVE, Colors.blue[600]),
      if (!filter.showActive && filter.showDeactive)
        _buildBadge(StringValue.INACTIVE, Colors.blue[600]),
      if (filter.showAdmin) _buildBadge(StringValue.ADMIN, Colors.blue[400]),
      if (filter.showFranchisee)
        _buildBadge(StringValue.FRANCHISEE, Colors.blue[400]),
      if (filter.showSpvarea)
        _buildBadge(StringValue.SPV_AREA, Colors.blue[400]),
      if (filter.showOperator)
        _buildBadge(StringValue.OPERATOR, Colors.blue[400]),
    ];

    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.DEFAULT_PADDING,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [const Text("Filter: "), ...badges]),
              GestureDetector(
                onTap: onClear,
                child: const Icon(Icons.clear_rounded, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String label, Color? color) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Badge(
        label: Text(label),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        backgroundColor: color,
      ),
    );
  }
}
