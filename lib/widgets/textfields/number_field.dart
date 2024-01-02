import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/widgets/textfields/signup_textfields.dart';

class NumberField extends StatelessWidget {
  const NumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 232, 232),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: CountryCodePicker(
            onChanged: (code) {
              // setState(() {
              //   _selectedCountry = code;
              // });
            },
            initialSelection: 'IN', // Set the initial selection
            favorite: const [
              'US',
              'IN'
            ], // Optionally, provide a list of favorite countries
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        // Phone number text field
         Expanded(
            child: CustomTextfield(
          hintText: 'Enter phone number',
        )),
      ],
    );
  }
}
