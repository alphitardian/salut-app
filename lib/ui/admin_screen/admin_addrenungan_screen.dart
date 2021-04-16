import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/renungan_model.dart';
import 'package:salut_app_flutter/services/auth_services.dart';
import 'package:salut_app_flutter/services/database_services.dart';

class AddRenunganScreen extends StatefulWidget {
  final Renungan args;

  const AddRenunganScreen({Key? key, required this.args}) : super(key: key);

  @override
  _AddRenunganScreenState createState() => _AddRenunganScreenState();
}

class _AddRenunganScreenState extends State<AddRenunganScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  // when update
  TextEditingController newTitleController = TextEditingController();
  TextEditingController newBodyController = TextEditingController();

  bool toUpdate = false;
  String? imagePath;
  PickedFile? file;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      if (AuthServices.auth.currentUser != null) {
        User currentUser = AuthServices.auth.currentUser!;
        print(currentUser.email);
      } else {
        Navigator.pushNamed(context, StartScreenRoute);
      }
    } on Exception catch (e) {
      print('user not sign in with exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.args.title.isNotEmpty ||
        widget.args.body.isNotEmpty ||
        widget.args.imageUrl.isNotEmpty) {
      newTitleController.text = widget.args.title;
      newBodyController.text = widget.args.body;
      imagePath = widget.args.imageUrl;
      toUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          toUpdate
              ? AppLocalizations.of(context)!.updateRenungan
              : AppLocalizations.of(context)!.addRenungan,
          style: kAppBarrTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            if (imagePath != null && toUpdate == false) {
              DatabaseRenunganServices.deleteImage(imagePath!);
            }
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: 128)
                  : EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller:
                        toUpdate == true ? newTitleController : titleController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.title,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor)),
                    ),
                    cursorColor: secondaryDarkColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller:
                        toUpdate == true ? newBodyController : bodyController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.body,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: secondaryDarkColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: secondaryDarkColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: secondaryColor)),
                      labelStyle: TextStyle(color: secondaryDarkColor),
                    ),
                    cursorColor: secondaryDarkColor,
                    minLines: 5,
                    maxLines: null,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      try {
                        file = (await ImagePicker()
                            .getImage(source: ImageSource.gallery))!;

                        imagePath =
                            await DatabaseRenunganServices.uploadImage(file!);
                        print(imagePath);
                        print(file!.path);
                      } catch (e) {}
                      setState(() {});
                    },
                    child: Text(AppLocalizations.of(context)!.pickImage),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: kIsWeb
                              ? Image.network(imagePath!)
                              : Image(
                                  image: NetworkImage(imagePath!),
                                  fit: BoxFit.fitWidth,
                                ),
                        )
                      : Container(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (15 / 100),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: kIsWeb
                  ? EdgeInsets.only(bottom: 16, left: 128, right: 128)
                  : EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (toUpdate == true) {
                    DatabaseRenunganServices.updateData(widget.args.id,
                        newTitleController.text, newBodyController.text);
                  } else {
                    DatabaseRenunganServices.addData(
                        titleController.text,
                        bodyController.text,
                        imagePath == null ? '-' : imagePath!);
                  }
                  Navigator.pop(context);
                },
                child: Text(toUpdate
                    ? AppLocalizations.of(context)!.updateButton
                    : AppLocalizations.of(context)!.addButton),
                style: kElevatedButtonStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
