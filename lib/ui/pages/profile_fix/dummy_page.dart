import 'package:flutter/material.dart';
import 'package:korea_pet_help_diary/ui/pages/join/wigets/join_image_picker_ui.dart';

class DummyPage extends StatefulWidget {
  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  JoinImagePickerUi joinImagePickerUi = JoinImagePickerUi();

  bool isDog = true;

  bool isCat = false;

  List<bool> isSelected = [true,false];
// = [true,false];
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("한반도"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Container(
                  height: 50,
                  width: 50,
                  child: Stack(
                    children: [
                      Image.asset('assets/images/welcome.png', height: 60,width: 60,),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(Icons.camera),
                      ),
                    ],
                  ),
                ), 

              ),
            
          
              SizedBox(
                height: 600,
                width: 440,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      style: TextStyle(fontSize: 12),
                      '닉네임',
                    ),
                    //textformfield alternative
                    SizedBox(height: 44, width: double.infinity,),
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
                    //alternative to textformfield
                    SizedBox(height: 44, width: double.infinity,),
                    const SizedBox(height: 5,),
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
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(Icons.location_on_outlined),
                            ),
                            Text(
                              "서울시청",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: (){},
                  child: const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Text("수정하기"),
                  ), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}