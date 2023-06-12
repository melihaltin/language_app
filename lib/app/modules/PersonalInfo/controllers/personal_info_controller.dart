import 'dart:typed_data';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';

import '../../../data/firebase/storage_methods.dart';

class PersonalInfoController extends GetxController {
  RxString country = "".obs;
  RxString gender = "".obs;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Rx<Language> selectedNativeLanguage = Language.fromIsoCode('ko').obs;
  Rx<Language> selectedPracticeLanguage = Language.fromIsoCode('ko').obs;

  Rxn<Uint8List>? file = Rxn<Uint8List>();
  late Uint8List temp;
  RxString downloadUrl =
      "https://www.29mayis.edu.tr/public/images/default-profile.png".obs;
//----------------------------------------------------------------------------------
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  Future<dynamic> uploadProfilePhoto(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Upload Profile Photo",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take Photo"),
              onPressed: () async {
                Navigator.pop(context);
                file?.value = await pickImage(ImageSource.camera);
                downloadUrl.value = await StorageMethods()
                    .uploadImageToStorage('profilePhoto', file!.value!);
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                file?.value = await pickImage(ImageSource.gallery);
                downloadUrl.value = await StorageMethods()
                    .uploadImageToStorage('profilePhoto', file!.value!);
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

//-------------------------------------------------------------------------------
  void pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (pickedCountry) {
        country.value = pickedCountry.name;
      },
    );
  }

//----------------------------------------------------------------------
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          const SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void pickLanguage(BuildContext context, bool isNative) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.amber),
          child: LanguagePickerDialog(
            titlePadding: const EdgeInsets.all(8),
            searchCursorColor: Colors.blue,
            isSearchable: true,
            title: const Text('Select Language'),
            onValuePicked: (Language language) {
              if (isNative) {
                selectedNativeLanguage.value = language;
              } else {
                selectedPracticeLanguage.value = language;
              }
            },
            itemBuilder: _buildDialogItem,
          ),
        );
      },
    );
  }

  Future pickAndUpload() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
