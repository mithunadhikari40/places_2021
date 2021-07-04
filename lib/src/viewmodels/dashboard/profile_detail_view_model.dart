import 'package:places/src/core/base_view_model.dart';
import 'package:places/src/model/user_model.dart';
import 'package:places/src/services/dashboard/profile_detail_service.dart';

class ProfileDetailViewModel extends BaseViewModel {
  final ProfileDetailService service;

  ProfileDetailViewModel({required this.service});

  UserModel get currentUser => service.currentUser;

 Future<bool> logout() {
   return service.logout();
 }
}
