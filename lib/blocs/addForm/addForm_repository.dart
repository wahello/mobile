import 'package:football_system/blocs/addForm/addFormModel.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/addForm/addForm_provider.dart';

class AddFormRepository {
  static final AddFormRepository _addFormRepository =
      AddFormRepository._internal();
  factory AddFormRepository() {
    return _addFormRepository;
  }
  AddFormRepository._internal();

  Future sendData(List<AddFormModel> dataToSend, TypeAddForm type, String categoryId, String teamId) async {
    await AddFormProvider().sendData(dataToSend, type, categoryId,teamId);
  }
}
