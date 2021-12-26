class TaskDto {
  final int value;
  final bool checked;
  final String description;
  
  const TaskDto({
    required this.value,
    required this.checked,
    required this.description,
  });


  factory TaskDto.fromMap(Map<String, dynamic> map) {
    return TaskDto(
      value: map['value']?.toInt() ?? 0,
      checked: map['checked'] ?? false,
      description: map['description'] ?? '',
    );
  }

}
