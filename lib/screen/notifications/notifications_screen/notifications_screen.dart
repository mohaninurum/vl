import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/appBarWidget.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../models/notifications_model.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc()..add(LoadNotifications()),
      child: Scaffold(
        appBar: AppBarWidget(appTitle: 'Notifications'),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return _NotificationCard(notification: state.notifications[index]);
                },
              );
            } else if (state is NotificationEmpty) {
              return const Center(child: Text("No notifications yet."));
            } else if (state is NotificationError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.notifications, color: Colors.deepPurple, size: 32),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(notification.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.045)), const SizedBox(height: 4), Text(notification.message, style: TextStyle(fontSize: width * 0.04, color: Colors.black87)), const SizedBox(height: 6), Text(_formatDate(notification.date), style: TextStyle(color: Colors.grey, fontSize: width * 0.035))])),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hrs ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
}
