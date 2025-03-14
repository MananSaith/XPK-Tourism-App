import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

enum APIMethod { get, post, put, patch, delete }

class ApiManager extends GetConnect {
  ApiManager._privateConstructor();

  static ApiManager get instance => _instance;

  static final ApiManager _instance = ApiManager._privateConstructor();

  factory ApiManager() {
    return _instance;
  }

  Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  Future<dynamic> requestAPi(String endPoint,
      {String baseUrl = ApiConstant.baseUrl,
      APIMethod method = APIMethod.post,
      Map? data,
      bool isAuthenticated = true,
      dio.FormData? multiPartData,
      bool isMultiPart = false}) async {
    debugPrint('requestAPi');

    var isInternet = await internetConnectivity();

    debugPrint('requestAPi $isInternet');
    if (isInternet) {
      final url = baseUrl + endPoint;

      debugPrint(url);



      debugPrint("*******************************************");
      debugPrint("URL : ");
      debugPrint(url);
      debugPrint("*******************************************");
      debugPrint("*******************************************");
      debugPrint("Data : ");
      if (isMultiPart) {
        debugPrint((multiPartData!.fields).toString());
      } else {
        debugPrint((data).toString());
      }

      debugPrint("*******************************************");
      dio.Dio().options.headers['content-Type'] = 'application/json';
      var options = Options(
          headers: {
            "Content-Type": isMultiPart
                ? "multipart/form-data; boundary=<calculated when request is sent>"
                : "application/json",
            "Accept": "application/json",
            "Authorization": null,
          },
          validateStatus: ((status) {
            return status! <= 500;
          }));

      dio.Response response;
      try {
        switch (method) {
          case APIMethod.get:
            response = await dio.Dio().get(url, options: options);
            debugPrint('this is response $endPoint $response');
            break;
          case APIMethod.post:
            response = await dio.Dio().post(url,
                data: isMultiPart ? multiPartData : data, options: options);
            debugPrint('this is response $endPoint $response');
            break;
          case APIMethod.put:
            response = await dio.Dio().put(url,
                data: isMultiPart ? multiPartData : data, options: options);
            debugPrint('this is response $endPoint $response');
            break;
          case APIMethod.patch:
            response = await dio.Dio().patch(url,
                data: isMultiPart ? multiPartData : data, options: options);
            debugPrint('this is response $endPoint $response');
            break;
          case APIMethod.delete:
            response = await dio.Dio().delete(url,
                data: isMultiPart ? multiPartData : data, options: options);
            debugPrint('this is response $endPoint $response');
            break;
        }
        return response.toString();
        // return _handleResponse(response);
        // return _handleResponse(response);
      } on DioException catch (e) {
        // _handleResponse(response);
        appToastView(title: "${e.message}");
        debugPrint("dio error:  ${e.message}");
        // appToastView(title: _handleResponse(response));
      } catch (e) {
        // appToastView(title: e.toString());

        appToastView(title: e.toString());
        debugPrint('ApiManager - catch - $e');
      }
    } else {
      appToastView(title: 'No internet Connection');
    } // return "Connection Error..!!";
  }

  String _handleResponse(var response) {
    int statusCode = response.statusCode;
    bool isSuccessful = statusCode >= 200 && statusCode < 300;
    String error = '';
    if (!isSuccessful) {
      switch (statusCode) {
        case HttpStatus.movedPermanently:
        case HttpStatus.movedTemporarily:
          error =
              "The endpoint to this API has been changed, please consider to update it.";
          break;
        case HttpStatus.badRequest:
          error =
              "Please check your request and make sure you are posting a valid data body.";
          break;
        case HttpStatus.unauthorized:
          error = "This API needs to be authenticated with a Bearer token.";
          break;
        case HttpStatus.forbidden:
          error = "You are not allowed to call this API.";
          break;
        case HttpStatus.unprocessableEntity:
          error = "Provided credentials are not valid.";
          break;
        case HttpStatus.tooManyRequests:
          error =
              "You are requesting the APIs too often, please don't call the API(s) unnecessarily";
          break;
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
        case HttpStatus.serviceUnavailable:
          error = "Server is not responding, please try again later!";
          break;
        default:
          error = "Something went wrong, please try again later!";
      }
    }
    return error;
  }
}





// import 'package:dio/dio.dart' as dio;
// import 'package:get/get.dart';
// import 'package:xpk/utils/imports/app_imports.dart';

// enum APIMethod { get, post, put, patch, delete }

// class ApiManager extends GetConnect {
//   ApiManager._privateConstructor();

//   static ApiManager get instance => _instance;

//   static final ApiManager _instance = ApiManager._privateConstructor();

//   factory ApiManager() {
//     return _instance;
//   }

//   Future<bool> internetConnectivity() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//     return false;
//   }

//   Future<dynamic> requestAPi(String endPoint,
//       {String baseUrl = ApiConstant.baseUrl,
//       APIMethod method = APIMethod.post,
//       Map? data,
//       bool isAuthenticated = true,
//       dio.FormData? multiPartData,
//       bool isMultiPart = false}) async {
//     debugPrint('requestAPi');

//     var isInternet = await internetConnectivity();

//     debugPrint('requestAPi $isInternet');
//     if (isInternet) {
//       final url = baseUrl + endPoint;

//       debugPrint(url);
//       var loggedInData = storageBox.read(StorageConstants.userData);

//       if (loggedInData != null) {
//         debugPrint('Token: ${loggedInData['token']}');
//       } else {
//         debugPrint('No Token Found');
//       }


//       debugPrint("*******************************************");
//       debugPrint("URL : ");
//       debugPrint(url);
//       debugPrint("*******************************************");
//       debugPrint("Header : ");
//       // debugPrint(headers);
//       debugPrint("*******************************************");
//       debugPrint("Data : ");
//       if (isMultiPart) {
//         debugPrint((multiPartData!.fields).toString());
//       } else {
//         debugPrint((data).toString());
//       }

//       debugPrint("*******************************************");
//       dio.Dio().options.headers['content-Type'] = 'application/json';
//       var options = Options(
//           headers: {
//             "Content-Type": isMultiPart
//                 ? "multipart/form-data; boundary=<calculated when request is sent>"
//                 : "application/json",
//             "Accept": "application/json",
//             "Authorization": loggedInData == null
//                 ? ''
//                 : 'Bearer ${loggedInData['token']}',
//           },
//           validateStatus: ((status) {
//             return status! <= 500;
//           }));

//       dio.Response response;
//       try {
//         switch (method) {
//           case APIMethod.get:
//             response = await dio.Dio().get(url, options: options);
//             debugPrint('this is response $endPoint $response');
//             break;
//           case APIMethod.post:
//             response = await dio.Dio().post(url,
//                 data: isMultiPart ? multiPartData : data, options: options);
//             debugPrint('this is response $endPoint $response');
//             break;
//           case APIMethod.put:
//             response = await dio.Dio().put(url,
//                 data: isMultiPart ? multiPartData : data, options: options);
//             debugPrint('this is response $endPoint $response');
//             break;
//           case APIMethod.patch:
//             response = await dio.Dio().patch(url,
//                 data: isMultiPart ? multiPartData : data, options: options);
//             debugPrint('this is response $endPoint $response');
//             break;
//           case APIMethod.delete:
//             response = await dio.Dio().delete(url,
//                 data: isMultiPart ? multiPartData : data, options: options);
//             debugPrint('this is response $endPoint $response');
//             break;
//         }
//         return response.toString();
//         // return _handleResponse(response);
//         // return _handleResponse(response);
//       } on DioException catch (e) {
//         // _handleResponse(response);
//         appToastView(title: "${e.message}");
//         debugPrint("dio error:  ${e.message}");
//         // appToastView(title: _handleResponse(response));
//       } catch (e) {
//         // appToastView(title: e.toString());

//         appToastView(title: e.toString());
//         debugPrint('ApiManager - catch - $e');
//       }
//     } else {
//       appToastView(title: 'No internet Connection');
//     } // return "Connection Error..!!";
//   }

//   String _handleResponse(var response) {
//     int statusCode = response.statusCode;
//     bool isSuccessful = statusCode >= 200 && statusCode < 300;
//     String error = '';
//     if (!isSuccessful) {
//       switch (statusCode) {
//         case HttpStatus.movedPermanently:
//         case HttpStatus.movedTemporarily:
//           error =
//               "The endpoint to this API has been changed, please consider to update it.";
//           break;
//         case HttpStatus.badRequest:
//           error =
//               "Please check your request and make sure you are posting a valid data body.";
//           break;
//         case HttpStatus.unauthorized:
//           error = "This API needs to be authenticated with a Bearer token.";
//           break;
//         case HttpStatus.forbidden:
//           error = "You are not allowed to call this API.";
//           break;
//         case HttpStatus.unprocessableEntity:
//           error = "Provided credentials are not valid.";
//           break;
//         case HttpStatus.tooManyRequests:
//           error =
//               "You are requesting the APIs too often, please don't call the API(s) unnecessarily";
//           break;
//         case HttpStatus.internalServerError:
//         case HttpStatus.badGateway:
//         case HttpStatus.serviceUnavailable:
//           error = "Server is not responding, please try again later!";
//           break;
//         default:
//           error = "Something went wrong, please try again later!";
//       }
//     }
//     return error;
//   }
// }
