import Foundation

// This is using Linux
import Glibc


func getSystemInfo() {
    func getLinuxCpuCores() -> String? {
        let cpuInfoPath = "/proc/cpuinfo"
        if let cpuInfo = try? String(contentsOfFile: cpuInfoPath) {
            let coreCount = cpuInfo.split(separator: "\n").filter { $0.hasPrefix("processor") }.count
            return "\(coreCount)"
        }
        return nil
    }

    if let cpuCores = getLinuxCpuCores() {
        print("CPU Cores: \(cpuCores)")
    }
}