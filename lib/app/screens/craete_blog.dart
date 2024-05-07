import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_blog/app/utils/size_config.dart';

import '../service/home/repository.dart';
import '../utils/constants.dart';
import '../utils/reusables.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key, this.body, this.id, this.title, this.subTitle});
  final String? body;
  final String? id;
  final String? title;
  final String? subTitle;

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
   final _titleCtrl = TextEditingController();
   final _subTitleCtrl = TextEditingController();
   final _bodyCtrl = TextEditingController();

  final _key = GlobalKey<FormState>();
  bool _isLoading = false;

  final repo = HomeRepository();
  Future<void> createBlog(BuildContext context) async {
    final result = await repo.createBlog(
      title: _titleCtrl.text,
      subtitle: _subTitleCtrl.text,
      body: _bodyCtrl.text,
    );
    result.fold((l) => kToastMsgPopUp(context, message: l),
        (r) => Navigator.pop(context));
  }

  Future<void> updateBlog(BuildContext context, {required String id}) async {
    final result = await repo.updateBlog(
      title: _titleCtrl.text,
      subtitle: _subTitleCtrl.text,
      body: _bodyCtrl.text,
      bodyId: id,
    );
    result.fold((l) => kToastMsgPopUp(context, message: l),
        (r) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    // final argument = ModalRoute.of(context)?.settings.arguments as Map;
    // final check = argument.isEmpty;
    final argument = ModalRoute.of(context)?.settings.arguments as Map?;
    final check = argument == null || argument.isEmpty;
    String? title = argument?["title"] as String?;
    String? subTitle = argument?["subTitle"] as String?;
    String? body = argument?["body"] as String?;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: getScreenWidth(24),
            right: getScreenWidth(24),
            top: getScreenHeight(24),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Palette.k1E,
                        size: 24,
                      )),
                  SizedBox(
                    height: getScreenHeight(15),
                  ),
                  CustomText(
                      text: check ? "Create New Blog" : "Update New Blog",
                      color: Colors.black,
                      size: 24,
                      font: FontFamily.kSemiBold,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500),
                  SizedBox(
                    height: getScreenHeight(20),
                  ),
                  const CustomText(
                      text: "Please enter the following details",
                      color: Colors.black,
                      size: 14,
                      font: FontFamily.kRegular,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: getScreenHeight(20),
                  ),
                  CustomInputField(
                    inputController: _titleCtrl..text=title??'',
                    inputHintText: '',
                    header: 'Title',
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: getScreenHeight(20),
                  ),
                  CustomInputField(
                    inputController: _subTitleCtrl..text = subTitle??'',
                    inputHintText: '',
                    header: 'Subtitle',
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: getScreenHeight(20),
                  ),
                  CustomInputField(
                    inputController: _bodyCtrl..text =body??'',
                    inputHintText: '',
                    header: 'Body',
                    maxLine: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(
                    height: getScreenHeight(30),
                  ),
                  CustomButton(
                      isLoading: _isLoading,
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          if (check) {
                            createBlog(context).then((_) {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                          } else {
                            updateBlog(context, id: argument["id"]).then((_) {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                          }
                        }
                      },
                      color: Palette.kPrimary,
                      text: check ? 'Create' : 'Update',
                      textColor: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
