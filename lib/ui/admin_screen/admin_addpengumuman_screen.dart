import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/services/auth_services.dart';
import 'package:salut_app_flutter/services/database_services.dart';

class AddPengumumanScreen extends StatefulWidget {
  @override
  _AddPengumumanScreenState createState() => _AddPengumumanScreenState();
}

class _AddPengumumanScreenState extends State<AddPengumumanScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  String? imagePath;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addAnnouncement,
          style: kAppBarrTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            if (imagePath != null) {
              DatabasePengumumanServices.deleteImage(imagePath!);
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
                    controller: titleController,
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
                    controller: bodyController,
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
                      PickedFile file = (await ImagePicker()
                          .getImage(source: ImageSource.gallery))!;
                      imagePath =
                          await DatabasePengumumanServices.uploadImage(file);
                      print(imagePath);
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
                          child: Image(
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
              margin: kIsWeb
                  ? EdgeInsets.only(bottom: 16.0, left: 128, right: 128)
                  : EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  DatabasePengumumanServices.addData(titleController.text,
                      bodyController.text, imagePath != null ? imagePath! : "");

                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.addButton),
                style: kElevatedButtonStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
