import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/faq_response.dart';
import 'package:toyota/pages/auth/provider/auth_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class QaPage extends StatefulWidget {
  const QaPage({super.key});

  static const String routeName = '/qa-page';

  @override
  State<QaPage> createState() => _QaPageState();
}

class _QaPageState extends State<QaPage> {
  late final AuthProvider _authProvider;
  List<FaqResponseData?> faq = [];
  List<int?> selected = [];

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authProvider.getFAQ().then((value) {
        setState(() {
          faq = value.data ?? [];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.whiteColor,
      appBar: CustomAppbar(),
      body: GeneralContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Түгээмэл асуулт хариулт",
              style: GeneralTextStyles.titleText(context),
            ),
            VSpacer(),
            Expanded(
                child: ListView.separated(
              itemCount: faq.length,
              separatorBuilder: (context, index) => VSpacer(),
              itemBuilder: (context, index) {
                final item = faq[index];
                return CustomExpandableTile(
                  childrenPadding: EdgeInsets.all(20),
                  titleWidget: (bool isExpended) {
                    return AnimatedContainer(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isExpended ? Colors.transparent : Colors.grey,
                        ),
                        color: GeneralColors.whiteColor,
                        boxShadow: isExpended
                            ? [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  color: Color(0xFF757575).withOpacity(0.8),
                                  blurRadius: 4,
                                )
                              ]
                            : [],
                        gradient: isExpended
                            ? LinearGradient(colors: const [
                                Color(0xFFA13133),
                                Color(0xFFCA3139),
                              ])
                            : LinearGradient(colors: const [
                                Colors.white,
                                Colors.white,
                              ]),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      duration: Duration(milliseconds: 200),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item?.name ?? "",
                              style: GeneralTextStyles.titleText(
                                context,
                                textColor: isExpended ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          HSpacer(),
                          Icon(
                            isExpended ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                            color: isExpended ? Colors.white : Colors.black,
                          )
                        ],
                      ),
                    );
                  },
                  children: [
                    Text(item?.answer ?? "")
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
