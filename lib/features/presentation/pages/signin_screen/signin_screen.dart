import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supdup/core/common_widget/bottom_button.dart';
import 'package:supdup/core/common_widget/common_text_field.dart';
import 'package:supdup/core/common_widget/custom_spacer_widget.dart';
import 'package:supdup/core/config/db_provider.dart';
import 'package:supdup/core/config/localization.dart';
import 'package:supdup/core/config/navigation.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/core/utils/routes.dart';
import 'package:supdup/features/presentation/pages/homescreen_screen/argument/argument.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        obscureText: true,
                        inputType: TextInputType.number,
                        controller: _passwordController,
                        hintText: "Password",
                      ),
                    ],
                  ),
                ),
              ),
              CustomSpacerWidget(height: 20.0,),
              _getLoginButton(),
              CustomSpacerWidget(height: 60.0,),
              _getSignUpPage()
            ],
          ),
        )
      ),
    );
 }

  _getHeadingText() {
    return Container(
      child: Text("SignIn",style: TextStyle(fontSize: 30.0,color: Colors.black),),
    );
  }

  _getLoginButton() {
    return Container(
      height: 46.0,
      margin: EdgeInsets.only(left: 20.0,right: 20.0),
      child: BottomButton(buttonName: 'login', onClick: () async{
       if( _formKey.currentState!.validate()){
         final response=await DBProvider.instance.getLogin(_emailController.text, _passwordController.text);
         if(response?.name!= null){
           Navigation.intentWithData(
               context,
               AppRoutes.homescreen,
               Argument(image: response!.image!, name: response.name!)
           );
         }else{
           _openErrorPopup();
         }
       }
      },)
    );
  }

  _getSignUpPage() {
    return GestureDetector(
      onTap: (){
        Navigation.intent(context, AppRoutes.signup_screen);
      },
      child: Container(
        child: Text("SignUp",style: TextStyle(fontSize: 16.0,color: Colors.blue),),
      ),
    );
  }

   _openErrorPopup() {
    return showDialog(
        context: context
        , builder: (BuildContext context){
          return AlertDialog(
            content: Container(
              height: 100.0,
              child: Column(
                children: <Widget>[
                  Text("Email or password mismatch"),
                  CustomSpacerWidget(height: 30.0,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.green
                      ),
                      child: Text("OK"),
                    ),
                  )
                ],
              ),
            ),
          );
    });
   }


}
