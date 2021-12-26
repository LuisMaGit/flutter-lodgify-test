import 'package:lodgify/di/locator.dart';
import 'package:lodgify/services/network/dtos/group_dto.dart';
import 'package:lodgify/services/network/repos/igroup_network_repo.dart';
import 'package:lodgify/ui/base_vm.dart';
import 'package:lodgify/ui/views/home/home_data_model.dart';
import 'package:lodgify/ui/views/home/home_state.dart';

class HomeVM extends BaseVM<HomeState> {
  //DI
  final _groupNetworkRepo = locator<IGroupNetworkRepo>();

  HomeVM({
    HomeState state = HomeState.loading,
  }) : super(state = state) {
    _initHome();
  }

  //Internal fields
  double? _totalSumTasksValues;

  //States data
  late final List<GroupsHomeModel> _groups;
  List<GroupsHomeModel> get groups => _groups;
  int _progresBar = 0;
  int get progressBar => _progresBar;
  bool _progressBarActive = false;
  bool get progresBarActive => _progressBarActive;

  Future<void> _initHome() async {
    final response = await _groupNetworkRepo.getGroups();

    if (response.error) {
      setState = HomeState.error;
      return;
    }

    _groups = _mapDtoToViewModel(response.data!);

    if (_groups.isEmpty) {
      setState = HomeState.empty;
      return;
    }

    _progresBar = _getProgressBar();
    setState = HomeState.success;
  }

  List<GroupsHomeModel> _mapDtoToViewModel(List<GroupDto> dto) {
    return List<GroupsHomeModel>.from(dto.map((d) => GroupsHomeModel(
        name: d.name,
        tasks: List<HomeTaskModel>.from(d.tasks.map((t) => HomeTaskModel(
              checked: t.checked,
              description: t.description,
              value: t.value,
            ))))));
  }

  int _getProgressBar() {
    //Total tasks values
    _totalSumTasksValues ??= _getTotalSumTasksValues(_groups);

    //Normalized sum
    return _getNormalizedSum(groups, _totalSumTasksValues!).round();
  }

  double _getTotalSumTasksValues(List<GroupsHomeModel> groups) {
    var sumValues = 0.0;
    for (var g in groups) {
      for (var t in g.tasks) {
        sumValues += t.value;
      }
    }
    return sumValues;
  }

  double _getNormalizedSum(
    List<GroupsHomeModel> groups,
    double totalSumTasksValues,
  ) {
    var normSum = 0.0;
    for (var g in groups) {
      if (g.tasks.any((t) => t.checked)) {
        for (var t in g.tasks) {
          if (t.checked) {
            normSum += t.value * 100 / totalSumTasksValues;
          }
        }
      }
    }

    return normSum;
  }

  //Events
  void toggleGroup(int idx) {
    final newState = groups[idx].copyWith(droped: !groups[idx].droped);
    groups[idx] = newState;
    notifyListeners();
  }

  void toggleTask(int groupIdx, int taskIdx) {
    final newState = groups[groupIdx].tasks[taskIdx].copyWith(
          checked: !groups[groupIdx].tasks[taskIdx].checked,
        );

    groups[groupIdx].tasks[taskIdx] = newState;
    _progresBar = _getProgressBar();
    notifyListeners();
  }

  void fixProgressBar() {
    _progressBarActive = true;
  }

  void tryAgain() => _initHome();
}
