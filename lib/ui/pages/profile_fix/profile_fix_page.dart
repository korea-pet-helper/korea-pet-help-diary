
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:korea_pet_help_diary/data/model/pet.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/ui/pages/home/home_page.dart';
import 'package:korea_pet_help_diary/ui/pages/profile_fix/profile_fix_view_model.dart';
import 'package:korea_pet_help_diary/ui/pages/theme/theme.dart';
import 'package:korea_pet_help_diary/util/geolocator_helper.dart';

class ProfileFixPage extends ConsumerStatefulWidget{
  ProfileFixPage(this.user);

  User? user;

  @override
  ConsumerState<ProfileFixPage> createState() => _ProfileFixPageState();
}

class _ProfileFixPageState extends ConsumerState<ProfileFixPage> {
  late TextEditingController nickNameController = TextEditingController(text: widget.user?.nickname ?? "");
  late TextEditingController charactersController = TextEditingController(text: widget.user?.pet.petInformation ?? "");
  //late TextEditingController myNeighborController = TextEditingController(text: widget.user?.local ?? ""); //fix this to searching later

  late Map<String, dynamic> location = GeolocatorHelper.getAdministrativeArea() as Map<String, dynamic>;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isDog = true;
  bool isCat = false;
  late List<bool> isSelected;


  @override
  void initState() {
    // TODO: implement initState
    isSelected = [isDog, isCat];
    super.initState();
  }

  @override
  void dispose() {
    nickNameController.dispose();
    charactersController.dispose();
    //myNeighborController.dispose();
    super.dispose();
  }

  void toggleSelect(value) {
    if (value == 0) {
      isDog = true;
      isCat = false;
    } else {
      isDog = false;
      isCat = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    final fixState = ref.watch(profileFixViewModelProvider(widget.user));
    if (fixState.isFixing) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    bool tapState;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('한반도'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //profile image
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                
                child: Container(
                  //image file with overlapping icon
                ),
              ),
              //box with information
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      '닉네임',
                    ),
                    TextFormField(
                      controller: nickNameController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(hintText: '바둑이'),
                      validator: (value){
                        if (value?.trim().isEmpty ?? true) {
                          return '닉네임을 입력하세요';
                        }
                        return null;
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: isSelected,
                          onPressed:toggleSelect,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:16),
                              child: Text("개", style: TextStyle(fontSize: 12)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("고양이", style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),

                      ]
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      '반려동물 성격',
                    ),
                    TextFormField(
                      controller: charactersController,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(hintText: '착하고 순해요'),
                      validator: (value) {
                        if(value?.trim().isEmpty ?? true) {
                          return '반려동물의 성격을 하나 이상 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '내 동네',
                      style: TextStyle(
                        fontSize: 12
                      ),
                    ),
                    GestureDetector(
                      
                      onTap: () {
                        tapState = true;  
                      },
                      child: SizedBox(
                        height: 50,
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //making the icon to go to the left
                            const SizedBox(height: 50,width: 50, child: Icon(Icons.location_on_outlined)),
                            Text(
                              location['name'], 
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                              ),),
                          ],
                        ),
                      ),
                    );
                    // TextFormField(
                    //   controller: myNeighborController,
                    //   textInputAction: TextInputAction.done,
                    //   decoration: const InputDecoration(hintText: '서울시 용산구 한강대로 100'),
                    //   validator: (value) {
                    //     if(value?.trim().isEmpty ?? true) {
                    //       return '지역을 입력해주세요';
                    //     }
                    //     return null;
                    //   },
                      //adding the icon to the right
                    ),
                  ],
                ),
              ),
              //empty gap
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = _formKey.currentState?.validate() ?? false;
                  if (result) {
                    final vm = ref.read(profileFixViewModelProvider(widget.user).notifier);
                    final resetResult = await vm.reset(
                      //userId: '',
                      imageUrl: '', //ToDo: needs fix
                      local: ,
                      localCode: '', //ToDo: needs fix
                      //password: '',
                      nickname: nickNameController.text,
                      //phone: '',
                      pet: Pet(petInformation: charactersController.text),
                    );
                    if(resetResult) {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HomePage(user: '');//this needs to be filled
                      }));
                    },
                    }
                  }
                child: const Text("수정하기"),
              ),
            ],   
          
          ),
        ),
      ),
    );
  }
}