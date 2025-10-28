import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../blocs/device_discovery/device_discovery_bloc.dart';
import '../../styles/app_sizes.dart';
import '../../widgets/app_page.dart';
import '../../widgets/bloc_provider/auto_bloc_provider.dart';
import 'widgets/controller.dart';
import 'widgets/discovered_devices_header.dart';
import 'widgets/discovered_devices_list.dart';
import 'widgets/top_header.dart';

@immutable
@RoutePage()
class DeviceDiscoveryPage extends StatelessWidget {
  const DeviceDiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoBlocProvider<DeviceDiscoveryBloc>.withChild(
      child: AppPage(
        controller: SelectDevicePageController(),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.paddingPage),
          child: Column(
            children: [
              TopHeader(),
              SizedBox(height: AppSizes.spacingXLarge),
              Expanded(
                child: Center(
                  child: ShadCard(
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.paddingCard),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DiscoveredDevicesHeader(),
                          Expanded(child: DiscoveredDevicesList()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
