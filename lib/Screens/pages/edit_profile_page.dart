import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/models/usermodel.dart';
import 'package:myapp/services/media%20storage/profile_pics_storage.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sizebox.dart';
import 'package:myapp/widgets/our_text_field.dart';

class EditPage extends StatefulWidget {
  final UserModel userModel;
  const EditPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _bio_controller = TextEditingController();
  final FocusNode nameNode = FocusNode();
  final FocusNode bioNode = FocusNode();
  String imageUrl = "";
  File? file;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {});
      file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _name_controller.text = widget.userModel.name;
      _bio_controller.text = widget.userModel.bio;
      imageUrl = widget.userModel.imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(20),
            vertical: ScreenUtil().setSp(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              file != null
                  ? Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setSp(50),
                        ),
                        child: Image.file(
                          file!,
                          height: ScreenUtil().setSp(100),
                          width: ScreenUtil().setSp(100),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  : widget.userModel.imageUrl == ""
                      ? Center(
                          child: CircleAvatar(
                            radius: ScreenUtil().setSp(35),
                            child: Text(widget.userModel.name[0],
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                )),
                          ),
                        )
                      : Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setSp(50),
                            ),
                            child: Image.network(
                              widget.userModel.imageUrl,
                              height: ScreenUtil().setSp(80),
                              width: ScreenUtil().setSp(80),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
              OurSizedHeight(),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Text(
                    "Select profile picture",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17.5),
                    ),
                  ),
                ),
              ),
              OurSizedHeight(),
              Text(
                "Change Name",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                ),
              ),
              OurSizedHeight(),
              CustomTextField(
                number: 0,
                start: nameNode,
                end: bioNode,
                controller: _name_controller,
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else {
                    return "Can't be empty";
                  }
                },
                title: "Name",
                type: TextInputType.name,
              ),
              OurSizedHeight(),
              Text(
                "Add bio",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                ),
              ),
              OurSizedHeight(),
              CustomTextField(
                number: 1,
                start: bioNode,
                onchange: (value) {},
                length: 5,
                controller: _bio_controller,
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else {
                    return "Can't be empty";
                  }
                },
                title: "Add biography",
                type: TextInputType.name,
              ),
              OurSizedHeight(),
              OurElevatedButton(
                function: () {
                  ProfileUpload().uploadProfile(
                    file,
                    _name_controller.text,
                    _bio_controller.text,
                    context,
                  );
                },
                title: "Edit Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
