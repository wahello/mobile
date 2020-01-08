import 'package:football_system/blocs/addForm/index.dart';
import 'package:http/http.dart' as http;

class AddFormRepository {
  static final AddFormRepository _addFormRepository =
      AddFormRepository._internal();
  factory AddFormRepository() {
    return _addFormRepository;
  }
  AddFormRepository._internal();

  Future<http.Response> sendData(List<AddFormModel> dataToSend, TypeAddForm type, String categoryId, String teamId) async {
    return await AddFormProvider().sendData(dataToSend, type, categoryId,teamId);
  }
}
