enum PrimaryColors {
  red(0xFFE53935, 'Red'), // Adjusted for better contrast
  pink(0xFFD81B60, 'Pink'),
  light(0xFF039BE5, 'Light Blue'),
  cyan(0xFF00ACC1, 'Cyan'),
  teal(0xFF00897B, 'Teal'),
  green(0xFF43A047, 'Green'),
  lightGreen(0xFF7CB342, 'Light Green'),
  lime(0xFFC0CA33, 'Lime'),
  yellow(0xFFFFD600, 'Yellow'), // Adjusted for better contrast
  amber(0xFFFFB300, 'Amber'),
  orange(0xFFFB8C00, 'Orange'),
  deepOrange(0xFFF4511E, 'Deep Orange');

  const PrimaryColors(
    this.colorCode,
    this.semanticLable,
  );

  final int colorCode;
  final String semanticLable;
}
