import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';
import 'package:uuid/uuid.dart';

class UsageLimitModal extends ConsumerStatefulWidget {
  const UsageLimitModal({super.key});

  @override
  ConsumerState<UsageLimitModal> createState() => _UsageLimitModalState();
}

class _UsageLimitModalState extends ConsumerState<UsageLimitModal> {
  Duration selectedTime = const Duration(hours: 0, minutes: 0);
  bool isBlockSelected = true;
  Set<DayOfWeek> selectedDays = {};

  void handleDaySelection(Set<DayOfWeek> selection) {
    setState(() {
      selectedDays = selection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Limite de uso"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final newLockType = LockType(
                id: const Uuid().v4(),
                type: NameLockType.limitUsage,
                daysActive: selectedDays.toList(),
                limit: selectedTime.inMinutes,
                isByBlock: isBlockSelected,
              );

              ref
                  .read(newLockProfileProvider.notifier)
                  .addLockType(newLockType);

              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Días'),
            DaySelectButton(onSelectionChanged: handleDaySelection),
            const SizedBox(height: 16),
            const Text('Límite'),
            SizedBox(
              height: 200,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (Duration changedTimer) {
                  setState(() {
                    selectedTime = changedTimer;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: const Text('Bloquear Por:'),
            ),
            Center(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                isSelected: [isBlockSelected, !isBlockSelected],
                onPressed: (int index) {
                  setState(() {
                    isBlockSelected = (index == 0);
                  });
                  print(isBlockSelected);
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Block"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("App"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
