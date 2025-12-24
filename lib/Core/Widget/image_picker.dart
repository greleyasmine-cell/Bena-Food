import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerSheet extends StatefulWidget {
  const ImagePickerSheet({super.key});

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: AppColors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Upload Profile Image',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextButton(
                    onPressed: () async {
                      image = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      print('Image Path ${image?.path}');
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Take a Photo',
                            style: TextStyle(
                              color:AppColors.white,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextButton(
                    onPressed: () async {
                      image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      print('Image Path ${image?.path}');
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color:AppColors.primary,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Choose from Gallery',
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.edit,
          size: 20,
          color: AppColors.black,
        ),
      ),
    );
  }
}
