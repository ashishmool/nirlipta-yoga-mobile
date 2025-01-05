import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/batch/presentation/view_model/batch_bloc.dart';

class BatchView extends StatelessWidget {
  BatchView({super.key});

  final batchNameController = TextEditingController();

  final _batchViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _batchViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: batchNameController,
                decoration: const InputDecoration(
                  labelText: 'Batch Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter batch name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_batchViewFormKey.currentState!.validate()) {
                    // BlocProvider.of<BatchBloc>(context).add(
                    //   AddBatch(
                    //     BatchEntity(
                    //       batchName: batchNameController.text.trim(),
                    //     ),
                    //   ),
                    // );
                  }
                },
                child: BlocBuilder<BatchBloc, BatchState>(
                  builder: (context, state) {
                    return Text('Add Batch');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
