part of 'app_button.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppButton extends StatefulWidget {
  const AppButton(
      {@required this.child,
      Key key,
      this.onPressed,
      this.height,
      this.width,
      this.textStyle,
      this.color,
      this.shape,
      this.padding})
      : super(key: key);

  final ShapeBorder shape;
  final Widget child;
  final VoidCallback onPressed;
  final double height, width;
  final Color color;
  final TextStyle textStyle;
  final EdgeInsets padding;
  @override
  AppButtonState createState() => AppButtonState();
}

class AppButtonState extends State<AppButton> {
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
        : MaterialButton(
            onPressed: widget.onPressed,
            disabledTextColor: Color(0xff949494),
            shape: const StadiumBorder(),
            color: widget.color ?? theme.primaryColor,
            padding: widget.padding ??
                const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
            child: DefaultTextStyle(
                style: widget.textStyle ??
                    TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w500),
                child: widget.child),
          );
  }
}
