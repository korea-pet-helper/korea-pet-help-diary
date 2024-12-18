import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/data/repository/user_repository.dart';

class UserGlobalViewModel extends FamilyNotifier<User?, String> {
  @override
  User? build(String arg) {
    fetchUserInfo();
    return null;
  }

  final userRepo = UserRepository();

  Future<void> fetchUserInfo() async {
    final user = await userRepo.getUser(arg);

    state = user;
  }
}

final userGlobalViewModelProvider =
    NotifierProvider.family<UserGlobalViewModel, User?, String>(
  () {
    return UserGlobalViewModel();
  },
);
