import Foundation

class DeviceRepository: ObservableObject {
    func getCurrencyCode() -> String {
        Locale.current.currency?.identifier ?? "USD"
    }
}
