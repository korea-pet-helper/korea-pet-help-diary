
//state class
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/pet.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/data/repository/user_repository.dart';

class FixState {
  bool isFixing;
  FixState(this.isFixing);
}

//VM
//Todo: method for updating localCodes for each 'local' should be implemented
class ProfileFixViewModel extends AutoDisposeFamilyNotifier<FixState, User?>{
  @override
  FixState build(User? arg) {
    return FixState(false);
  }

  //under updating
  //double check if done correctly
  Future<bool> reset({
    //String userId,
    required String imageUrl,
    required String local,
    required String localCode,
    required String nickname,
    //required String password,
    required Pet pet,
  }) async{
    final userRepository = UserRepository();

    //adding loading
    state = FixState(true);

    //when fresh start
    if(arg == null) {
      final result = await userRepository.insert(
        nickname: nickname,
        local: local,
        localCode: localCode,
        imageUrl: imageUrl,
        pet: pet,
        userId: arg!.userId,
        //adding phone here for future extensions
        //phone: phone,
      );
      state = FixState(false);
      await Future.delayed(const Duration(microseconds: 500));
      return result;

    }else{
      //if instance already exists
      final result = await userRepository.update(
        userId: arg!.userId,
        nickname: nickname,
        local: local,
        localCode: localCode,
        imageUrl: imageUrl,
        pet: pet,
      );
      state = FixState(false);
      await Future.delayed(const Duration(milliseconds: 300));
      return result;
    }
  }
}
//VM admin
final profileFixViewModelProvider = NotifierProvider.autoDispose.family<ProfileFixViewModel,FixState, User?>(
  (){
    return ProfileFixViewModel();
  }
);
