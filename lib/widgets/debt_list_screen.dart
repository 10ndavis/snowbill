import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowbill/providers/snowball_provider.dart';
import 'package:snowbill/widgets/bottom_ad.dart';
import 'package:snowbill/widgets/debt_list.dart';

class DebtListScreen extends StatefulWidget {
  const DebtListScreen({Key? key}) : super(key: key);

  @override
  State<DebtListScreen> createState() => _DebtListScreenState();
}

class _DebtListScreenState extends State<DebtListScreen> {
  late TextEditingController extraValue;

  @override
  void initState() {
    extraValue = TextEditingController();
    extraValue.addListener(() {
      updateExtraPayment();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (extraValue.text.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        extraValue.text = Provider.of<SnowballProvider>(context, listen: false).snowball.extra.toStringAsFixed(2);
      });
    }
    super.didChangeDependencies();
  }

  void updateExtraPayment() {
    final SnowballProvider snowballProvider = Provider.of<SnowballProvider>(context, listen: false);
    if (extraValue.text.isEmpty) {
      snowballProvider.updateExtraPayment(0);
    }
    try {
      double numVal = double.parse(extraValue.text);
      snowballProvider.updateExtraPayment(numVal);
    } catch (e) {
      // do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SnowballProvider>(
      builder: (context, SnowballProvider snowballProvider, _) {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: SizedBox(
                width: 600,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const BottomAd(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Monthly Extra: \$', style: Theme.of(context).textTheme.titleMedium),
                            Expanded(
                              child: TextField(
                                controller: extraValue,
                                cursorColor: Theme.of(context).colorScheme.secondary,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                keyboardAppearance: Brightness.dark,
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                    color: Colors.white30,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const DebtList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
