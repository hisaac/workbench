import Foundation

/// Just a fun experiment to reimplement macOS' `sw_vers` binary in Swift
/// The original is written in C, and is here: https://opensource.apple.com/source/DarwinTools/DarwinTools-1/sw_vers.c.auto.html

let output = try sw_vers.run()
print(output)
