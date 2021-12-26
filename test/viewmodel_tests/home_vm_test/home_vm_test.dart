import 'package:flutter_test/flutter_test.dart';
import 'package:lodgify/services/network/resources/response_network.dart';
import 'package:lodgify/ui/views/home/home_state.dart';
import 'package:lodgify/ui/views/home/home_vm.dart';
import 'package:mockito/mockito.dart';

import 'setup/data_mock.dart';
import 'setup/test_helpers.dart';

void main() {
  group('HomeVMTest -', () {
    setUp(() => getAndRegisterNetworkRepoMock());
    tearDown(() => unRegisterNetworkRepoMock());

    group('Initialization - ', () {
      test('When constructed, HomeState must be loading', () {
        getAndRegisterNetworkRepoMock();
        final model = HomeVM();
        expect(model.state, HomeState.loading);
      });

      test('When constructed, must call getGroups from network', () async {
        final mock = getAndRegisterNetworkRepoMock();
        HomeVM();
        verify(mock.getGroups());
      });

      test(
          'When called getGroups and response has error, HomeState must be error',
          () async {
        final mock = getAndRegisterNetworkRepoMock(
            response: Future.sync(() => ResponseNetwork(
                  error: true,
                )));
        final model = HomeVM();
        await mock.getGroups();
        expect(model.state, HomeState.error);
      });

      test(
          'When data is empty, groups state must be initialized and HomeState must be empty',
          () async {
        final mock = getAndRegisterNetworkRepoMock(
            response: Future.sync(() => ResponseNetwork(
                  data: [],
                )));
        final model = HomeVM();
        await mock.getGroups();
        expect([], model.groups);
        expect(model.state, HomeState.empty);
      });

      test(
          'When data is dataFromGist, progress bar must be 36 and HomeState success',
          () async {
        final mock = getAndRegisterNetworkRepoMock(
            response: Future.sync(() => ResponseNetwork(
                  data: dataFromGist,
                )));
        final model = HomeVM();
        await mock.getGroups();
        expect(36, model.progressBar);
        expect(model.state, HomeState.success);
      });
    });

    group('Events - ', () {
      test(
          'When toggle group 0 from dataFromGist, dropped must be true and HomeState success',
          () async {
        final mock = getAndRegisterNetworkRepoMock(
            response: Future.sync(() => ResponseNetwork(
                  data: dataFromGist,
                )));
        final model = HomeVM();
        await mock.getGroups();
        model.toggleGroup(0);
        expect(true, model.groups[0].droped);
        expect(model.state, HomeState.success);
      });

      test(
          'When toggle group 0 task 0 from dataFromGist, task must be unchecked, the progressBar 31 and the HomeState success',
          () async {
        final mock = getAndRegisterNetworkRepoMock(
            response: Future.sync(() => ResponseNetwork(
                  data: dataFromGist,
                )));
        final model = HomeVM();
        await mock.getGroups();
        model.toggleTask(0, 0);
        expect(false, model.groups[0].tasks[0].checked);
        expect(31, model.progressBar);
        expect(model.state, HomeState.success);
      });
    });
  });
}
