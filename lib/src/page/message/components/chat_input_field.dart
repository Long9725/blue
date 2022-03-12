import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:provider/provider.dart';

import '../../../provider/socket.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              color: const Color(0x0ff08749).withOpacity(0.08),
            )
          ]),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(width: kDefaultPadding),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.64),
                  ),
                  const SizedBox(width: kDefaultPadding / 4),
                  Expanded(
                      child: TextField(
                    onSubmitted: (text) {
                      context.read<SocketProvider>().sendMessage(text);
                    },
                    decoration: InputDecoration(
                        hintText: "메세지를 입력하세요", border: InputBorder.none),
                  )),
                  Icon(
                    Icons.attach_file,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.64),
                  ),
                  const SizedBox(width: kDefaultPadding / 4),
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.64),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
