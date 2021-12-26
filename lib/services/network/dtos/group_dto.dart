import 'package:lodgify/services/network/dtos/task_dto.dart';

class GroupDto {
  final String name;
  final List<TaskDto> tasks;

  const GroupDto({
    required this.name,
    required this.tasks,
  });

  factory GroupDto.fromMap(Map<String, dynamic> map) {
    return GroupDto(
      name: map['name'] ?? '',
      tasks: List<TaskDto>.from(map['tasks']?.map((x) => TaskDto.fromMap(x))),
    );
  }

}
