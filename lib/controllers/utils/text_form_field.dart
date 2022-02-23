import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmmtask/controllers/color_contraints/colors.dart';
import 'package:jmmtask/controllers/page_index_cubit.dart';

class TextFields extends StatelessWidget {
  TextFields(
      {required this.textController, required this.hintText, required this.showPassIcon});
  bool showPassIcon = false;
  String hintText = '';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageIndexCubit(true),
      child: BlocBuilder<PageIndexCubit, bool>(
        builder: (context, state) {
          bool isHidden=true;
          return TextFormField(
            maxLines: hintText == 'Type here' ? 10 : 1,
            obscureText: showPassIcon? state ? isHidden: !isHidden:false,
            cursorColor: AppColors.mainColor,
            controller: textController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Field");
              }
              return null;
            },
            onSaved: (value) {
              textController.text = value!;
            },

            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              floatingLabelBehavior:FloatingLabelBehavior.always,
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor),
                borderRadius: BorderRadius.circular(5.0),
              ),
              errorBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.red, width: 1.0),
              ),
              fillColor: AppColors.fieldColor,
              filled: true,
              suffixIcon: showPassIcon ? IconButton(
                onPressed: () {
                  context.read<PageIndexCubit>().setBool(isHidden: false);
                },
                icon: Icon(
                  Icons.visibility,
                  color: state?
                  AppColors.passIconColor:
                  AppColors.mainColor,
                ),
              ) : Text(''),
              contentPadding: EdgeInsets.only(left: 10),
              hintText: '$hintText',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),),
          );
        },
      ),
    );
  }
}