import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/retreat_bloc.dart';
import '../view_model/retreat_event.dart';
import '../view_model/retreat_state.dart';

class RetreatScreenView extends StatelessWidget {
  const RetreatScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<RetreatBloc>()..add(LoadRetreats()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Retreats')),
        body: BlocBuilder<RetreatBloc, RetreatState>(
          builder: (context, state) {
            if (state is RetreatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RetreatLoaded) {
              return ListView.builder(
                itemCount: state.retreats.length,
                itemBuilder: (context, index) {
                  final retreat = state.retreats[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(
                        retreat.photo ??
                            'https://bayareacbtcenter.com/wp-content/uploads/2024/10/Untitled-design-438.png',
                        // Fallback URL if photo is null
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(retreat.title),
                      subtitle: Text(
                          'AU\$${retreat.pricePerPerson.toStringAsFixed(2)}'),
                    ),
                  );
                },
              );
            } else if (state is RetreatError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No retreats available.'));
          },
        ),
      ),
    );
  }
}
