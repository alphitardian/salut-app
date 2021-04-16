import 'package:firebase_auth/firebase_auth.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/jemaat_model.dart';
import 'package:salut_app_flutter/services/auth_services.dart';
import 'package:salut_app_flutter/services/database_services.dart';

class AddJemaatScreen extends StatefulWidget {
  final Jemaat args;

  const AddJemaatScreen({Key? key, required this.args}) : super(key: key);

  @override
  _AddJemaatScreenState createState() => _AddJemaatScreenState();
}

class _AddJemaatScreenState extends State<AddJemaatScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // toupdate
  TextEditingController newNameController = TextEditingController();
  TextEditingController newJobController = TextEditingController();
  TextEditingController newPhoneController = TextEditingController();

  DatabaseJemaatServices db = DatabaseJemaatServices();

  DateTime selectedDate = DateTime.now();
  DateTime? picked;
  bool toUpdate = false;

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

  _selectDate(BuildContext context) async {
    if (picked != null) {
      selectedDate = picked!;
    }

    picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: secondaryColor,
              ),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
      });
    } else if (picked == null && picked == selectedDate) {
      setState(() {
        selectedDate = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.args.name.isNotEmpty ||
        widget.args.job.isNotEmpty ||
        widget.args.phone.isNotEmpty) {
      newNameController = TextEditingController(text: widget.args.name);
      newJobController = TextEditingController(text: widget.args.job);
      newPhoneController = TextEditingController(text: widget.args.phone);
      selectedDate = DateTime.parse(widget.args.birthDate);
      toUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          toUpdate
              ? AppLocalizations.of(context)!.updateJemaat
              : AppLocalizations.of(context)!.addJemaat,
          style: kAppBarrTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: kIsWeb
            ? EdgeInsets.symmetric(horizontal: 128)
            : EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: toUpdate == true ? newNameController : nameController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.name,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
              ),
              cursorColor: secondaryDarkColor,
            ),
            TextField(
              controller: toUpdate == true ? newJobController : jobController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.job,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
              ),
              cursorColor: secondaryDarkColor,
            ),
            TextField(
              controller:
                  toUpdate == true ? newPhoneController : phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.phone,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
              ),
              cursorColor: secondaryDarkColor,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "${selectedDate.toLocal()}".split(' ')[0],
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
              ),
              cursorColor: secondaryDarkColor,
              onTap: () {
                _selectDate(context);
              },
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(bottom: 16),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (toUpdate == true) {
                    db.updateData(
                        widget.args.id,
                        newNameController.text,
                        newJobController.text,
                        newPhoneController.text,
                        selectedDate.toLocal().toString().split(' ')[0]);
                  } else {
                    DatabaseJemaatServices db = DatabaseJemaatServices();
                    db.addData(
                        nameController.text,
                        jobController.text,
                        phoneController.text,
                        selectedDate.toLocal().toString().split(' ')[0]);
                  }
                  Navigator.pop(context);
                },
                child: Text(toUpdate
                    ? AppLocalizations.of(context)!.updateButton
                    : AppLocalizations.of(context)!.addButton),
                style: kElevatedButtonStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
