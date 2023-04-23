import 'dart:math';

import 'package:cloud_storage/core/api/v1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeadingDrawer extends StatelessWidget {
  const LeadingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: min(400, MediaQuery.of(context).size.width * 0.67),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Scaffold.of(context).closeDrawer(),
              icon: const Icon(
                Icons.close,
                size: 32,
              )),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () async {
                  try {
                    await API.logout();
                  } catch (e) {}
                  context.go('/');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [Icon(Icons.logout), SizedBox(width: 8), Text('Logout')],
                )),
          ),
        ],
      )),
    );
  }
}
