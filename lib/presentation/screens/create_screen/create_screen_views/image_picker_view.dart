
import 'package:quality_quest/library.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class CustomImagePicker extends StatefulWidget {

  const CustomImagePicker({super.key,});


  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? image;

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      context.read<SetimageBloc>().add(SetImageOneEvent(image: this.image));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetimageBloc, SetimageState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: ()=>pickImage(context),
          child: image == null
              ? Container(
            height: 230.sp,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.oxFF7658FF,
                width: 2.3,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: ()=>pickImage(context),
                  icon: const Image(
                    height: 50,
                    width: 50,
                    image: AssetImage('assets/icons/ic_gallery.png'),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  Strings.addCoverImageTXT,
                  style: Style.createAddCoverImageST,
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
              : Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.oxFF9E9E9E,
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Image.file(
              image!,
              height: 220.sp,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
