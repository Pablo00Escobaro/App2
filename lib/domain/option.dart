class Option {
  final bool isSelected;
  final String title;
  final String value;

  const Option(
      {required this.isSelected, required this.title, required this.value});

  Option copyWith({bool? selected, String? newTitle, String? newValue}) {
    return Option(
        isSelected: selected ?? isSelected,
        title: newTitle ?? title,
        value: newValue ?? value);
  }
}
