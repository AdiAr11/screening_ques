import 'package:flutter/material.dart';

class PopupContainer extends StatefulWidget {
  const PopupContainer({super.key});

  @override
  State<PopupContainer> createState() => _PopupContainerState();
}


class _PopupContainerState extends State<PopupContainer> {
  final _formKey = GlobalKey<FormState>();
  String _inputValue = '';

  void _validateInput(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      //do some action like save data to server.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submitted value: $_inputValue')),
      );
      Navigator.pop(context);
    }
  }

  bool isStringAllDigits(String input) {
    final regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(input);
  }

  bool isStringInRange(String input) {
    try {
      final value = double.parse(input);
      return value >= 10 && value <= 100;
    } catch (e) {
      return false; //input is not a valid number
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popup Container'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Enter a value between 10 and 100'),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }else if(!isStringAllDigits(value)){
                          return 'please enter numeric value only';
                        }
                        else if(!isStringInRange(value)){
                          return 'value is not in range 10 to 100';
                        }
                        return null;
                      },
                      // onFieldSubmitted: (String value){
                      //   setState(() {
                      //       _inputValue = value;
                      //   });
                      // },
                      onChanged: (value) {
                        // setState(() {
                        //   _inputValue = value;
                        // });
                        _inputValue = value;
                      },
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        _validateInput(context);
                        // Navigator.of(context).pop();
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Open Popup'),
        ),
      ),
    );
  }
}
