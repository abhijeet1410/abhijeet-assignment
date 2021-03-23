part of 'app_button.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppOutlineButton extends StatefulWidget {
  const AppOutlineButton(
      {required this.child,
      Key? key,
      this.onPressed,
      this.height,
      this.width,
      this.textStyle,
      this.color,
      this.shape,
      this.padding})
      : super(key: key);

  final ShapeBorder? shape;
  final Widget child;
  final VoidCallback? onPressed;
  final double? height, width;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  @override
  AppOutlineButtonState createState() => AppOutlineButtonState();
}

class AppOutlineButtonState extends State<AppOutlineButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _isLoading
        ? AppProgress(color: widget.color ?? theme.primaryColor)
        : OutlinedButton(
            onPressed: widget.onPressed,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                widget.padding ??
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
              ),
              textStyle: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return TextStyle(color: Colors.grey.shade500);

                return TextStyle(color: AppColors.brightPrimary.shade800);
              }),
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return AppColors.brightPrimary.shade800;
                  else if (states.contains(MaterialState.disabled))
                    return Colors.grey.shade500;
                },
              ),
            ),

            // disabledTextColor: Color(0xff949494),
            // shape: const StadiumBorder(),
            // color: widget.color ?? theme.OutlineColor,
            child: DefaultTextStyle(
                style: widget.textStyle ??
                    TextStyle(
                        fontSize: 18,
                        fontFamily: Environment.fontFamily,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w500),
                child: widget.child),
          );
  }
}
