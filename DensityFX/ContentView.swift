import SwiftUI
import ApplicationServices
import AppKit
import ServiceManagement // Фреймворк Apple для безопасного автозапуска

// MARK: - Си-совместимый фиксированный буфер памяти (0xDC байт)
struct ModesD4 {
    var rawData: (
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8
    ) = (
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    )
    
    func readValue(atOffset offset: Int) -> UInt32 {
        var mutableSelf = self
        return withUnsafeBytes(of: &mutableSelf.rawData) { bytes in
            guard offset + 4 <= bytes.count else { return 0 }
            let b0 = UInt32(bytes[offset])
            let b1 = UInt32(bytes[offset + 1]) << 8
            let b2 = UInt32(bytes[offset + 2]) << 16
            let b3 = UInt32(bytes[offset + 3]) << 24
            return b0 | b1 | b2 | b3
        }
    }
}

// MARK: - Прямое связывание со скрытыми функциями SkyLight
@_silgen_name("CGSGetNumberOfDisplayModes")
func CGSGetNumberOfDisplayModes(_ display: CGDirectDisplayID, _ nModes: UnsafeMutablePointer<Int32>) -> Int32

@_silgen_name("CGSGetDisplayModeDescriptionOfLength")
func CGSGetDisplayModeDescriptionOfLength(_ display: CGDirectDisplayID, _ idx: Int32, _ mode: UnsafeMutablePointer<ModesD4>, _ length: Int32) -> Int32

@_silgen_name("CGSGetCurrentDisplayMode")
func CGSGetCurrentDisplayMode(_ display: CGDirectDisplayID, _ modeNum: UnsafeMutablePointer<Int32>) -> Int32

@_silgen_name("CGSConfigureDisplayMode")
func CGSConfigureDisplayMode(_ config: CGDisplayConfigRef, _ display: CGDirectDisplayID, _ modeNum: Int32) -> Int32

// MARK: - Контроллер статус-бара (Убрали контекстное меню)
@main
struct DensityFXApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene { Settings { EmptyView() } }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "display", accessibilityDescription: "DensityFX")
            button.toolTip = "DensityFX\nУправление HiDPI режимами"
            button.action = #selector(togglePopover(_:))
            button.target = self
        }
        // Увеличили высоту окна до 240, чтобы чекбокс автозапуска поместился внизу без тесноты
        popover.contentSize = NSSize(width: 440, height: 240)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        guard let button = statusItem?.button else { return }
        if popover.isShown { popover.performClose(nil) }
        else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            popover.contentViewController?.view.window?.makeKey()
        }
    }
}

// MARK: - Универсальные модели данных
let kCGDisplayShowDuplicateLowResolutionModes = "ShowDuplicateLowResolutionModes" as CFString

struct DisplayItem: Identifiable, Hashable {
    let id: CGDirectDisplayID
    var name: String { CGDisplayIsMain(id) != 0 ? "Основной монитор" : "Внешний монитор" }
}

struct ResolutionMode: Identifiable, Hashable {
    let id = UUID()
    let internalIndex: Int32
    let width, height, pixelWidth: Int
    let isHiDPI: Bool
    let refreshRate: Int
    static func == (lhs: ResolutionMode, rhs: ResolutionMode) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

// MARK: - Графический интерфейс SwiftUI
struct ContentView: View {
    @State private var displays: [DisplayItem] = []
    @State private var selectedDisplayID: CGDirectDisplayID?
    @State private var modes: [ResolutionMode] = []
    @State private var selectedModeID: UUID?
    @State private var currentResolutionText = "Считывание..."
    @State private var initialModeIndex: Int32 = 0
    @State private var isLaunchAtLoginEnabled = false // Переменная состояния автозапуска
    @State private var statusMessage = "Готово"
    @State private var isError = false
    
    var highRetinaModes: [ResolutionMode] { modes.filter { $0.isHiDPI && $0.width >= 1920 } }
    var lowRetinaModes: [ResolutionMode] { modes.filter { $0.isHiDPI && $0.width < 1920 } }
    var regularModes: [ResolutionMode] { modes.filter { !$0.isHiDPI } }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("DensityFX Display Manager").font(.headline)
                Spacer()
                Button(action: { NSApplication.shared.terminate(nil) }) {
                    Image(systemName: "power").foregroundColor(.red)
                }.buttonStyle(.plain).help("Закрыть DensityFX")
            }
            
            HStack {
                Text("Текущий режим:").font(.subheadline).bold()
                Text(currentResolutionText).font(.subheadline).foregroundColor(.accentColor)
            }
            .padding(6).frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(NSColor.windowBackgroundColor)).cornerRadius(6)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Монитор:").font(.caption).foregroundColor(.secondary)
                    Picker("", selection: $selectedDisplayID) {
                        ForEach(displays) { Text($0.name).tag(CGDirectDisplayID?.some($0.id)) }
                    }.pickerStyle(PopUpButtonPickerStyle()).labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Выбор разрешения:").font(.caption).foregroundColor(.secondary)
                    Picker("", selection: $selectedModeID) {
                        Text("Выберите разрешение...").tag(UUID?.none)
                        
                        if !highRetinaModes.isEmpty {
                            Section(header: Text("⚡️ Retina HiDPI (FullHD и выше)")) {
                                ForEach(highRetinaModes) { mode in
                                    Text("\(mode.width) x \(mode.height)\(mode.refreshRate > 0 ? " [\(mode.refreshRate) Гц]" : "")").tag(UUID?.some(mode.id))
                                }
                            }
                        }
                        if !lowRetinaModes.isEmpty {
                            Section(header: Text("📉 Малые Retina HiDPI (< FullHD)")) {
                                ForEach(lowRetinaModes) { mode in
                                    Text("\(mode.width) x \(mode.height)\(mode.refreshRate > 0 ? " [\(mode.refreshRate) Гц]" : "")").tag(UUID?.some(mode.id))
                                }
                            }
                        }
                        if !regularModes.isEmpty {
                            Section(header: Text("• Обычные режимы (1x)")) {
                                ForEach(regularModes) { mode in
                                    Text("\(mode.width) x \(mode.height)\(mode.refreshRate > 0 ? " [\(mode.refreshRate) Гц]" : "")").tag(UUID?.some(mode.id))
                                }
                            }
                        }
                    }
                    .pickerStyle(PopUpButtonPickerStyle()).labelsHidden()
                    .disabled(selectedDisplayID == nil || modes.isEmpty)
                }
            }
            
            Divider()
            
            // Чекбокс автозапуска и кнопки управления перенесены на одну линию внизу
            HStack(alignment: .center, spacing: 12) {
                Toggle(isOn: $isLaunchAtLoginEnabled) {
                    Text("Автозапуск").font(.subheadline)
                }
                .toggleStyle(.checkbox)
                .onChange(of: isLaunchAtLoginEnabled) { _, newValue in
                    toggleLaunchAtLogin(enable: newValue)
                }
                
                Spacer()
                
                Button("Применить") { applySelectedMode() }.disabled(selectedModeID == nil)
                Button("Вернуть исходное") { restoreInitialMode() }.disabled(selectedDisplayID == nil)
            }
            
            Text(statusMessage).font(.caption2).foregroundColor(isError ? .red : .secondary).lineLimit(1)
        }.padding().onAppear(perform: loadAppPreferences)
        .onChange(of: selectedDisplayID) { _, id in loadModes(for: id); updateCurrentModeInfo(for: id) }
    }
    // MARK: - Системная логика побайтового чтения памяти WindowServer (GitHub ядро)
    private func loadAppPreferences() {
        // Считываем текущий статус автозапуска из операционной системы при открытии окна
        if #available(macOS 13.0, *) {
            self.isLaunchAtLoginEnabled = SMAppService.mainApp.status == .enabled
        }
        loadDisplays()
    }

    private func loadDisplays() {
        var count: UInt32 = 0
        var active = [CGDirectDisplayID](repeating: 0, count: 16)
        if CGGetActiveDisplayList(16, &active, &count) == .success {
            let found = Array(active.prefix(Int(count))).map { DisplayItem(id: $0) }
            self.displays = found
            let mainID = found.first(where: { CGDisplayIsMain($0.id) != 0 })?.id ?? found.first?.id
            self.selectedDisplayID = mainID
            if let id = mainID {
                var currentIdx: Int32 = 0
                _ = CGSGetCurrentDisplayMode(id, &currentIdx)
                self.initialModeIndex = currentIdx
            }
            updateCurrentModeInfo(for: mainID)
        } else { showStatus("Ошибка поиска мониторов", isError: true) }
    }
    
    private func updateCurrentModeInfo(for displayID: CGDirectDisplayID?) {
        guard let id = displayID else { return }
        var currentIdx: Int32 = 0
        _ = CGSGetCurrentDisplayMode(id, &currentIdx)
        var modeDesc = ModesD4()
        _ = CGSGetDisplayModeDescriptionOfLength(id, currentIdx, &modeDesc, 0xD4)
        let w = modeDesc.readValue(atOffset: 0x8)
        let h = modeDesc.readValue(atOffset: 0xC)
        let pixelW = modeDesc.readValue(atOffset: 0xC8)
        let hz = modeDesc.readValue(atOffset: 0xBE) & 0xFFFF
        let isHiDPI = (pixelW > w) || (pixelW >= 3840 && w < 3840)
        DispatchQueue.main.async {
            self.currentResolutionText = "\(w)x\(h) @ \(hz)Гц [ID: \(currentIdx)] \(isHiDPI ? "[HiDPI]" : "")"
        }
    }
    
    private func loadModes(for displayID: CGDirectDisplayID?) {
        guard let id = displayID else { self.modes = []; self.selectedModeID = nil; return }
        var totalModesCount: Int32 = 0
        _ = CGSGetNumberOfDisplayModes(id, &totalModesCount)
        var parsed: [ResolutionMode] = []
        for i in 0..<totalModesCount {
            var modeDesc = ModesD4()
            _ = CGSGetDisplayModeDescriptionOfLength(id, i, &modeDesc, 0xD4)
            let w = Int(modeDesc.readValue(atOffset: 0x8))
            let h = Int(modeDesc.readValue(atOffset: 0xC))
            let pW = Int(modeDesc.readValue(atOffset: 0xC8))
            let hz = Int(modeDesc.readValue(atOffset: 0xBE) & 0xFFFF)
            guard w > 0 && h > 0 else { continue }
            let isHiDPI = (pW > w) || (pW >= 3840 && w < 3840)
            if !parsed.contains(where: { $0.width == w && $0.height == h && $0.pixelWidth == pW && $0.refreshRate == hz }) {
                parsed.append(ResolutionMode(internalIndex: i, width: w, height: h, pixelWidth: pW, isHiDPI: isHiDPI, refreshRate: hz))
            }
        }
        DispatchQueue.main.async {
            self.modes = parsed.sorted { if $0.width != $1.width { return $0.width < $1.width }; return $0.refreshRate < $1.refreshRate }
            self.selectedModeID = nil
            self.showStatus("Найдено \(self.modes.count) режимов", isError: false)
        }
    }
    
    private func applySelectedMode() {
        guard let dID = selectedDisplayID, let mID = selectedModeID, let mode = modes.first(where: { $0.id == mID }) else { return }
        showStatus("Применение режима...", isError: false)
        var configRef: CGDisplayConfigRef?
        if CGBeginDisplayConfiguration(&configRef) == .success, let config = configRef {
            if CGSConfigureDisplayMode(config, dID, mode.internalIndex) == 0 {
                if CGCompleteDisplayConfiguration(config, .permanently) == .success {
                    showStatus("Применено: \(mode.width)x\(mode.height)", isError: false)
                    updateCurrentModeInfo(for: dID)
                } else { showStatus("Ошибка фиксации ОС", isError: true) }
            } else { showStatus("Отказ ядра", isError: true); CGCancelDisplayConfiguration(config) }
        }
    }
    
    private func restoreInitialMode() {
        guard let dID = selectedDisplayID else { return }
        var configRef: CGDisplayConfigRef?
        if CGBeginDisplayConfiguration(&configRef) == .success, let config = configRef {
            if CGSConfigureDisplayMode(config, dID, initialModeIndex) == 0 {
                _ = CGCompleteDisplayConfiguration(config, .permanently)
                showStatus("Исходный режим восстановлен", isError: false)
                updateCurrentModeInfo(for: dID)
            }
        }
    }
    
    /// Новое: Нативное добавление/удаление из автозапуска macOS по изменению тумблера
    private func toggleLaunchAtLogin(enable: Bool) {
        if #available(macOS 13.0, *) {
            do {
                if enable {
                    try SMAppService.mainApp.register()
                    showStatus("Автозапуск включен", isError: false)
                } else {
                    try SMAppService.mainApp.unregister()
                    showStatus("Автозапуск выключен", isError: false)
                }
            } catch {
                print("❌ Сбой управления автозапуска ServiceManagement: \(error)")
                self.isLaunchAtLoginEnabled = !enable // Откатываем тумблер в случае блокировки ОС
                showStatus("Сбой прав автозапуска", isError: true)
            }
        }
    }
    
    private func showStatus(_ message: String, isError: Bool) { self.statusMessage = message; self.isError = isError }
}
