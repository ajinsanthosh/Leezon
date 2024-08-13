
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:leezon/provider/auth_provider.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';

class PhonenumberAuth extends StatefulWidget {
  const PhonenumberAuth({super.key});

  @override
  _PhonenumberAuthState createState() => _PhonenumberAuthState();
}

class _PhonenumberAuthState extends State<PhonenumberAuth> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phonenumberController = TextEditingController();

  Country selectectedcountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  void dispose() {
    _phonenumberController.dispose(); // Dispose the controller correctly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, right: 10, left: 20, bottom: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor:  Pallete.borderColor,
                  child: Icon(
                    Icons.phone,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  "What's your phone \n number?",
                  style: TextStyle(
                    color: Pallete.blackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _phonenumberController,
                  keyboardType: TextInputType.phone, // Changed to phone type
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color:  Pallete.blackColor, width: 2.0),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color:  Pallete.redcolor, width: 2.0),
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color:Pallete.redcolor, width: 2.0),
                    ),
                    errorStyle: const TextStyle(color:Pallete.redcolor),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: const CountryListThemeData(
                              bottomSheetHeight: 500,
                            ),
                            onSelect: (value) {
                              setState(() {
                                selectectedcountry = value;
                              });
                            },
                          );
                        },
                        child: Text(
                          "${selectectedcountry.flagEmoji} ${selectectedcountry.phoneCode}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Pallete.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }

                    // Remove non-digit characters for validation
                    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');

                    // Check if the cleaned value is a valid phone number
                    final phoneRegex = RegExp(
                      r'^\+?[1-9]\d{1,14}$', // General international format
                    );
                    if (!phoneRegex.hasMatch(cleanedValue)) {
                      return 'Please enter a valid phone number';
                    }

                    // Optional: Specific length checks
                    if (cleanedValue.length < 10 || cleanedValue.length > 15) {
                      return 'Phone number must be between 10 and 15 digits';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 25),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          sendPhoneNumber(); // Invoke the method correctly
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Pallete.blackColor,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                color:Pallete.whiteColor
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color:Pallete.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = _phonenumberController.text.trim();
    ap.signInWithPhone(context, "+${selectectedcountry.phoneCode}$phoneNumber");
  }
}
