import 'package:cabavenue/models/user_model.dart';
import 'package:cabavenue/providers/profile_provider.dart';
import 'package:cabavenue/services/user_service.dart';
import 'package:cabavenue/widgets/custom_text_field.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EditProfilePage();
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _editFormKey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  String profileUrl = '';
  XFile? profileImage;

  final ImagePicker _imagePicker = ImagePicker();
  final UserService _userService = UserService();

  final cloudinary = Cloudinary.full(
    apiKey: dotenv.env['IMAGE_API_KEY'] ?? '',
    apiSecret: dotenv.env['IMAGE_API_SECRET'] ?? '',
    cloudName: dotenv.env['IMAGE_CLOUD_NAME'] ?? '',
  );

  void updateImage({String url = ''}) async {
    XFile? newImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (newImage != null) {
      try {
        Fluttertoast.showToast(
          msg: 'Uploading....',
          backgroundColor: Colors.orange[700],
        );

        final cloudinaryResource = CloudinaryUploadResource(
          filePath: newImage.path,
          uploadPreset: '',
        );
        CloudinaryResponse response =
            await cloudinary.uploadResource(cloudinaryResource);

        if (response.isSuccessful && response.secureUrl!.isNotEmpty) {
          profileUrl = response.secureUrl!;
          Fluttertoast.showToast(
            msg: 'Upload complete',
            backgroundColor: Colors.green[700],
          );

          await cloudinary.deleteResource(url: url);
        } else {
          Fluttertoast.showToast(
            msg: 'Error uploading',
            backgroundColor: Colors.red[600],
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), backgroundColor: Colors.red[600]);
      }
    }

    setState(() {
      profileImage = newImage;
    });
  }

  @override
  void initState() {
    super.initState();

    UserModel user =
        Provider.of<ProfileProvider>(context, listen: false).getUserData;

    _namecontroller.text = user.name;
    _emailcontroller.text = user.email;
    _addresscontroller.text = user.address;
    _phonecontroller.text = user.phone.toString();
    profileUrl = user.profileUrl;
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _phonecontroller.dispose();
    _addresscontroller.dispose();
  }

  Widget _handlePreview(String url, String typeText) {
    return Container(
      width: 130,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
            width: 4, color: Theme.of(context).scaffoldBackgroundColor),
        boxShadow: [
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 10))
        ],
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4000),
        child: Center(
          child: url != '' ? Image.network(url) : Text("Add $typeText Image"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Edit'),
        elevation: 2,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) => Form(
          key: _editFormKey,
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      _handlePreview(profile.getUserData.profileUrl, "Profile"),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blueAccent,
                            ),
                            child: IconButton(
                              onPressed: () {
                                updateImage(
                                  url: profile.getUserData.profileUrl,
                                );
                              },
                              icon: const Icon(Iconsax.edit_2),
                              iconSize: 16,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomTextField(
                  controller: _namecontroller,
                  hintText: 'Name',
                  icon: Iconsax.user,
                ),
                CustomTextField(
                  controller: _emailcontroller,
                  hintText: 'Email',
                  icon: Iconsax.sms,
                  keyboardType: TextInputType.emailAddress,
                  validations: const ['email'],
                ),
                CustomTextField(
                  controller: _phonecontroller,
                  hintText: 'Phone number',
                  icon: Iconsax.call,
                  keyboardType: TextInputType.number,
                  validations: const ['specific-length'],
                  length: 10,
                ),
                CustomTextField(
                  controller: _addresscontroller,
                  hintText: 'Address',
                  icon: Iconsax.location,
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 50.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 50.0,
                        ),
                      ),
                      onPressed: () {
                        if (_editFormKey.currentState!.validate()) {
                          _userService.editProfile(
                            name: _namecontroller.text,
                            email: _emailcontroller.text,
                            phone: _phonecontroller.text,
                            address: _addresscontroller.text,
                            profileUrl: profileUrl,
                            context: context,
                          );
                        }
                      },
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
