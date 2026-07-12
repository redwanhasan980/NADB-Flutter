import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/grade_tracker_provider.dart';

class AddSubjectScreen extends StatelessWidget {
  const AddSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: _SubjectForm(),
    );
  }
}

class _SubjectForm extends StatelessWidget {
  const _SubjectForm();

  static final _formKey = GlobalKey<FormState>();
  static final _nameController = TextEditingController();
  static final _markController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.school_outlined,
            size: 72,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Track a new result',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter the subject and the mark earned out of 100.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Subject name',
              hintText: 'e.g. Mathematics',
              prefixIcon: Icon(Icons.book_outlined),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a subject name';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _markController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d{0,3}(\.\d{0,2})?'),
              ),
            ],
            decoration: const InputDecoration(
              labelText: 'Mark',
              hintText: '0–100',
              prefixIcon: Icon(Icons.percent),
            ),
            validator: (value) {
              final mark = double.tryParse(value?.trim() ?? '');
              if (mark == null) return 'Please enter a valid number';
              if (mark < 0 || mark > 100) {
                return 'Mark must be between 0 and 100';
              }
              return null;
            },
            onFieldSubmitted: (_) => _submit(context),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _submit(context),
            icon: const Icon(Icons.add),
            label: const Text('Add subject'),
          ),
        ],
      ),
    );
  }

  static void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text;
    final mark = double.parse(_markController.text.trim());
    context.read<GradeTrackerProvider>()
      ..addSubject(name, mark)
      ..showSubjectList();
    _nameController.clear();
    _markController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
