import '../../app_module/home_screen/model/text_search_place_model.dart';
import '../../main.dart';
import '../../utils/constant/storage_constant.dart';

class SavePlace{
  // Singleton instance
  static final SavePlace instance = SavePlace._internal();
  // Private constructor
  SavePlace._internal();
  // Public factory constructor
  factory SavePlace() => instance;
  //####################### google place locally save/read #########################
  void saveGooglePaceData(TextSearchPlaceModel data) async {
    Map<String, dynamic> dataToJson = data.toJson();
    List<Map<String, dynamic>> getStorageData =
        (await googleSaveBox.read(StorageConst.googleSave))?.cast<Map<String, dynamic>>() ?? [];

    getStorageData.insert(0, dataToJson);

    await googleSaveBox.write(StorageConst.googleSave, getStorageData);


  }
  void deleteGooglePlaceData(String globalCode) async {
    List<Map<String, dynamic>> getStorageData =
        (await googleSaveBox.read(StorageConst.googleSave))?.cast<Map<String, dynamic>>() ?? [];

    getStorageData.removeWhere((element) {
      String? savedCode = element['place_id'];
      return savedCode == globalCode;
    });

    // Write updated list back
    await googleSaveBox.write(StorageConst.googleSave, getStorageData);
  }

   Future<void> togglePlusCodeGooglePlace(String code,TextSearchPlaceModel data) async {
    List<String> getStorageData =
        (await googleSaveBox.read(StorageConst.googleSavePlusCode))?.cast<String>() ?? [];


    if (getStorageData.contains(code)) {
      getStorageData.remove(code);
      deleteGooglePlaceData(code);

    } else {
      getStorageData.insert(0, code);
      saveGooglePaceData(data);
    }

    await googleSaveBox.write(StorageConst.googleSavePlusCode, getStorageData);

  }

  Future<List<TextSearchPlaceModel>> readGooglePaceData() async {
    List<Map<String, dynamic>>? data = await googleSaveBox.read(StorageConst.googleSave);

    if (data == null) return [];
    List<TextSearchPlaceModel> dataSend = data.map((e) => TextSearchPlaceModel.fromJson(e)).toList();
    return dataSend;
  }
  Future<List<String>> readGooglePlusCode() async {
    List<String>? data = await googleSaveBox.read(StorageConst.googleSavePlusCode);

    if (data == null) return [];
    return data;
  }

//####################### post place locally save/read #########################
  void savePostPaceData(Map<String, dynamic> data) async {
    List<Map<String, dynamic>> getStorageData =
        (await googleSaveBox.read(StorageConst.postSave))?.cast<Map<String, dynamic>>() ?? [];

    final newPlaceName = data["placeName"];
    final newAddress = data["location"]?["address"];

    // Remove old entry if the same placeName and address already exists
    getStorageData.removeWhere((place) {
      final existingPlaceName = place["placeName"];
      final existingAddress = place["location"]?["address"];
      return existingPlaceName == newPlaceName && existingAddress == newAddress;
    });

    // Add new place at the top
    getStorageData.insert(0, data);

    // Write back updated list
    await googleSaveBox.write(StorageConst.postSave, getStorageData);
  }
  void deleteSavedPlace(String placeName, String address) async {
    List<Map<String, dynamic>> getStorageData =
        (await googleSaveBox.read(StorageConst.postSave))?.cast<Map<String, dynamic>>() ?? [];

    // Remove the matching place
    getStorageData.removeWhere((place) {
      final existingPlaceName = place["placeName"];
      final existingAddress = place["location"]?["address"];
      return existingPlaceName == placeName && existingAddress == address;
    });

    // Write updated list back
    await googleSaveBox.write(StorageConst.postSave, getStorageData);
  }
  Future<List<Map<String, dynamic>>> readPostPaceData() async {
    List<Map<String, dynamic>>? data = await googleSaveBox.read(StorageConst.postSave);

    if (data == null) return [];
      return data;
  }
}