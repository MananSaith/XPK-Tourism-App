import 'package:get/get.dart';
import 'package:xpk/app_module/detail_screen/model/detail_place_model.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class DetailPlaceController extends GetxController {
  RxList<DetailAboutPlace> detailPlaceList = <DetailAboutPlace>[].obs;
  final controllerPage = PageController(viewportFraction: 0.8, keepPage: true);

  RxBool isPageLoad = false.obs;

  Future<Map<String, dynamic>> placeDetailRequrst(
      {required String PlaceId}) async {
    isPageLoad(true);
    detailPlaceList.clear();

    try {
      Map<String, dynamic> data =
          await MapsService().detailAboutPlace(placeId: PlaceId);
      List<Map<String, dynamic>> dataList = [data];

      detailPlaceList.assignAll(
          dataList.map((data) => DetailAboutPlace.fromJson(data)).toList());
      if (detailPlaceList.length > 0) {
        return {"status": 200};
      } else {
        return {"status": 404};
      }
    } catch (e) {
      debugPrint("Error in Place Detail: $e");
      return {"status": 404};
    } finally {
      isPageLoad(false);
    }
  }
}
