import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/services/auth_services.dart';
import 'package:salut_app_flutter/services/database_services.dart';

class AddWartaJemaatScreen extends StatefulWidget {
  @override
  _AddWartaJemaatScreenState createState() => _AddWartaJemaatScreenState();
}

class _AddWartaJemaatScreenState extends State<AddWartaJemaatScreen> {
  TextEditingController titleController = TextEditingController();

  String? fileName;
  String? fileUrl;
  FilePickerResult? file;

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
        Navigator.pushNamed(this.context, StartScreenRoute);
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
          AppLocalizations.of(context)!.addWarta,
          style: kAppBarrTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            if (fileUrl != null) {
              DatabaseRenunganServices.deleteImage(fileUrl!);
            }
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
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
              height: 32,
            ),
            MaterialButton(
              onPressed: () async {
                try {
                  file = await FilePicker.platform.pickFiles();
                  fileUrl = await DatabaseWartaJemaatServices.uploadFile(file!);
                  fileName = basename(file!.files.single.name!);
                } catch (e) {
                  print('Exception $e');
                  print(file!.files.single.name);
                }
                //print(fileName);
                setState(() {});
              },
              child: Text(AppLocalizations.of(context)!.pickFile),
            ),
            fileName != null ? Text(fileName!) : SizedBox(),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  DatabaseWartaJemaatServices.addData(
                      titleController.text, fileUrl!);
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.addButton),
                style: kElevatedButtonStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
