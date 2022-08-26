import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/login_bloc.dart';
import 'package:flutter_bloc/constant/colors.dart';
import 'package:flutter_bloc/constant/string_constant.dart';
import 'package:flutter_bloc/modules/login_register/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                const Text(
                StringConstant.login,
                style:  TextStyle(fontSize: 40,color: AppColor.blue,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40,),
              StreamBuilder<String>(
                stream: bloc.loginEmail,
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: StringConstant.userName,
                        labelText: StringConstant.email,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onChanged: bloc.changeloginEmail,

                  );
                }
              ),
              const SizedBox(height: 20,),
              StreamBuilder<String>(
                stream: bloc.loginPassword,
                builder: (context, snapshot) {
                  return TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: StringConstant.password,
                        labelText: StringConstant.password,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onChanged: bloc.changeLoginPassword,

                  );
                }
              ),
              const SizedBox(height: 40,),
              _buildButton(),
                  const SizedBox(height: 40,),

                  RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: StringConstant.needAnAccount,
                    style: TextStyle(color: AppColor.black,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  const WidgetSpan(child: const SizedBox(width: 5)),
                  TextSpan(
                      text:StringConstant.registerHere1,
                      style: const TextStyle(color: AppColor.blue,fontWeight: FontWeight.bold,fontSize: 20),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                        })
                ]),
              ),
         ] ),
            ),
        ),
        ),
      ));
  }

  Widget _buildButton() {
    final bloc = Provider.of<LoginBloc>(context, listen: false);

    return StreamBuilder<Object>(
        stream: bloc.isValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
              bloc.submit();
            },
            child: Container(
              height: 40,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: snapshot.hasError || !snapshot.hasData
                    ? AppColor.grey
                    : const Color(0xffff69b4),
              ),
              child:const Text(
                StringConstant.login,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
          );
        });
  }

}