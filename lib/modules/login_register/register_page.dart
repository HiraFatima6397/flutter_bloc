import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/register_bloc.dart';
import 'package:flutter_bloc/constant/colors.dart';
import 'package:flutter_bloc/constant/string_constant.dart';
import 'package:flutter_bloc/modules/login_register/login_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<RegisterBloc>(context, listen: false).dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Scaffold(backgroundColor: AppColor.background,
        body: Form(
      key: _formKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              const Text(
                StringConstant.register,
                style:  TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blue),
              ),
              const SizedBox(
                height: 40,
              ),
              StreamBuilder<Object>(
                  stream: bloc.name,
                  builder: (context, snapshot) {
                    return TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: StringConstant.name,
                          labelText: StringConstant.name,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value){
                        print(value);
                        bloc.updateName(value);
                      },
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<Object>(
                  stream: bloc.emailId,
                  builder: (context, snapshot) {
                    return TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: StringConstant.email,
                          labelText: StringConstant.email,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value) {
                        bloc.updateEmail(value);
                      },
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<Object>(
                  stream: bloc.phone,
                  builder: (context, snapshot) {
                    return TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: StringConstant.phoneNumber,
                          labelText: StringConstant.phoneNumber,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value) {
                        bloc.updatephone(value);
                      }
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<Object>(
                  stream: bloc.password,
                  builder: (context, snapshot) {
                    return TextField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: StringConstant.password,
                          labelText: StringConstant.password,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value) {bloc.updatePassword(value);},
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<Object>(
                  stream: bloc.confirmPassword,
                  builder: (context, snapshot) {
                    return TextField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: StringConstant.confirmPassword,
                          labelText: StringConstant.confirmPassword,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value) {
                        bloc.updateConfirmPassword(value);
                      }
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              _buildButton(),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: StringConstant.alreadyHaveAn,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(
                        text: StringConstant.loginHere,
                        style: const TextStyle(
                            color: AppColor.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                          })
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }

  Widget _buildButton() {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

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
                    : Colors.blue,
              ),
              child: const Text(
                StringConstant.register,
                style:  TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
          );
        });
  }
}
