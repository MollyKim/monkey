import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController nicknameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController = TextEditingController();
  TextEditingController birthTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              renderName(),
              renderEmail(),
              renderNickName(),
              renderPhoneNumber(),
              renderBirthDay(),
              renderButton(),
            ],
          ),
        ),
      ),
    );
  }

  renderName(){
    return renderTextFormField(
      textEditingController: nameTextEditingController,
      label: '이름',
      onSaved: (val) {
        nameTextEditingController.text = val;
      },
      validator: (val) {
        if(val.length < 1) {
          return '이름은 필수사항입니다.';
        } else if(val.length > 20) {
          return '20자 이하여야 합니다.';
        } return null;
      },
    );
  }
  renderEmail(){
    return renderTextFormField(
      textEditingController: emailTextEditingController,
      label: '이메일',
      onSaved: (val) {
        emailTextEditingController.text = val;
      },
      validator: (val) {
        if(val.length < 1) {
          return '이메일은 필수사항입니다.';
        }
        if(!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(val)){
          return '잘못된 이메일 형식입니다.';
        }
        return null;
      },
    );
  }
  renderNickName(){
    return renderTextFormField(
      textEditingController: nicknameTextEditingController,
      label: '닉네임',
      onSaved: (val) {},
      validator: (val) {
        if(val.length < 1) {
          return '닉네임은 필수사항입니다.';
        }
        if(!RegExp(r'^[a-z|A-Z|가-힣|ㄱ-ㅎ|ㅏ-ㅣ|]+$').hasMatch(val)){
          return 'only Eng & Kor is acceptable';
        }
        return null;
      },
    );
  }
  renderPhoneNumber(){
    return renderTextFormFieldPhoneNumber(
      textEditingController: phoneNumberTextEditingController,
      label: 'Phone Number',
      onSaved: (val) {},
      validator: (val) {
        if(val.length < 1) {
          return 'Phone Number is required';
        }
        else if(val.length < 9) {
          return '10 numbers is required';
        }
        else if(!RegExp(r'^[0-9]{1,10}$').hasMatch(val)){
          return 'only less 10 number is acceptable';
        }
        return null;
      },
    );
  }

  renderBirthDay(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text(
          "BirthDay",
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextFormField(
          controller: birthTextEditingController,
          onTap: () async{
             await DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                maxTime: DateTime.now(),
                onConfirm: (date) {
                  String formattedDate = DateFormat('dd/MM/yyyy').format(date);

                  birthTextEditingController.text = formattedDate;
                },
                currentTime: DateTime.now(),
                locale: LocaleType.ko);
          },
          readOnly: true,
        ),
      ],
    );
  }

  renderTextFormField({
    required TextEditingController textEditingController,
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextFormField(
          controller: textEditingController,
          onSaved: onSaved,
          validator: validator,
          decoration: const InputDecoration(
            errorStyle: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }

  renderTextFormFieldPhoneNumber({
    required TextEditingController textEditingController,
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: textEditingController,
          onSaved: onSaved,
          validator: validator,
          maxLength: 10,
          decoration: const InputDecoration(
            errorStyle: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }

  renderButton() {
    return ElevatedButton(
      onPressed: () {
        if(formKey.currentState!.validate()){
          print("name : ${nameTextEditingController.text}");
          print("email : ${emailTextEditingController.text}");
          print("nickname : ${nicknameTextEditingController.text}");
          print("phone number : ${phoneNumberTextEditingController.text}");
          print("birthDay : ${birthTextEditingController.text}");
        }
      },
      child: const Text(
        '저장하기',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}