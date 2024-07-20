import 'package:flutter/material.dart';
import 'package:focustime/domain/entitites/locktype.dart';
import 'package:focustime/presentation/widgets/cards/card_locktype.dart';

class NewProfileScreen extends StatefulWidget {
  @override
  _NewProfileScreenState createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends State<NewProfileScreen> {
  final TextEditingController _nombrePerfilController = TextEditingController();
  List<LockType> _tiposBloqueo = [];

  void _agregarTipoBloqueo(String tipo, String detalles) {
    setState(() {
      _tiposBloqueo.add(LockType(
        type: NameLockType.schedule,
        daysActive: [
          DayOfWeek.monday,
          DayOfWeek.tuesday,
          DayOfWeek.wednesday,
          DayOfWeek.thursday,
          DayOfWeek.friday,
        ],
        hoursActive: [
          const TimeOfDay(hour: 22, minute: 50),
          const TimeOfDay(hour: 1, minute: 35),
        ],
      ));
    });
  }

  void _eliminarTipoBloqueo(int index) {
    setState(() {
      _tiposBloqueo.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                controller: _nombrePerfilController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del perfil',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.lock),
                  const SizedBox(width: 8),
                  const Text('Tipo de bloqueo'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí podrías abrir un diálogo para agregar un nuevo tipo de bloqueo
                      _agregarTipoBloqueo('Horario', '10:50 PM - 01:35 AM');
                    },
                    child: const Text('Añadir'),
                  ),
                ],
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _tiposBloqueo.length,
                itemBuilder: (context, index) {
                  return LockTypeCard(lockType: _tiposBloqueo[index],);
                },
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  const Icon(Icons.apps),
                  const SizedBox(width: 8),
                  const Text('Aplicaciones bloqueadas'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí podrías abrir un selector de aplicaciones
                    },
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),

              const SizedBox(height: 8),      

              const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Center(child: Text('Seleccione las aplicaciones')),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.notifications_off),
                  const SizedBox(width: 8),
                  const Text('Bloquear notificaciones'),
                  const Spacer(),
                  Checkbox(
                    value: false, 
                    onChanged: (value) {}
                  )
                ],
              ),

              const SizedBox(height: 16),

              Center(
                child: FilledButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(
                      const Size(50, 50)), // Tamaño mínimo del botón
                ),
                child: const Text('Guardar'),
                onPressed: () {
                  // Acción del botón
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