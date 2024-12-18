
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

  //Map<String, dynamic>? location = GeolocatorHelper.getAdministrativeArea().then();
  Map<String, String> location = {'name': '서울시청'}; //dummy

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
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 22.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //profile image
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      
                      child: Container(
                        //image file with overlapping icon
                        //ToDo: make it a gesture detector for the image
                        height: 80,
                        width: 80,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/welcome.png', height: 60,width: 60,),
                            const Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(Icons.camera),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //box with information
                    SizedBox(
                      height: 500,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color: Colors.black.withOpacity(0.6),
                                  selectedColor: Colors.white,
                                  fillColor: Colors.black,
                                  splashColor: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                  isSelected: isSelected,
                                  onPressed:toggleSelect,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal:10),
                                      child: const SizedBox(
                                        height:double.infinity,
                                        child: Text("개", style: TextStyle(fontSize: 12)),),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal:10),
                                      child: const SizedBox(
                                        height:double.infinity,
                                        child: Text("고양이", style: TextStyle(fontSize: 12)),),
                                    ),
                                  ],
                                ),
                                      
                              ],
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
                              },
                              child: SizedBox(
                                height: 50,
                                width: 250,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //making the icon to go to the left
                                    const SizedBox(height: 50,width: 50, child: Icon(Icons.location_on_outlined)),
                                    Text(
                                      "서울시청",//location['name'], 
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200,
                                      ),),
                                  ],
                                ),
                              ),
                            ),
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
                            
                          ],
                          ),
                      ),
                    ),
                    //empty gap
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = _formKey.currentState?.validate() ?? false;
                          if (result) {
                            final vm = ref.read(profileFixViewModelProvider(widget.user).notifier);
                            final resetResult = await vm.reset(
                              //userId: '',
                              imageUrl: '', //ToDo: needs fix
                              local: "서울시청",
                              localCode: "28260122", //ToDo: needs fix
                              //password: '',
                              nickname: nickNameController.text,
                              //phone: '',
                              pet: Pet(petInformation: charactersController.text),
                            );
                            if(resetResult) {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return HomePage(user: Sample);//this needs to be filled
                              }));
                            };
                            }
                        },
                        child: const SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Text("수정하기")),
                      ),
                    ),
                  ],   
                
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

User Sample = User(userId: 'wwwwww', image: "", local: "인천광역시 서구 청라동", localCode: "28260122", nickname: 'ㅂㅂㅂㅂㅂ', password: "qqqqq", phone: '111', pet: Pet(petAge: 0, petDogCat: ",", petInformation: "", petName: ""));