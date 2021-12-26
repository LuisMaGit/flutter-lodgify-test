import 'dart:convert';
import 'package:http/http.dart';
import 'package:lodgify/services/network/dtos/group_dto.dart';
import 'package:lodgify/services/network/repos/igroup_network_repo.dart';
import 'package:lodgify/services/network/resources/end_points.dart';
import 'package:lodgify/services/network/resources/response_network.dart';
import 'package:lodgify/services/network/resources/status_code.dart';

class GroupNetworkRepo implements IGroupNetworkRepo {
  List<GroupDto> _decodeGroups(String source) {
    final list = json.decode(source);
    return List<GroupDto>.from(list?.map((x) => GroupDto.fromMap(x)));
  }

  @override
  Future<ResponseNetwork<List<GroupDto>>> getGroups() async {
    final uri = Uri.parse(EndPoints.groups);
    try {
      final response = await get(uri);

      if (response.statusCode == StatusCode.ok) {
        return ResponseNetwork(data: _decodeGroups(response.body));
      }

      return ResponseNetwork(error: true);
    } on Exception catch (e) {
      return ResponseNetwork(
        error: true,
        message: e.toString(),
      );
    }
  }
}
