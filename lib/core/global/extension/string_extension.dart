extension StringExtension on String? {
  bool get hasData => this != null && this!.trim().isNotEmpty;
  bool get hasNoData => this == null || this!.trim().isEmpty;

  String? join([String? filler]) {
    if (hasNoData || filler.hasNoData) return null;
    return this! + filler!;
  }
}
