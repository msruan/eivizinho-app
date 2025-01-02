import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:eiviznho/app/ui/alert_create/containers/alert_create_container.dart';
import 'package:flutter/material.dart';
import 'package:june/state_manager/state_manager.dart';

// TODO: Componentizar esse dropdown (e achar implementação mais simples + multiselect) e retirar o JuneBuilder (realocar pro container)

class Dropdown extends StatelessWidget {
  const Dropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => DropdownState(),
        builder: (DropdownState state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                DropdownButtonFormField<AlertCategory>(
                  value: state.selectedValue,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  hint: Text(
                    'Selecione um incidente',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  onChanged: (AlertCategory? newValue) {
                    if (newValue != null) {
                      state.selectedValue = newValue;
                    }
                  },
                  items: state.types.map<DropdownMenuItem<AlertCategory>>(
                      (AlertCategory value) {
                    return DropdownMenuItem<AlertCategory>(
                      value: value,
                      child: Text(
                        value.name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ));
  }
}
