// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#191a25"></span>
  /// Alpha: 100% <br/> (0x191a25ff)
  internal static let backgroundBlack = ColorName(rgbaValue: 0x191a25ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2a2e42"></span>
  /// Alpha: 100% <br/> (0x2a2e42ff)
  internal static let darkBlue = ColorName(rgbaValue: 0x2a2e42ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#656d8a"></span>
  /// Alpha: 100% <br/> (0x656d8aff)
  internal static let gray = ColorName(rgbaValue: 0x656d8aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#232636"></span>
  /// Alpha: 90% <br/> (0x232636e6)
  internal static let inactiveButtonBlue = ColorName(rgbaValue: 0x232636e6)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e7edff"></span>
  /// Alpha: 100% <br/> (0xe7edffff)
  internal static let lightBlue = ColorName(rgbaValue: 0xe7edffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fe4e27"></span>
  /// Alpha: 100% <br/> (0xfe4e27ff)
  internal static let orange = ColorName(rgbaValue: 0xfe4e27ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#6c63ff"></span>
  /// Alpha: 100% <br/> (0x6c63ffff)
  internal static let purpure = ColorName(rgbaValue: 0x6c63ffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e1172f"></span>
  /// Alpha: 100% <br/> (0xe1172fff)
  internal static let red = ColorName(rgbaValue: 0xe1172fff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#282c3f"></span>
  /// Alpha: 100% <br/> (0x282c3fff)
  internal static let tabBarBlue = ColorName(rgbaValue: 0x282c3fff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
