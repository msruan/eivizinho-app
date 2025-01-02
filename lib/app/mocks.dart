import 'package:eiviznho/app/domain/entities/alert_entity.dart';

final List<AlertEntity> mockAlerts = [
  AlertEntity(
    id: '1',
    category: "Assalto",
    description:
        "Dois suspeitos armados roubaram um motociclista próximo ao bairro Morada Nova.",
    dtHr: DateTime.now().subtract(const Duration(hours: 2)),
    local: "Morada Nova",
  ),
  AlertEntity(
    id: '2',
    category: "Arrombamento",
    description:
        "Ladrões arrombaram a porta de um mercado e levaram diversos produtos.",
    dtHr: DateTime.now().subtract(const Duration(days: 1)),
    local: "Irmã Dulce",
  ),
  AlertEntity(
    id: '3',
    category: "Incêndio",
    description: "Fogo em uma residência atingiu uma área residencial.",
    dtHr: DateTime.now().subtract(const Duration(minutes: 45)),
    local: "Ininga",
  ),
  AlertEntity(
    id: '4',
    category: "Acidente",
    description: "Carro capotou após colidir com um muro no centro da cidade.",
    dtHr: DateTime.now().subtract(const Duration(days: 3)),
    local: "Piçarreira",
  ),
  AlertEntity(
    id: '5',
    category: "Furto",
    description: "Moto furtada de garagem durante a madrugada.",
    dtHr: DateTime.now().subtract(const Duration(hours: 5)),
    local: "Centro",
  ),
  AlertEntity(
    id: '6',
    category: "Acidente",
    description: "Um ciclista foi atropelado na faixa de pedestres.",
    dtHr: DateTime.now().subtract(const Duration(days: 2)),
    local: "Bairro dos Ipês",
  ),
  AlertEntity(
    id: '7',
    category: "Assalto",
    description: "Roubo à mão armada em uma loja de conveniência no centro.",
    dtHr: DateTime.now().subtract(const Duration(minutes: 30)),
    local: "Centro",
  ),
  AlertEntity(
    id: '8',
    category: "Incêndio",
    description:
        "Fogo de grandes proporções em um posto de gasolina na periferia.",
    dtHr: DateTime.now().subtract(const Duration(hours: 1)),
    local: "Jardim Primavera",
  ),
  AlertEntity(
    id: '9',
    category: "Acidente",
    description: "Carro colidiu com uma árvore na estrada de acesso à cidade.",
    dtHr: DateTime.now().subtract(const Duration(days: 4)),
    local: "Avenida Brasil",
  ),
  AlertEntity(
    id: '10',
    category: "Assalto",
    description: "Criminosos em uma moto roubaram a carteira de uma pedestre.",
    dtHr: DateTime.now().subtract(const Duration(hours: 6)),
    local: "Vila Nova",
  ),
];
