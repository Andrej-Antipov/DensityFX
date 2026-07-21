import SwiftUI
import ApplicationServices
import AppKit
import ServiceManagement

// MARK: - Движок локализации (Локальные строки приложения)
enum Language: String, CaseIterable {
    case ru = "RU"
    case en = "EN"
}

struct Localized {
    static func string(_ key: String, lang: Language) -> String {
        let table: [Language: [String: String]] = [
            .ru: [
                "title": "DensityFX Display Manager",
                "current": "Текущий режим:",
                "monitor": "Монитор:",
                "resolution": "Выбор разрешения:",
                "picker_placeholder": "Выберите разрешение...",
                "sec_high": "⚡️ Retina HiDPI (FullHD и выше)",
                "sec_low": "📉 Малые Retina HiDPI (< FullHD)",
                "sec_reg": "• Обычные режимы (1x)",
                "autostart": "Автозапуск",
                "apply": "Применить",
                "apply_hint": "Применить выбранное разрешение экрана",
                "restore": "Вернуть",
                "restore_hint": "Вернуть исходное заводское разрешение экрана",
                "power_hint": "Закрыть DensityFX",
                "tooltip": "DensityFX\nУправление HiDPI режимами",
                "status_ready": "Готово",
                "status_applying": "Применение режима...",
                "status_restoring": "Восстановление...",
                "status_error_search": "Ошибка поиска мониторов",
                "status_error_os": "Ошибка фиксации ОС",
                "status_error_kernel": "Отказ ядра",
                "status_auto_on": "Автозапуск включен",
                "status_auto_off": "Автозапуск выключен",
                "status_auto_err": "Сбой прав автозапуска"
            ],
            .en: [
                "title": "DensityFX Display Manager",
                "current": "Current mode:",
                "monitor": "Display:",
                "resolution": "Select resolution:",
                "picker_placeholder": "Select resolution...",
                "sec_high": "⚡️ Retina HiDPI (FullHD & above)",
                "sec_low": "📉 Small Retina HiDPI (< FullHD)",
                "sec_reg": "• Regular modes (1x)",
                "autostart": "Launch at Login",
                "apply": "Apply",
                "apply_hint": "Apply selected display resolution",
                "restore": "Restore",
                "restore_hint": "Restore initial factory display resolution",
                "power_hint": "Quit DensityFX",
                "tooltip": "DensityFX\nHiDPI Display Manager",
                "status_ready": "Ready",
                "status_applying": "Applying mode...",
                "status_restoring": "Restoring...",
                "status_error_search": "Display search error",
                "status_error_os": "OS commit error",
                "status_error_kernel": "Kernel rejection",
                "status_auto_on": "Launch at Login enabled",
                "status_auto_off": "Launch at Login disabled",
                "status_auto_err": "Launch components failure"
            ]
        ]
        return table[lang]?[key] ?? key
    }
}

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

// MARK: - Контроллер статус-бара
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
        
        let currentLangRaw = UserDefaults.standard.string(forKey: "DensityFX_Lang")
        let activeLang: Language
        
        if let raw = currentLangRaw, let lang = Language(rawValue: raw) {
            activeLang = lang
        } else {
            let primarySystemLang = Locale.preferredLanguages.first ?? "en"
            activeLang = primarySystemLang.lowercased().hasPrefix("ru") ? .ru : .en
            UserDefaults.standard.set(activeLang.rawValue, forKey: "DensityFX_Lang")
        }
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "display", accessibilityDescription: "DensityFX")
            button.toolTip = Localized.string("tooltip", lang: activeLang)
            button.action = #selector(togglePopover(_:))
            button.target = self
        }
        
        popover.contentSize = NSSize(width: 440, height: 245)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        guard let button = statusItem?.button else { return }
        if popover.isShown { popover.performClose(nil) }
        else {
            let rawLang = UserDefaults.standard.string(forKey: "DensityFX_Lang") ?? "EN"
            button.toolTip = Localized.string("tooltip", lang: Language(rawValue: rawLang) ?? .en)
            
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            popover.contentViewController?.view.window?.makeKey()
        }
    }
}

// MARK: - Универсальные модели данных
let kCGDisplayShowDuplicateLowResolutionModes = "ShowDuplicateLowResolutionModes" as CFString

struct DisplayItem: Identifiable, Hashable {
    let id: CGDirectDisplayID
    let isMain: Bool
    func getName(lang: Language) -> String {
        if isMain { return lang == .ru ? "Основной монитор" : "Main Display" }
        return lang == .ru ? "Внешний монитор" : "External Display"
    }
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
    @State private var currentResolutionText = ""
    @State private var initialModeIndex: Int32 = 0
    @State private var isLaunchAtLoginEnabled = false
    @State private var statusMessage = ""
    @State private var isError = false
    @State private var appLanguage: Language = .en
    
    var highRetinaModes: [ResolutionMode] { modes.filter { $0.isHiDPI && $0.width >= 1920 } }
    var lowRetinaModes: [ResolutionMode] { modes.filter { $0.isHiDPI && $0.width < 1920 } }
    var regularModes: [ResolutionMode] { modes.filter { !$0.isHiDPI } }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(Localized.string("title", lang: appLanguage)).font(.headline)
                Spacer()
                Button(action: { NSApplication.shared.terminate(nil) }) {
                    Image(systemName: "power").foregroundColor(.red)
                }
                .buttonStyle(.plain)
                .help(Localized.string("power_hint", lang: appLanguage)) // Тултип для кнопки выхода
            }
            
            HStack {
                Text(Localized.string("current", lang: appLanguage)).font(.subheadline).bold()
                Text(currentResolutionText).font(.subheadline).foregroundColor(.accentColor)
            }
            .padding(6).frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(NSColor.windowBackgroundColor)).cornerRadius(6)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(Localized.string("monitor", lang: appLanguage)).font(.caption).foregroundColor(.secondary)
                    Picker("", selection: $selectedDisplayID) {
                        ForEach(displays) { item in
                            Text(item.getName(lang: appLanguage)).tag(item.id as CGDirectDisplayID?)
                        }
                    }.pickerStyle(PopUpButtonPickerStyle()).labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(Localized.string("resolution", lang: appLanguage)).font(.caption).foregroundColor(.secondary)
                    Picker("", selection: $selectedModeID) {
                        Text(Localized.string("picker_placeholder", lang: appLanguage)).tag(nil as UUID?)
                        
                        if !highRetinaModes.isEmpty {
                            Section(header: Text(Localized.string("sec_high", lang: appLanguage))) {
                                ForEach(highRetinaModes) { mode in
                                    Text("\(mode.width) x \(mode.height)\(mode.refreshRate > 0 ? " [\(mode.refreshRate) Гц]" : "")")
                                        .tag(mode.id as UUID?)
                                }
                            }
                        }
                        if !lowRetinaModes.isEmpty {
                            Section(header: Text(Localized.string("sec_low", lang: appLanguage))) {
                                ForEach(lowRetinaModes) { mode in
                                    Text("\(mode.width) x \(mode.height)\(mode.refreshRate > 0 ? " [\(mode.refreshRate) Гц]" : "")")
                                        .tag(mode.id as UUID?)
                                }
                            }
                        }
                        if !regularModes.isEmpty {
                            Section(header: Text(Localized.string("sec_reg", lang: appLanguage))) {
                                ForEach(regularModes) { mode in
                                    Text("\(mode.width) x \(mode.height)\(mode.refreshRate > 0 ? " [\(mode.refreshRate) Гц]" : "")")
                                        .tag(mode.id as UUID?)
                                }
                            }
                        }
                    }
                    .pickerStyle(PopUpButtonPickerStyle()).labelsHidden()
                    .disabled(selectedDisplayID == nil || modes.isEmpty)
                }
            }
            
            Divider()
            
            HStack(alignment: .center, spacing: 10) {
                HStack(spacing: 4) {
                    Toggle(isOn: Binding(
                        get: { appLanguage == .ru },
                        set: { if $0 { changeLanguage(to: .ru) } }
                    )) { Text("🇷🇺").font(.title3) }.toggleStyle(.checkbox)
                    
                    Toggle(isOn: Binding(
                        get: { appLanguage == .en },
                        set: { if $0 { changeLanguage(to: .en) } }
                    )) { Text("🇺🇸").font(.title3) }.toggleStyle(.checkbox)
                }
                
                Toggle(isOn: $isLaunchAtLoginEnabled) {
                    Text(Localized.string("autostart", lang: appLanguage))
                        .font(.subheadline)
                        .lineLimit(1)
                        .frame(width: appLanguage == .en ? 110 : 90, alignment: .leading)
                }
                .toggleStyle(.checkbox)
                .onChange(of: isLaunchAtLoginEnabled) { _, newValue in
                    toggleLaunchAtLogin(enable: newValue)
                }
                
                Spacer()
                
                // Исправленный блок кнопок: текст сокращен, добавлены подсказки (Restore)
                HStack(spacing: 8) {
                    Button(Localized.string("apply", lang: appLanguage)) { applySelectedMode() }
                        .disabled(selectedModeID == nil)
                        .help(Localized.string("apply_hint", lang: appLanguage)) // Тултип кнопки применения
                    
                    Button(Localized.string("restore", lang: appLanguage)) { restoreInitialMode() }
                        .disabled(selectedDisplayID == nil)
                        .help(Localized.string("restore_hint", lang: appLanguage)) // Тултип для кнопки «Вернуть»
                }
            }
            
            Text(statusMessage).font(.caption2).foregroundColor(isError ? .red : .secondary).lineLimit(1)
        }.padding().onAppear(perform: loadAppPreferences)
        .onChange(of: selectedDisplayID) { _, id in loadModes(for: id); updateCurrentModeInfo(for: id) }
    }
    
    private func changeLanguage(to lang: Language) {
        self.appLanguage = lang
        UserDefaults.standard.set(lang.rawValue, forKey: "DensityFX_Lang")
        if let id = selectedDisplayID { updateCurrentModeInfo(for: id) }
        showStatus(Localized.string("status_ready", lang: lang), isError: false)
    }

    // MARK: - Системная логика побайтового чтения памяти WindowServer
    private func loadAppPreferences() {
        let savedLangRaw = UserDefaults.standard.string(forKey: "DensityFX_Lang") ?? "EN"
        let activeLang = Language(rawValue: savedLangRaw) ?? .en
        self.appLanguage = activeLang
        
        if #available(macOS 13.0, *) {
            self.isLaunchAtLoginEnabled = SMAppService.mainApp.status == .enabled
        }
        loadDisplays()
    }

    private func loadDisplays() {
        var count: UInt32 = 0
        var active = [CGDirectDisplayID](repeating: 0, count: 16)
        if CGGetActiveDisplayList(16, &active, &count) == .success {
            let found = Array(active.prefix(Int(count))).map {
                DisplayItem(id: $0, isMain: CGDisplayIsMain($0) != 0)
            }
            self.displays = found
            let mainID = found.first(where: { $0.isMain })?.id ?? found.first?.id
            self.selectedDisplayID = mainID
            if let id = mainID {
                var currentIdx: Int32 = 0
                _ = CGSGetCurrentDisplayMode(id, &currentIdx)
                self.initialModeIndex = currentIdx
            }
            updateCurrentModeInfo(for: mainID)
        } else { showStatus(Localized.string("status_error_search", lang: appLanguage), isError: true) }
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
            self.currentResolutionText = "\(w)x\(h) @ \(hz)\(self.appLanguage == .ru ? "Гц" : "Hz") [ID: \(currentIdx)] \(isHiDPI ? "[HiDPI]" : "")"
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
        
        let sortedResult = parsed.sorted {
            if $0.width != $1.width { return $0.width < $1.width }
            return $0.refreshRate < $1.refreshRate
        }
        
        DispatchQueue.main.async {
            self.modes = sortedResult
            self.selectedModeID = nil // Принудительный сброс для безопасности транзакции
            let countText = self.appLanguage == .ru ? "Найдено \(sortedResult.count) режимов" : "Found \(sortedResult.count) modes"
            self.showStatus(countText, isError: false)
        }
    }
    
    private func applySelectedMode() {
        guard let dID = selectedDisplayID, let mID = selectedModeID, let mode = modes.first(where: { $0.id == mID }) else { return }
        showStatus(Localized.string("status_applying", lang: appLanguage), isError: false)
        var configRef: CGDisplayConfigRef?
        if CGBeginDisplayConfiguration(&configRef) == .success, let config = configRef {
            let configureResult = CGSConfigureDisplayMode(config, dID, mode.internalIndex)
            
            if configureResult == 0 {
                if CGCompleteDisplayConfiguration(config, .permanently) == .success {
                    showStatus("\(self.appLanguage == .ru ? "Применено" : "Applied"): \(mode.width)x\(mode.height)", isError: false)
                    updateCurrentModeInfo(for: dID)
                } else { showStatus(Localized.string("status_error_os", lang: appLanguage), isError: true) }
            } else { showStatus(Localized.string("status_error_kernel", lang: appLanguage), isError: true); CGCancelDisplayConfiguration(config) }
        }
    }
    
    private func restoreInitialMode() {
        guard let dID = selectedDisplayID else { return }
        var configRef: CGDisplayConfigRef?
        if CGBeginDisplayConfiguration(&configRef) == .success, let config = configRef {
            if CGSConfigureDisplayMode(config, dID, initialModeIndex) == 0 {
                _ = CGCompleteDisplayConfiguration(config, .permanently)
                showStatus(Localized.string("status_restoring", lang: appLanguage), isError: false)
                updateCurrentModeInfo(for: dID)
            }
        }
    }
    
    private func toggleLaunchAtLogin(enable: Bool) {
        if #available(macOS 13.0, *) {
            do {
                if enable {
                    try SMAppService.mainApp.register()
                    showStatus(Localized.string("status_auto_on", lang: appLanguage), isError: false)
                } else {
                    try SMAppService.mainApp.unregister()
                    showStatus(Localized.string("status_auto_off", lang: appLanguage), isError: false)
                }
            } catch {
                self.isLaunchAtLoginEnabled = !enable
                showStatus(Localized.string("status_auto_err", lang: appLanguage), isError: true)
            }
        }
    }
    
    private func showStatus(_ message: String, isError: Bool) { self.statusMessage = message; self.isError = isError }
}
