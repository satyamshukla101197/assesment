

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supdup/core/common_widget/bottom_button.dart';
import 'package:supdup/core/common_widget/common_text_field.dart';
import 'package:supdup/core/common_widget/custom_spacer_widget.dart';
import 'package:supdup/core/config/db_provider.dart';
import 'package:supdup/core/config/localization.dart';
import 'package:supdup/core/config/navigation.dart';
import 'package:supdup/core/utils/routes.dart';
import 'package:supdup/features/data/model/sign_up_model.dart';
const directoryName = 'Signature';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var pngBytes;
  String? galImage;
  String? path;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _numberController=TextEditingController();
  final List<File> imgList = [];
  File? _image;
  final _formKey = GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp('[a-zA-Z]+');
  static final RegExp numberRegExp = RegExp(r'\d');
  static final RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _getBody(),
      ),
    );
  }

 Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 20.0,right: 20.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getHeadingText(),
            CustomSpacerWidget(height: 30.0,),
           Form(
             key: _formKey,
             child: Container(
               child: Column(
                 children: <Widget>[
                 CommonTextField(

                 controller: _nameController,
                 hintText: "Name",
                 validate: (value) => value.isEmpty
                     ? MyLocalizations.of(context).getString('enter_your_name')
                     : (nameRegExp.hasMatch(value)
                     ? null
                     : MyLocalizations.of(context)
                     .getString('enter_your_name')),
               ),

             CustomSpacerWidget(height: 20.0,),
             CommonTextField(
               controller: _emailController,
               hintText: "Email",
               validate: (value) => value.isEmpty
                   ? MyLocalizations.of(context).getString('enter_your_email')
                   : (emailRegExp.hasMatch(value)
                   ? null
                   : MyLocalizations.of(context)
                   .getString('enter_your_email')),
             ),
             CustomSpacerWidget(height: 20.0,),
             CommonTextField(
               controller: _passwordController,
               hintText: "Password",
               inputType: TextInputType.number,
               validate: (value) => value.isEmpty
                   ? MyLocalizations.of(context).getString('enter_your_password')
                   : (numberRegExp.hasMatch(value)
                   ? null
                   : MyLocalizations.of(context)
                   .getString('enter_your_password')),
             ),
             CustomSpacerWidget(height: 20.0,),
             CommonTextField(
               controller: _numberController,
               hintText: "number",
               inputType: TextInputType.number,
               validate: (value) => value.isEmpty
                   ? MyLocalizations.of(context).getString('enter_your_number')
                   : (numberRegExp.hasMatch(value)
                   ? null
                   : MyLocalizations.of(context)
                   .getString('enter_your_number')),
             ),
                 ],
               ),
             ),
           ),
            CustomSpacerWidget(height: 20.0,),
            _pickImage(),
            CustomSpacerWidget(height: 20.0,),
            _getSignUpButton(),
          ],
        ),
      ),
    );
 }

  _getHeadingText() {
    return Container(
      child: Text("SignUp",style: TextStyle(fontSize: 30.0,color: Colors.black),),
    );
  }

  _getSignUpButton() {
    return Container(
        height: 46.0,
        margin: EdgeInsets.only(left: 20.0,right: 20.0),
        child: BottomButton(buttonName: 'sign_up', onClick: () {
         if(_formKey.currentState!.validate()){
           _sendDataIntoDatabase();
         }
        },)
    );
  }

 Widget _pickImage() {
    return GestureDetector(
      onTap: (){
        _openPopup();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.0),
        height: 70.0,
        width: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.black.withOpacity(0.5)
        ),
        child: _image==null?Icon(Icons.add_circle_outline):Image.file(_image!,fit: BoxFit.fill,),
      ),
    );
 }

   _openPopup() {
     return showCupertinoModalPopup(
       barrierColor: Colors.transparent.withOpacity(0.5),
       context: context,
       builder: (BuildContext context) => CupertinoActionSheet(
           actions: <Widget>[
             Container(
               color: Colors.blue,
               child:  CupertinoActionSheetAction(
                 child: Text(
                   "Camera",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 18,
                     color: Colors.white,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
                 onPressed: () {
                   Navigator.pop(context);
                   _imgFromCamera();
                 },
               ),
             ),
             Container(
               color: Colors.blue,
               child: CupertinoActionSheetAction(
                 child: Text(
                   "Gallery",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 18,
                     color: Colors.white,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
                 onPressed: () {
                   Navigator.pop(context);
                   _imgFromGallery();
                 },
               ),
             )
           ],
           cancelButton: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(14.0),
               color: Colors.blue,
             ),

             child: CupertinoActionSheetAction(
               child: Text(
                 "Done",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                 ),
               ),
               isDefaultAction: true,
               onPressed: () {
                 Navigator.pop(context);
               },
             ),
           )),
     );
   }

  _imgFromCamera() async {
    ImagePicker _picker = ImagePicker();
    final XFile? image = (await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 10));

    setState(() {
      _image = File(image!.path);
      imgList.add(_image!);
    });
  }

  _imgFromGallery() async{
     ImagePicker _picker = ImagePicker();
     final XFile? image = (await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 10)) ;

    setState(() {
      _image = File(image!.path);
      imgList.add(_image!);
      print(imgList.length);

    });
  }

   Future _sendDataIntoDatabase() async {
     DetailsSuccessResult successResultModel=DetailsSuccessResult(
        name: _nameController.text,
       email: _emailController.text,
       password: _passwordController.text,
       number: _numberController.text,
       image: _image.toString()
     );

     DBProvider.instance.insertData(successResultModel);
     Navigation.intent(context, AppRoutes.signin_screen);
   }

  String formattedDate() {
    DateTime dateTime = DateTime.now();
    String dateTimeString = 'Signature_' +
        dateTime.year.toString() +
        dateTime.month.toString() +
        dateTime.day.toString() +
        dateTime.hour.toString() +
        ':' + dateTime.minute.toString() +
        ':' + dateTime.second.toString() ;//+
    // ':' + dateTime.millisecond.toString() +
    //':' + dateTime.microsecond.toString();
    return dateTimeString;
  }

}
