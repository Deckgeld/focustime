import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/providers/profiles/profiles_providers.dart';
import 'package:focustime/presentation/widgets/shared/day_select_button.dart';
import 'package:uuid/uuid.dart';

class LaunchesLimitModal extends ConsumerStatefulWidget {
  final LockType? lockType;
  const LaunchesLimitModal({super.key, this.lockType});

  @override
  ConsumerState<LaunchesLimitModal> createState() => _LaunchesLimitModalState();
}

class _LaunchesLimitModalState extends ConsumerState<LaunchesLimitModal> {
  int launches = 0;
  Set<DayOfWeek> selectedDays = {};
  
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
    if (widget.lockType != null) {
      selectedDays = widget.lockType!.daysActive.toSet();
    }
  });
  }

  @override
  void dispose() {
    super.dispose();
  }

 handleDaySelection(Set<DayOfWeek> selections) {
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
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        builder: (_, scrollController) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Número de lanzamientos'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    final newLockType = LockType(
                      id: widget.lockType != null ? widget.lockType!.id : const Uuid().v4(),
                      type: NameLockType.numberLaunch,
                      daysActive: selectedDays.toList(),
                      limit: launches,
                    );

                    if (widget.lockType != null) {
                      ref.read(newLockProfileProvider.notifier).updateLockType(newLockType);
                    } else{
                      ref.read(newLockProfileProvider.notifier).addLockType(newLockType);
                    }


                    Navigator.pop(context);
                    widget.lockType?? Navigator.pop(context);
                    
                  },
                ),
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

                  TextField(
                    decoration: const InputDecoration(labelText: 'Lanzamientos'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {
                        launches = int.tryParse(value) ?? 0;
                      });
                    },
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
