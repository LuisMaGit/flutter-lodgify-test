import 'package:lodgify/di/locator.dart';
import 'package:lodgify/services/network/dtos/group_dto.dart';
import 'package:lodgify/services/network/repos/igroup_network_repo.dart';
import 'package:lodgify/services/network/resources/response_network.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<IGroupNetworkRepo>(returnNullOnMissingStub: true),
  ],
)
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerIGroupNetworkRepo() {}

IGroupNetworkRepo getAndRegisterNetworkRepoMock({
  Future<ResponseNetwork<List<GroupDto>>>? response,
}) {
  _removeRegistrationIfExists<IGroupNetworkRepo>();
  final mock = MockIGroupNetworkRepo();
  locator.registerFactory<IGroupNetworkRepo>(() => mock);
  if (response != null) {
    when(mock.getGroups()).thenAnswer((_) => response);
  } else {
    when(mock.getGroups())
        .thenAnswer((_) => Future.sync(() => ResponseNetwork(error: true)));
  }
  return mock;
}

void unRegisterNetworkRepoMock() {
  locator.unregister<IGroupNetworkRepo>();
}
