////import Command
//import Foundation
//import MetaCodable
//import Darwin
//
////enum system_profiler: Shellable {
////	enum Command {
////		static let executableURL = URL(filePath: "/usr/sbin/system_profiler")
////		static let arguments = ["-json"]
////
////		static func run() async throws -> ProcessResult {
////			try await ShellCommand.run(executableURL: executableURL, arguments: arguments)
////		}
////	}
////
////	struct Response {
////
////	}
////}
//
//struct Thing {
//	func bootTime() -> Date? {
//		let thing = KERN_BOOTTIME
//		var tv = timeval()
//		var tvSize = MemoryLayout<timeval>.size
//		let err = sysctlbyname("kern.boottime", &tv, &tvSize, nil, 0)
//		guard err == 0, tvSize == MemoryLayout<timeval>.size else {
//			return nil
//		}
//		let date = Date(timeIntervalSince1970: Double(tv.tv_sec) + Double(tv.tv_usec) / 1_000_000.0)
//		return date
//	}
//}
//
//@Codable
//struct SystemProfile {
//	@CodedAt("SPAirPortDataType", "spairport_airport_interfaces")
//	let airPortInterfaces: [SPAirPort]
//
//	@CodedAt("SPApplicationsDataType")
//	let applications: [SPApplications]
//
//	@CodedAt("SPAudioDataType")
//	let audios: [SPAudio]
//
//	@CodedAt("SPBluetoothDataType")
//	let bluetooths: [SPBluetooth]
//
//	@CodedAt("SPCameraDataType")
//	let cameras: [SPCamera]
//
//	@CodedAt("SPCardReaderDataType")
//	let cardReaders: [SPCardReader]
//
//	@CodedAt("SPConfigurationProfileDataType")
//	let configurationProfiles: [SPConfigurationProfile]
//
//	@CodedAt("SPDeveloperToolsDataType")
//	let developerTools: [SPDeveloperTools]
//
//	@CodedAt("SPDiagnosticsDataType")
//	let diagnostics: [SPDiagnostics]
//
//	@CodedAt("SPDisabledSoftwareDataType")
//	let disabledSoftwares: [SPDisabledSoftware]
//
//	@CodedAt("SPDiscBurningDataType")
//	let discBurnings: [SPDiscBurning]
//
//	@CodedAt("SPDisplaysDataType")
//	let displays: [SPDisplays]
//
//	@CodedAt("SPEthernetDataType")
//	let ethernets: [SPEthernet]
//
//	@CodedAt("SPExtensionsDataType")
//	let extensions: [SPExtensions]
//
//	@CodedAt("SPFireWireDataType")
//	let fireWires: [SPFireWire]
//
//	@CodedAt("SPFirewallDataType")
//	let firewalls: [SPFirewall]
//
//	@CodedAt("SPFontsDataType")
//	let fonts: [SPFonts]
//
//	@CodedAt("SPFrameworksDataType")
//	let frameworks: [SPFrameworks]
//
//	@CodedAt("SPHardwareDataType")
//	let hardwares: [SPHardware]
//
//	@CodedAt("SPiBridgeDataType")
//	let iBridges: [SPiBridge]
//
//	@CodedAt("SPInstallHistoryDataType")
//	let installHistories: [SPInstallHistory]
//
//	@CodedAt("SPInternationalDataType")
//	let internationals: [SPInternational]
//
//	@CodedAt("SPLegacySoftwareDataType")
//	let legacySoftwares: [SPLegacySoftware]
//
//	@CodedAt("SPLogsDataType")
//	let logs: [SPLogs]
//
//	@CodedAt("SPManagedClientDataType")
//	let managedClients: [SPManagedClient]
//
//	@CodedAt("SPMemoryDataType")
//	let memories: [SPMemory]
//
//	@CodedAt("SPNetworkDataType")
//	let networks: [SPNetwork]
//
//	@CodedAt("SPNetworkLocationDataType")
//	let networkLocations: [SPNetworkLocation]
//
//	@CodedAt("SPNetworkVolumeDataType")
//	let networkVolumes: [SPNetworkVolume]
//
//	@CodedAt("SPNVMeDataType")
//	let nVMs: [SPNVMe]
//
//	@CodedAt("SPParallelATADataType")
//	let parallelATAs: [SPParallelATA]
//
//	@CodedAt("SPParallelSCSIDataType")
//	let parallelSCSIs: [SPParallelSCSI]
//
//	@CodedAt("SPPCIDataType")
//	let pcis: [SPPCI]
//
//	@CodedAt("SPPowerDataType")
//	let powers: [SPPower]
//
//	@CodedAt("SPPrefPaneDataType")
//	let prefPanes: [SPPrefPane]
//
//	@CodedAt("SPPrintersDataType")
//	let printers: [SPPrinters]
//
//	@CodedAt("SPPrintersSoftwareDataType")
//	let printersSoftwares: [SPPrintersSoftware]
//
//	@CodedAt("SPRawCameraDataType")
//	let rawCameras: [SPRawCamera]
//
//	@CodedAt("SPSASDataType")
//	let sASs: [SPSAS]
//
//	@CodedAt("SPSecureElementDataType")
//	let secureElements: [SPSecureElement]
//
//	@CodedAt("SPSerialATADataType")
//	let serialATAs: [SPSerialATA]
//
//	@CodedAt("SPSmartCardsDataType")
//	let smartCards: [SPSmartCards]
//
//	@CodedAt("SPSoftwareDataType")
//	let softwares: [SPSoftware]
//
//	@CodedAt("SPSPIDataType")
//	let spis: [SPSPI]
//
//	@CodedAt("SPStartupItemDataType")
//	let startupItems: [SPStartupItem]
//
//	@CodedAt("SPStorageDataType")
//	let storages: [SPStorage]
//
//	@CodedAt("SPSyncServicesDataType")
//	let syncServices: [SPSyncServices]
//
//	@CodedAt("SPThunderboltDataType")
//	let thunderbolts: [SPThunderbolt]
//
//	@CodedAt("SPUniversalAccessDataType")
//	let universalAccesses: [SPUniversalAccess]
//
//	@CodedAt("SPUSBDataType")
//	let usbs: [SPUSB]
//
//	@CodedAt("SPWWANDataType")
//	let wWANs: [SPWWAN]
//}
//
//@Codable
//struct SPAirPort {
//
//}
//
//@Codable
//struct SPApplications {
//
//}
//
//@Codable
//struct SPAudio {
//
//}
//
//@Codable
//struct SPBluetooth {
//
//}
//
//@Codable
//struct SPCamera {
//
//}
//
//@Codable
//struct SPCardReader {
//
//}
//
//@Codable
//struct SPConfigurationProfile {
//
//}
//
//@Codable
//struct SPDeveloperTools {
//
//}
//
//@Codable
//struct SPDiagnostics {
//
//}
//
//@Codable
//struct SPDisabledSoftware {
//
//}
//
//@Codable
//struct SPDiscBurning {
//
//}
//
//@Codable
//struct SPDisplays {
//
//}
//
//@Codable
//struct SPEthernet {
//
//}
//
//@Codable
//struct SPExtensions {
//
//}
//
//@Codable
//struct SPFibreChannel {
//
//}
//
//@Codable
//struct SPFireWire {
//
//}
//
//@Codable
//struct SPFirewall {
//
//}
//
//@Codable
//struct SPFonts {
//
//}
//
//@Codable
//struct SPFrameworks {
//
//}
//
//@Codable
//struct SPHardware {
//
//}
//
//@Codable
//struct SPiBridge {
//
//}
//
//@Codable
//struct SPInstallHistory {
//
//}
//
//@Codable
//struct SPInternational {
//
//}
//
//@Codable
//struct SPLegacySoftware {
//
//}
//
//@Codable
//struct SPLogs {
//
//}
//
//@Codable
//struct SPManagedClient {
//
//}
//
//@Codable
//struct SPMemory {
//
//}
//
//@Codable
//struct SPNetwork {
//
//}
//
//@Codable
//struct SPNetworkLocation {
//
//}
//
//@Codable
//struct SPNetworkVolume {
//
//}
//
//@Codable
//struct SPNVMe {
//
//}
//
//@Codable
//struct SPParallelATA {
//
//}
//
//@Codable
//struct SPParallelSCSI {
//
//}
//
//@Codable
//struct SPPCI {
//
//}
//
//@Codable
//struct SPPower {
//
//}
//
//@Codable
//struct SPPrefPane {
//
//}
//
//@Codable
//struct SPPrinters {
//
//}
//
//@Codable
//struct SPPrintersSoftware {
//
//}
//
//@Codable
//struct SPRawCamera {
//
//}
//
//@Codable
//struct SPSAS {
//
//}
//
//@Codable
//struct SPSecureElement {
//
//}
//
//@Codable
//struct SPSerialATA {
//
//}
//
//@Codable
//struct SPSmartCards {
//
//}
//
//@Codable
//struct SPSoftware {
//
//}
//
//@Codable
//struct SPSPI {
//
//}
//
//@Codable
//struct SPStartupItem {
//
//}
//
//@Codable
//struct SPStorage {
//
//}
//
//@Codable
//struct SPSyncServices {
//
//}
//
//@Codable
//struct SPThunderbolt {
//
//}
//
//@Codable
//struct SPUniversalAccess {
//
//}
//
//@Codable
//struct SPUSB {
//
//}
//
//@Codable
//struct SPWWAN {
//
//}
