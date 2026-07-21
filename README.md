# DensityFX 🖥️✨

[English](#english) | [Русский](#русский)

---

## English

**DensityFX** is a lightweight native macOS menu bar utility that bypasses Apple's system limitations to unlock all hidden low-level Retina HiDPI display scaling modes and refresh rates (Hz) on any external monitors.

The app runs fully autonomously from the Menu Bar, does not overload the system, and requires no dangerous kernel extensions or third-party drivers.

### 🔥 Key Features
- **Unlock Hidden Retina Modes:** Get access to the entire hidden WindowServer resolution table (including intermediate HiDPI modes like 3008x1692 for 4K panels).
- **Smart Section Grouping:** Available resolutions are automatically distributed into three distinct sections (Retina FullHD+, small HiDPI, and regular 1x modes).
- **Refresh Rate Control:** Quickly switch display frequencies (60Hz, 120Hz, 144Hz) even if they are locked in standard macOS settings.
- **Dual-Language Interface:** Automatic system language detection at first launch with instant switching via 🇷🇺/🇺🇸 toggle checkboxes.
- **Integrated Launch at Login:** Manage autostart with a single checkbox using Apple's secure `ServiceManagement` framework.
- **Safe One-Click Restore:** Instant rollback to the original factory display configuration.

### 🛠️ How It Works Under the Hood
Instead of using public CoreGraphics methods (which macOS forcibly resets to blurry 1x mode on external screens), **DensityFX** communicates directly with the low-level private C-functions of the `SkyLight` graphics core (`CGSConfigureDisplayMode`). 

The app parses the raw WindowServer memory buffer byte-by-byte and applies modes using their internal indices (`internalIndex`). This forces macOS to maintain hardware Retina scaling (Double Framebuffer) and crisp text subpixel anti-aliasing.

### 🚀 Installation & Build
Since the app uses private APIs, it cannot be distributed via the Mac App Store. You can easily build it using Xcode:
1. Clone the repository:
   ```bash
   git clone https://github.com/Andrej-Antipov/DensityFX
   ```
2. Open the project in Xcode.
3. **Important:** Go to the `Signing & Capabilities` tab and **remove App Sandbox** (click the 'X' button). Private display APIs are completely blocked inside the sandbox.
4. Press `Cmd + R` to build and run.

### 📄 License
This project is licensed under the [MIT](LICENSE) License.

---

## Русский

**DensityFX** — это легковесная нативная утилита для macOS, которая работает из строки меню и позволяет обходить системные ограничения Apple, разблокируя скрытые низкоуровневые Retina HiDPI режимы масштабирования интерфейса и частоты обновления (Гц) на любых внешних мониторах.

Программа работает полностью автономно из строки меню (Menu Bar), не перегружает систему и не требует установки опасных сторонних драйверов ядра.

### 🔥 Основные возможности
- **Разблокировка скрытых Retina-режимов:** Получите доступ ко всей скрытой таблице разрешений WindowServer (включая промежуточные HiDPI-режимы вроде 3008x1692 для 4K-панелей).
- **Умная группировка списков:** Доступные разрешения автоматически распределяются по трем понятным секциям (Retina FullHD+, малые HiDPI и обычные 1х режимы).
- **Управление герцовкой:** Быстро переключайте частоту обновления экрана (60 Гц, 120 Гц, 144 Гц), если эти параметры заблокированы в стандартных настройках macOS.
- **Двуязычный интерфейс:** Автоматическое определение языка системы при первом старте с возможностью мгновенного переключения флажками 🇷🇺/🇺🇸.
- **Встроенный автозапуск:** Управляйте запуском приложения при старте Mac с помощью одного чекбокса, использующего безопасный системный фреймворк Apple `ServiceManagement`.
- **Безопасный откат:** Мгновенное возвращение к исходному заводскому разрешению экрана в один клик.

### 🛠️ Как это работает под капотом
В отличие от стандартных публичных методов CoreGraphics, которые macOS сбрасывает в обычный «мыльный» режим 1х на внешних мониторах, **DensityFX** использует низкоуровневые приватные C-функции графического ядра `SkyLight` (`CGSConfigureDisplayMode`).

Программа считывает побайтовую структуру памяти WindowServer и применяет разрешения по их сырым числовым индексам (`internalIndex`), заставляя операционную систему удерживать аппаратное Retina-масштабирование (Double Framebuffer) и идеальную четкость шрифтов.

### 🚀 Установка и сборка
Приложение использует приватные API, поэтому оно не может распространяться через Mac App Store. Вы можете легко собрать его сами через Xcode:
1. Склонируйте репозиторий:
   ```bash
   git clone https://github.com/Andrej-Antipov/DensityFX
   ```
2. Откройте проект в Xcode.
3. **Важный шаг:** Перейдите во вкладку `Signing & Capabilities` вашего Target и полностью **удалите App Sandbox** (нажмите на крестик X). Приватные функции ядра дисплеев заблокированы внутри песочницы.
4. Нажмите `Cmd + R` для сборки и запуска.

### 📄 Лицензия
Проект распространяется под свободной лицензией [MIT](LICENSE).
