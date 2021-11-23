//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <network_info_plus_windows/network_info_plus_windows_plugin.h>
#include <r_get_ip/r_get_ip_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  NetworkInfoPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NetworkInfoPlusWindowsPlugin"));
  RGetIpPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RGetIpPlugin"));
}
