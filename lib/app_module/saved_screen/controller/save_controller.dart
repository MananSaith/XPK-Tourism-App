import 'package:get/get.dart';

import '../../../config/server/save_nosql_data.dart';
import '../../home_screen/model/text_search_place_model.dart';

class SaveController extends GetxController{

  RxList<TextSearchPlaceModel> googleList = <TextSearchPlaceModel>[].obs;
  RxList<Map<String, dynamic>> PostList = <Map<String, dynamic>>[].obs;
  RxList<String> plusCodeGoogleList = <String>[].obs;

  @override
  void onInit(){
    super.onInit();
    readGooglePlusCode();
    getGoogleSavePlace();
    readPostPaceData();

  }
  void getGoogleSavePlace()async{
    googleList.value=[];
    googleList.value =     await SavePlace.instance.readGooglePaceData();
  }
  RxBool isGoogleListLoading = true.obs;

  void readGooglePlusCode() async {
    isGoogleListLoading.value = true;
    plusCodeGoogleList.value=[];
    plusCodeGoogleList.value = await SavePlace.instance.readGooglePlusCode();
    getGoogleSavePlace();
    isGoogleListLoading.value = false;
  }


  void readPostPaceData()async{
    PostList.value =     await SavePlace.instance.readPostPaceData();
  }


}