import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String messages;
  final VoidCallback callback;

  const ErrorView({Key? key, required this.messages, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            messages,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 12),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(12),
            ),
            onPressed: () => callback(),
            child: const Text(
              "Refresh",
              style: TextStyle(
                fontSize: 14.0,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
