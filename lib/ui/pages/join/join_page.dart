import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:korea_pet_help_diary/data/model/pet.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/data/repository/user_repository.dart';
import 'package:korea_pet_help_diary/util/geolocator_helper.dart';
import 'package:korea_pet_help_diary/ui/pages/join/wigets/join_image_picker_ui.dart';
import 'package:korea_pet_help_diary/ui/pages/join/wigets/join_textfeild_method.dart';
import 'package:korea_pet_help_diary/util/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends ConsumerState<JoinPage> {
  String idError = '';
  String nameError = '';

  String passwordError = '';
  String passwordCheckError = '';
  String phoneError = '';
  String localCode = '';

  //정상 작성여부 확인
  bool imagePass = false;
  bool idPass = false;
  bool idCheckPass = false;
  bool namePass = false;
  bool passwordPass = false;
  bool passwprd2Pass = false;
  bool phonePass = false;
  bool localPass = false;

//텍스트 에디팅 컨트롤러 선언.
  TextEditingController idTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController password2TextEditingController =
      TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController localTextEditingController = TextEditingController();

  XFile? selectedImage;
  String? uploadedImageUrl;

  @override
  void dispose() {
    idTextEditingController.dispose();
    nameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    password2TextEditingController.dispose();
    phoneTextEditingController.dispose();
    localTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //텍스트 필드 그려주는 클래스에 접근근
    JoinTextfeildMethod joinTextfeildMethod = JoinTextfeildMethod();
    JoinImagePickerUi joinImagePickerUi = JoinImagePickerUi();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      //언포커스를 하기 위한 제스쳐디텍터
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 1200,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? xfile = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (xfile != null) {
                          setState(() {
                            selectedImage = xfile;
                            imagePass = true;
                          });
                        }
                      },
                      child: joinImagePickerUi.imagePickerUi(selectedImage),
                    ),
                    const SizedBox(height: 20),
                    joinTextfeildMethod.buildInputField(
                      title: '아이디',
                      hintText: '아이디를 입력해 주세요',
                      textEditingController: idTextEditingController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (value.length < 5) {
                            idError = '아이디는 최소 5자 이상이어야 합니다.';
                          } else {
                            idError = '';
                            idPass = true;
                          }
                        });
                      },
                      errorText: idError,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (idTextEditingController.text.length >= 5) {
                          String userId = idTextEditingController.text
                              .trim(); // 입력된 아이디 가져오기

                          if (userId.isEmpty) {
                            // 아이디가 비어있을 경우 에러 처리
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('아이디를 입력해주세요.'),
                            ));
                            return;
                          }

                          // Firestore에서 해당 아이디 문서 조회
                          DocumentSnapshot userDoc = await FirebaseFirestore
                              .instance
                              .collection('Users')
                              .doc(userId)
                              .get();

                          setState(() {
                            if (userDoc.exists) {
                              //문서 존재여부 확인_false : 없음
                              // 이미 해당 아이디가 존재할 경우
                              idError = '이미 사용 중인 아이디입니다.';
                              idCheckPass = false;
                            } else {
                              // 해당 아이디를 사용할 수 있는 경우
                              idError = '사용 가능한 아이디입니다.';
                              idCheckPass = true;
                            }
                          });
                        }
                      },
                      child: Container(
                        //아이디 중복 체크 ui
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            '아이디 중복 체크',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    joinTextfeildMethod.buildInputField(
                      title: '닉네임',
                      hintText: '닉네임을 입력해 주세요',
                      textEditingController: nameTextEditingController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (value.length < 1) {
                            nameError = '닉네임은 최소 1자 이상이어야 합니다.';
                          } else {
                            nameError = '';
                            namePass = true;
                          }
                        });
                      },
                      errorText: nameError,
                    ),
                    joinTextfeildMethod.buildInputField(
                      title: '비밀번호',
                      hintText: '비밀번호를 입력해 주세요',
                      textEditingController: passwordTextEditingController,
                      obscureText: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16), // 최대 글자수 제한
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (value.length < 4) {
                            passwordError = '비밀번호는 최소 4자 이상이어야 합니다.';
                          } else {
                            passwordError = '';
                            passwordPass = true;
                          }
                        });
                      },
                      errorText: passwordError,
                    ),
                    joinTextfeildMethod.buildInputField(
                      title: '비밀번호확인',
                      hintText: '비밀번호를 다시 입력해 주세요',
                      textEditingController: password2TextEditingController,
                      obscureText: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (passwordTextEditingController.text !=
                              password2TextEditingController.text) {
                            passwordCheckError = '입력하신 비밀번호가 다릅니다.';
                          } else {
                            passwordCheckError = '';
                            passwprd2Pass = true;
                          }
                        });
                      },
                      errorText: passwordCheckError,
                    ),
                    joinTextfeildMethod.buildInputField(
                      title: '전화번호',
                      hintText: '000-0000-0000',
                      textEditingController: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능
                        PhoneNumberFormatter(), // 전화번호 형식 지정
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (phoneTextEditingController.text.length < 13) {
                            phoneError = '전화번호를 올바르게 입력해주세요.';
                          } else {
                            phoneError = '';
                            phonePass = true;
                          }
                        });
                      },
                      errorText: phoneError,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                '주소',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: GestureDetector(
                                    onTap: () async {
                                      // GeolocatorHelper에서 행정구역 정보를 가져오기
                                      Map<String, dynamic>? localMap =
                                          await GeolocatorHelper
                                              .getAdministrativeArea();
                                      print(localMap!['name']);

                                      setState(() {
                                        // 반환된 localName을 TextEditingController의 text에 반영
                                        if (localMap['name'] != null) {
                                          localTextEditingController.text =
                                              localMap['name'];
                                          localCode = localMap['code'];
                                          localPass = true;
                                        } else {
                                          localTextEditingController.text =
                                              "주소를 가져오지 못했습니다.";
                                        }
                                      });
                                    },
                                    child: const Icon(Icons.gps_fixed)),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: localTextEditingController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 11,
                              ),
                              hintText: 'GPS 아이콘을 터치해주세요.',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: imagePass &&
                              idPass &&
                              namePass &&
                              passwordPass &&
                              passwprd2Pass &&
                              phonePass &&
                              localPass
                          ? () async {
                              final userRepo = UserRepository();
                              // Firebase Storage에 이미지 업로드
                              String url = await userRepo
                                  .uploadImageToFirebase(selectedImage!);
                              setState(() {
                                uploadedImageUrl = url; // 업로드된 URL 저장
                              });
                              try {
                                await userRepo.saveUserData(
                                  User(
                                    userId: idTextEditingController.text.trim(),
                                    image: url, // 이미지 경로
                                    local:
                                        localTextEditingController.text.trim(),
                                    localCode: localCode,
                                    nickname:
                                        nameTextEditingController.text.trim(),
                                    password: passwordTextEditingController.text
                                        .trim(),
                                    phone:
                                        phoneTextEditingController.text.trim(),
                                    chatRoomIds: [],
                                    pet: Pet(
                                      petAge: 0,
                                      petName: '',
                                      petDogCat: '',
                                      petInformation: '',
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('회원가입이 완료되었습니다! 로그인 해주세요.'),
                                ));
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('회원가입 중 오류가 발생했습니다: $e'),
                                ));
                              }
                            }
                          : null,
                      child: const Text(
                        '가입하기',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
