import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowbill/models/debt_calculation_container.dart';
import 'package:snowbill/providers/snowball_provider.dart';

import '../models/debt.dart';

class AddDebtSheet extends StatefulWidget {
  const AddDebtSheet({Key? key, this.container}) : super(key: key);

  final DebtCalculationContainer? container;

  @override
  State<AddDebtSheet> createState() => _AddDebtSheetState();
}

class _AddDebtSheetState extends State<AddDebtSheet> {
  final TextEditingController name = TextEditingController();

  final TextEditingController monthlyPayment = TextEditingController();

  final TextEditingController remainingBalance = TextEditingController();

  final TextEditingController interestRate = TextEditingController();

  bool get formComplete =>
      name.text.isNotEmpty &&
      monthlyPayment.text.isNotEmpty &&
      remainingBalance.text.isNotEmpty &&
      interestRate.text.isNotEmpty;

  @override
  void initState() {
    if (widget.container != null) {
      name.text = widget.container!.debt.name;
      monthlyPayment.text = widget.container!.debt.monthlyPayment.toStringAsFixed(2);
      remainingBalance.text = widget.container!.debt.remainingBalance.toStringAsFixed(2);
      interestRate.text = widget.container!.debt.interestRate.toStringAsFixed(2);
    }

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

    interestRate.addListener(() {
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
            child: Stack(
              children: [
                Column(
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
                      decoration: InputDecoration(
                        label: const Text('Name'),
                        hintStyle: const TextStyle(
                          color: Colors.white30,
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                      decoration: InputDecoration(
                        prefixText: '\$',
                        prefixStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        label: const Text('Monthly Payment with Interest'),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintStyle: const TextStyle(
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
                      decoration: InputDecoration(
                        prefixText: '\$',
                        prefixStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        label: const Text('Balance Remaining with Interest'),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.white30,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      controller: interestRate,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.dark,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        label: const Text('Interest Rate'),
                        suffixText: '%',
                        suffixStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintStyle: const TextStyle(
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
                                  child: widget.container != null
                                      ? Text(
                                          'Update',
                                          style: TextStyle(color: Theme.of(context).backgroundColor),
                                        )
                                      : Text(
                                          'Add to Snowball',
                                          style: TextStyle(color: Theme.of(context).backgroundColor),
                                        ),
                                  onPressed: () {
                                    if (widget.container != null) {
                                      Provider.of<SnowballProvider>(context, listen: false).updateDebt(
                                        widget.container!.debt,
                                        Debt(
                                          monthlyPayment: double.parse(monthlyPayment.text),
                                          name: name.text,
                                          remainingBalance: double.parse(remainingBalance.text),
                                          createdAt: widget.container!.debt.createdAt,
                                          interestRate: double.parse(interestRate.text),
                                        ),
                                      );
                                    } else {
                                      Provider.of<SnowballProvider>(context, listen: false).addDebt(
                                        Debt(
                                          monthlyPayment: double.parse(monthlyPayment.text),
                                          name: name.text,
                                          remainingBalance: double.parse(remainingBalance.text),
                                          createdAt: DateTime.now(),
                                          interestRate: double.parse(interestRate.text),
                                        ),
                                      );
                                    }

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
                if (widget.container != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Provider.of<SnowballProvider>(context, listen: false).deleteDebt(widget.container!.debt);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
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
}
