
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/ui/pages/home/home_page.dart';
import 'package:korea_pet_help_diary/ui/pages/theme/theme.dart';

class ProfileFixPage extends ConsumerStatefulWidget{
  ProfileFixPage(this.user);

  User? user;

  @override
  ConsumerState<ProfileFixPage> createState() => _ProfileFixPageState();
}

class _ProfileFixPageState extends ConsumerState<ProfileFixPage> {
  late TextEditingController nickNameController = TextEditingController(text: widget.user?.nickname ?? "");
  late TextEditingController charactersController = TextEditingController(text: widget.user?.character ?? "");
  late TextEditingController myNeighborController = TextEditingController(text: widget.user?.local); //fix this to searching later

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nickNameController.dispose();
    charactersController.dispose();
    myNeighborController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(),
                        ElevatedButton(),
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
                    TextFormField(
                      controller: myNeighborController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(hintText: '서울시 용산구 한강대로 100'),
                      validator: (value) {
                        if(value?.trim().isEmpty ?? true) {
                          return '지역을 입력해주세요';
                        }
                        return null;
                      },
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return HomePage();//this needs to be filled
                  }))
                },
                child: Text("수정하기"),
              ),
            ],   
          
          ),
        ),
      ),
    );
  }
}