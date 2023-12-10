import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/debug_bloc.dart';

import '../theme/style/text_style.dart';

class DialogDebug extends StatefulWidget {
  const DialogDebug({Key? key}) : super(key: key);

  @override
  DialogDebugState createState() => DialogDebugState();
}

class DialogDebugState extends State<DialogDebug> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebugBloc, DebugState>(builder: (context, state) {
      var listDebug = state.debugList;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Debug Information",
              style: AppTextStyles.dialogTitle,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child:
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0.0),
                      itemCount: listDebug.length,
                      itemBuilder: (context, index) {
                        final item = listDebug[index];
                        return Text("${item.time}: ${item.message}",style: AppTextStyles.itemStyle.copyWith(fontSize: 16));
                      },
                    ),
                 )
          ],
        ),
      );
    });
  }
}