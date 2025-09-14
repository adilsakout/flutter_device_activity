import DeviceActivity
import SwiftUI

@main
struct ReportExtension: DeviceActivityReportExtension {
  func makeConfiguration(representing context: DeviceActivityReport.Context) -> DeviceActivityReport.Configuration {
    return DeviceActivityReport.Configuration(content: {
      ReportView(context: context)
    })
  }
}
