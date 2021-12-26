import 'package:lodgify/services/network/dtos/group_dto.dart';
import 'package:lodgify/services/network/resources/response_network.dart';

abstract class IGroupNetworkRepo {
  Future<ResponseNetwork<List<GroupDto>>> getGroups();
}
