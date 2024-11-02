import 'package:flutter/material.dart';

enum ButtonType {
  primary(Colors.blue),
  secondary(Colors.green),
  disabled(Colors.grey);

  final Color color;

  const ButtonType(this.color);
}

enum IconPosition {
  left,
  right;

  List<Widget> buildChildren(IconData icon, String label, bool isDisabled) {
    final textColor = isDisabled ? Colors.grey : Colors.blueGrey;

    switch (this) {
      case IconPosition.left:
        return [
          Icon(icon, color: textColor),
          const SizedBox(width: 9),
          Text(label, style: TextStyle(color: textColor)),
        ];
      case IconPosition.right:
        return [
          Text(label, style: TextStyle(color: textColor)),
          const SizedBox(width: 9),
          Icon(icon, color: textColor),
        ];
    }
  }
}

void main() => runApp(MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Custom buttons'),
            backgroundColor: Colors.white,
          ),
          body: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(label: "Submit", icon: Icons.check),
                  SizedBox(height: 25),
                  CustomButton(
                      label: "Time",
                      icon: Icons.schedule,
                      buttonType: ButtonType.secondary,
                      iconPosition: IconPosition.right),
                  SizedBox(height: 25),
                  CustomButton(
                      label: "Account",
                      icon: Icons.account_tree,
                      buttonType: ButtonType.disabled,
                      iconPosition: IconPosition.right),
                ]),
          )),
    ));

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconPosition iconPosition;
  final ButtonType buttonType;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    this.iconPosition = IconPosition.left,
    this.buttonType = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = buttonType == ButtonType.disabled;

    return ElevatedButton(
      onPressed: isDisabled ? null : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonType.color,
        foregroundColor: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconPosition.buildChildren(icon, label, isDisabled),
      ),
    );
  }
}
