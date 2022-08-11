import 'package:responsive_framework/responsive_framework.dart';

List<ResponsiveBreakpoint> breakpoints = const [
          ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(712, name: 'TABLETSAMSUNG'),
          ResponsiveBreakpoint.autoScale(1280, name: 'NEST HUB MAX'),
          ResponsiveBreakpoint.autoScale(1024, name: 'NEST HUB'),
          ResponsiveBreakpoint.autoScale(412, name: 'GALAXY A15'),
          ResponsiveBreakpoint.autoScale(540, name: 'SURFACE DUO'),
          ResponsiveBreakpoint.autoScale(280, name: 'GALAXY FOLD'),
          ResponsiveBreakpoint.autoScale(912, name: 'SURFACE PRO 7'),
          ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ];