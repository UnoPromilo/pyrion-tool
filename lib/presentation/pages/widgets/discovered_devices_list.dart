import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../features/device_discovery/discovered_device.dart';
import '../../../shared/build_context_extensions.dart';
import '../../blocs/device_discovery/device_discovery_bloc.dart';
import '../../styles/text_style_extensions.dart';
import '../../widgets/app_spinner.dart';

class DiscoveredDevicesList extends StatelessWidget {
  const DiscoveredDevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<DeviceDiscoveryBloc, DeviceDiscoveryState>(
          builder: (context, state) {
            return switch (state) {
              DeviceDiscoverySearching() => const AppSpinner(),
              DeviceDiscoveryIdle(:final devices) when devices.isEmpty =>
                ShadTable.list(
                  children: [_getHeaders(context)],
                  columnSpanExtent: (index) =>
                      _spanExtent(index, constraints.maxWidth),
                ),
              DeviceDiscoveryIdle(:final devices) => ShadTable.list(
                header: _getHeaders(context),
                horizontalScrollPhysics: const BouncingScrollPhysics(),
                columnSpanExtent: (index) =>
                    _spanExtent(index, constraints.maxWidth),
                children: devices.asMap().entries.map(
                  (e) => _deviceToRow(e, context),
                ),
              ),
              DeviceDiscoveryError() => ShadTable.list(
                children: [_getHeaders(context)],
                columnSpanExtent: (index) =>
                    _spanExtent(index, constraints.maxWidth),
              ),
            };
          },
        );
      },
    );
  }

  List<ShadTableCell> _getHeaders(BuildContext context) {
    return [
      ShadTableCell.header(child: Text(context.appLocalizations.index)),
      ShadTableCell.header(child: Text(context.appLocalizations.interface)),
      ShadTableCell.header(child: Text(context.appLocalizations.portAddress)),
      ShadTableCell.header(child: Text(context.appLocalizations.deviceName)),
      ShadTableCell.header(child: Text(context.appLocalizations.firmware)),
      ShadTableCell.header(
        alignment: AlignmentGeometry.center,
        child: Text(context.appLocalizations.action),
      ),
    ];
  }

  Iterable<ShadTableCell> _deviceToRow(
    MapEntry<int, DiscoveredDevice> entry,
    BuildContext context,
  ) {
    final device = entry.value;
    return [
      ShadTableCell(child: Text((entry.key + 1).toString())),
      ShadTableCell(
        child: ShadBadge(
          child: Text(
            _connectionTypeToString(device.interface, context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      ShadTableCell(
        child: Text(device.address, overflow: TextOverflow.ellipsis),
      ),
      ShadTableCell(
        child: Text(
          _mapNullableString(device.name),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      ShadTableCell(
        child: Text(
          _mapNullableString(device.firmwareVersion),
          overflow: TextOverflow.ellipsis,
          style: context.text.muted.copyWith(
            color: context.appTheme.grayTextColor,
          ),
        ),
      ),
      ShadTableCell(
        child: ShadButton(child: Text(context.appLocalizations.connect)),
      ),
    ];
  }

  String _connectionTypeToString(
    Interface connectionType,
    BuildContext context,
  ) {
    return switch (connectionType) {
      Interface.serial => context.appLocalizations.connectionTypeSerial,
      Interface.usb => context.appLocalizations.connectionTypeUsb,
      Interface.can => context.appLocalizations.connectionTypeCan,
      Interface.virtual => context.appLocalizations.connectionTypeVirtual,
    };
  }

  String _mapNullableString(String? value) {
    return value ?? '-';
  }

  static const _columnWidths = {
    0: 70.0, // Index
    1: 120.0, // Interface
    2: 150.0, // Port/Address
    3: double.infinity, // Device name
    4: 120.0, // Firmware
    5: 120.0, // Action
  };

  static const _minFlexibleWidth = 120.0;

  SpanExtent? _spanExtent(int index, double maxWidth) {
    return FixedTableSpanExtent(_getColumnWidth(index, maxWidth));
  }

  double _getColumnWidth(int index, double maxWidth) {
    final columnWidth = _columnWidths[index];
    if (columnWidth == null) {
      throw Exception('Invalid column index: $index');
    }

    if (columnWidth != double.infinity) {
      return columnWidth;
    }

    final fixedTotal = _columnWidths.values
        .where((v) => v.isFinite)
        .reduce((a, b) => a + b);
    final remaining = maxWidth - fixedTotal;
    return remaining > _minFlexibleWidth ? remaining : _minFlexibleWidth;
  }
}
