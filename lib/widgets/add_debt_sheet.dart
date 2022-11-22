import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowbill/providers/snowball_provider.dart';

import '../models/debt.dart';

class AddDebtSheet extends StatefulWidget {
  const AddDebtSheet({Key? key}) : super(key: key);

  @override
  State<AddDebtSheet> createState() => _AddDebtSheetState();
}

class _AddDebtSheetState extends State<AddDebtSheet> {
  final TextEditingController name = TextEditingController();

  final TextEditingController monthlyPayment = TextEditingController();

  final TextEditingController remainingBalance = TextEditingController();

  bool get formComplete => name.text.isNotEmpty && monthlyPayment.text.isNotEmpty && remainingBalance.text.isNotEmpty;

  @override
  void initState() {
    name.addListener(() {
      setState(() {
        // set state on update
      });
    });

    monthlyPayment.addListener(() {
      setState(() {
        // set state on update
      });
    });

    remainingBalance.addListener(() {
      setState(() {
        // set state on update
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: name,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  keyboardType: TextInputType.name,
                  keyboardAppearance: Brightness.dark,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: monthlyPayment,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  keyboardAppearance: Brightness.dark,
                  textInputAction: TextInputAction.next,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: const InputDecoration(
                    hintText: 'Monthly Payment',
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: remainingBalance,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  keyboardAppearance: Brightness.dark,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Balance Remaining',
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: formComplete
                        ? SizedBox(
                            child: ElevatedButton(
                              child: const Text('Add to Snowball'),
                              onPressed: () {
                                Provider.of<SnowballProvider>(context, listen: false).addDebt(
                                  Debt(
                                    monthlyPayment: double.parse(monthlyPayment.text),
                                    name: name.text,
                                    remainingBalance: double.parse(remainingBalance.text),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                            ),
                          )
                        : Opacity(
                            opacity: 0,
                            child: ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () {},
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
