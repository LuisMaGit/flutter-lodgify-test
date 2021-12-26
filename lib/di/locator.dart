import 'package:get_it/get_it.dart';
import 'package:lodgify/services/network/repos/group_network_repo.dart';
import 'package:lodgify/services/network/repos/igroup_network_repo.dart';
import 'package:lodgify/ui/views/home/home_vm.dart';

final locator = GetIt.instance;

void configureDependencies() {
  locator
    ..registerFactory<IGroupNetworkRepo>(() => GroupNetworkRepo())
    ..registerFactory(() => HomeVM());
}
