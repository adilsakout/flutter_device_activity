import SwiftUI
import DeviceActivity

struct ReportView: View {
  let context: DeviceActivityReport.Context

  var body: some View {
    DeviceActivityReport(context, filter: .daily)
  }
}
