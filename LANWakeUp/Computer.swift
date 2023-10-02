import Foundation

class Computer: ObservableObject {
    @Published var device = WakeUp.Device(MAC: "", BroadcastAddr: "", Port: "")
    @Published var listOfDevices: Array<WakeUp.Device> = []
    @Published var onlineStatus: OnlineDevice = .Default
    private var wakeUp = WakeUp()
    private var ping = Ping()
    
    func target(device: WakeUp.Device) -> Error? {
        wakeUp.target(device: device)
    }
    
    func getComputer() -> WakeUp.Device {
        return device
    }
    
    func fetchUserDefaults() {
        listOfDevices = wakeUp.fetchUserDefaults()
    }
    
    func saveUserDefaults() {
        wakeUp.saveUserDefaults(data: listOfDevices)
    }
    
    func delete(oldDevice: WakeUp.Device) {
        listOfDevices = wakeUp.delete(device: oldDevice, data: listOfDevices)
    }
    
    func add(newDevice: WakeUp.Device) {
        listOfDevices = wakeUp.add(newDevice: newDevice, data: listOfDevices)
        saveUserDefaults()
    }
    
    @MainActor func currentDeviceStatus() {
        Task {
            onlineStatus = await ping.performPing(ipAddress: device.BroadcastAddr)
        }
    }
    @MainActor func updateStatusList() {
        Task {
            listOfDevices = await ping.updateStatusList(devices: listOfDevices)
        }
    }
}

