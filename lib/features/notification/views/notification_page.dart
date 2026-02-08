import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/notification/notification.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()..add(const NotificationFetched()),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatefulWidget {
  const _NotificationView();

  @override
  State<_NotificationView> createState() => __NotificationViewState();
}

class __NotificationViewState extends State<_NotificationView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Notifikasi',
            titleStyle: textTheme.headlineLarge,
          ),
          backgroundColor: ColorName.cultured,
          body: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state.fetchingStatus == LoadStatus.initial) {
                return const SizedBox.shrink();
              }

              if (state.fetchingStatus.isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state.fetchingStatus.isError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Center(
                    child: ErrorView(
                      onRetryTap: () {
                        const event = NotificationFetched();

                        context.read<NotificationBloc>().add(event);
                      },
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  const event = NotificationFetched();

                  context.read<NotificationBloc>().add(event);
                },
                child: ConditionWidget(
                  isFirstCondition: state.notifications.isEmpty,
                  firstChild: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: EmptyView(
                          onRefresh: () {
                            const event = NotificationFetched();

                            context.read<NotificationBloc>().add(event);
                          },
                        ),
                      ),
                    ],
                  ),
                  secondChild: const _NotificationList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList();

  @override
  Widget build(BuildContext context) {
    final notifications = context
        .select<NotificationBloc, List<NotificationMessage>>(
          (value) => value.state.notifications,
        );

    return ListView(
      children: [
        const SizedBox(height: 12),
        ...notifications.map((notification) {
          return NotificationItem(notification);
        }),
        const SizedBox(height: 12),
      ],
    );
  }
}
