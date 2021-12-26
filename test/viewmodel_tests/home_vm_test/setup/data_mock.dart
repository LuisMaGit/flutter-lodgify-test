import 'package:lodgify/services/network/dtos/group_dto.dart';
import 'package:lodgify/services/network/dtos/task_dto.dart';

const dataFromGist = <GroupDto>[
  GroupDto(
    name: '',
    tasks: [
      TaskDto(value: 10, checked: true, description: ''),
      TaskDto(value: 15, checked: false, description: ''),
      TaskDto(value: 8, checked: false, description: ''),
      TaskDto(value: 5, checked: true, description: ''),
    ],
  ),
  GroupDto(
    name: '',
    tasks: [
      TaskDto(value: 23, checked: false, description: ''),
      TaskDto(value: 32, checked: true, description: ''),
      TaskDto(value: 2, checked: false, description: ''),
      TaskDto(value: 21, checked: false, description: ''),
      TaskDto(value: 12, checked: true, description: ''),
    ],
  ),
  GroupDto(
    name: '',
    tasks: [
      TaskDto(value: 15, checked: true, description: ''),
      TaskDto(value: 7, checked: true, description: ''),
    ],
  ),
  GroupDto(
    name: '',
    tasks: [
      TaskDto(value: 42, checked: false, description: ''),
      TaskDto(value: 23, checked: false, description: ''),
      TaskDto(value: 12, checked: false, description: ''),
    ],
  ),
];
