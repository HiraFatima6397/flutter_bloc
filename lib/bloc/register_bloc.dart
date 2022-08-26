import 'dart:async';

import 'package:flutter_bloc/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _emailIdController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmController = BehaviorSubject<String>();

//Getters
  Stream<String> get name => _nameController.stream.transform(nameValidator);

  Stream<String> get emailId =>
      _emailIdController.stream.transform(emailValidator);
  Stream<String> get phone => _phoneController.stream.transform(phoneValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmController.stream.transform(confirmPasswordValidator);

  void updateName(String name) {
    _nameController.sink.add(name);
  }

  void updateEmail(String email) {
    _emailIdController.sink.add(email);
  }

  void updatephone(String phoneNumber) {
    _phoneController.sink.add(phoneNumber);
  }

  void updatePassword(String password) {
    _passwordController.sink.add(password);
  }

  void updateConfirmPassword(String confirmPassword) {
    _confirmController.sink.add(confirmPassword);
  }

  Stream<bool> get isValid => Rx.combineLatest5(
      name, emailId, phone, password, confirmPassword, (a, b, c, d, e) => true);
  Stream<bool> get isPasswordMatched=> Rx.combineLatest2(password,confirmPassword,(a,b){
    if(a!=b){
     return false;
     }else{
      return true;
    }
  });

  void submit() {
    print(_nameController.value);
    print(_emailIdController.value);
    print(_phoneController.value);
    print(_passwordController.value);
    print(_confirmController.value);
  }

  void dispose() {
    updateEmail('');
    updateName('');
    updatephone('');
    updatePassword('');
    updateConfirmPassword('');
  }
}
