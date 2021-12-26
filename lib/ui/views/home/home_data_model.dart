class GroupsHomeModel {
  final String name;
  final List<HomeTaskModel> tasks;
  final bool droped;

  const GroupsHomeModel({
    required this.name,
    required this.tasks,
    this.droped = false, 
  });

  bool get allChecked => !tasks.any((t) => !t.checked);
  bool get anyTask => tasks.isEmpty;

  GroupsHomeModel copyWith({
    String? name,
    List<HomeTaskModel>? tasks,
    bool? allChecked,
    bool? droped,
  }) {
    return GroupsHomeModel(
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
      droped: droped ?? this.droped,
    );
  }
}

class HomeTaskModel {
  final int value;
  final bool checked;
  final String description;

  const HomeTaskModel({
    required this.value,
    required this.checked,
    required this.description,
  });

  bool get noDescription => description.isEmpty;

  HomeTaskModel copyWith({
    int? value,
    bool? checked,
    String? description,
  }) {
    return HomeTaskModel(
      value: value ?? this.value,
      checked: checked ?? this.checked,
      description: description ?? this.description,
    );
  }
}
