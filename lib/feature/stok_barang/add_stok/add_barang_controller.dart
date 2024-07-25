import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddBarangController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> itemFormKey = GlobalKey<FormBuilderState>();

  bool isObscure = true;
  String? kelompokResult;
  String? kategoriResult;
  String? namaBarangResult;

  String? diagnosaItemResult;
  String? reimbusementForResult;
  RxString keteranganResult = "".obs;
}
