import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';
import 'package:uuid/uuid.dart';

class UsageLimitModal extends ConsumerStatefulWidget {
  final LockType? lockType; 
  const UsageLimitModal({super.key, this.lockType});
  

  @override
  ConsumerState<UsageLimitModal> createState() => _UsageLimitModalState();
}

class _UsageLimitModalState extends ConsumerState<UsageLimitModal> {
  Duration selectedTime = const Duration(hours: 0, minutes: 0);
  bool isBlockSelected = true;
  Set<DayOfWeek> selectedDays = {};

  void handleDaySelection(Set<DayOfWeek> selections) {
    setState(() {
      selectedDays = selections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        widget.lockType?? Navigator.pop(context);
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        builder: (_, scrollController) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Limite de uso"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    final newLockType = LockType(
                      id: widget.lockType != null ? widget.lockType!.id : const Uuid().v4(),
                      type: NameLockType.limitUsage,
                      daysActive: selectedDays.toList(),
                      limit: selectedTime.inMinutes,
                      isByBlock: isBlockSelected,
                    );

                    if (widget.lockType != null) {
                      ref.read(newLockProfileProvider.notifier).updateLockType(newLockType);
                    } else{
                      ref.read(newLockProfileProvider.notifier).addLockType(newLockType);
                    }

                    Navigator.pop(context);
                    widget.lockType?? Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                controller: scrollController,
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
        },
      ),
    );
  }
}