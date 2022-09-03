// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// enum StorageKeys {
//   language,
//   categoryList,
//   productList,
//   info
// }
//
// class StorageService {
//   static GetStorage storage = GetStorage();
//
//   static StorageService get to => Get.find<StorageService>();
//
//   static Future<void> init() async{
//     await Get.putAsync<StorageService>(
//           ()  async{
//             final storageService = StorageService();
//             await GetStorage.init();
//             return storageService;
//           },
//       permanent: true,
//     );
//   }
//
//   Future<void> setData<T>(StorageKeys key, T value) async {
//     await storage.write(key.name, value);
//   }
//
//   T? getData<T>(StorageKeys key) {
//     return storage.read(key.name);
//   }
//
//   Future<void> deleteData(StorageKeys key) async {
//     await storage.remove(key.name);
//   }
//
//   checkData(StorageKeys key){
//     bool isExist = storage.hasData(key.name);
//     return isExist;
//   }
//
// }