import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toyota/utils/colors.dart';

showLoader() async {
  await EasyLoading.dismiss();
  EasyLoading.show();
}

dismissLoader() {
  EasyLoading.dismiss();
}

class RegisterData {
  late String firstName;
  late String lastName;
  late String email;
  late String mobile;
  late String password;

  RegisterData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile': mobile,
        'password': password,
      };
}

class CustomExpandableTile extends StatefulWidget {
  final Widget Function(bool isExpanded) titleWidget;
  final List<Widget> children;
  final bool initiallyExpanded;
  final EdgeInsets? childrenPadding;
  final EdgeInsets? tilePadding;
  final Function(bool)? onExpansionChanged;
  final Color? collapsedBackgroundColor;
  final Widget? trailing;

  const CustomExpandableTile({
    super.key,
    required this.titleWidget,
    required this.children,
    this.initiallyExpanded = false,
    this.childrenPadding,
    this.tilePadding,
    this.onExpansionChanged,
    this.collapsedBackgroundColor,
    this.trailing,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomExpandableTileState createState() => _CustomExpandableTileState();
}

class _CustomExpandableTileState extends State<CustomExpandableTile> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: _isExpanded
            ? [
                BoxShadow(
                  offset: Offset(0, 4),
                  color: Color(0xFF757575).withOpacity(0.8),
                  blurRadius: 4,
                )
              ]
            : [],
        color: _isExpanded ? Color.fromARGB(255, 229, 229, 229) : GeneralColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _handleTap,
            child: Container(
              color: widget.collapsedBackgroundColor ?? Colors.transparent,
              padding: widget.tilePadding ?? EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(child: widget.titleWidget(_isExpanded)),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ),
          _isExpanded
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: widget.childrenPadding,
                  child: Column(
                    children: widget.children,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
