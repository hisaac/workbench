#!/usr/bin/swift

import Foundation

// Read the plist file
let fileURL = URL(fileURLWithPath: "/Users/ihalvorson/Developer/mine/workbench/src/SystemDefaults/Tests/Resources/Secrets.plist")
guard let data = try? Data(contentsOf: fileURL),
      let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: Any]] else {
    fatalError("Failed to read plist")
}

// Filter for items with verified = true
let filteredItems = plist.filter { dict in
    if let verified = dict["verified"] as? Bool {
        return verified
    }
    return false
}

// Write back to file
let outputData = try! PropertyListSerialization.data(
    fromPropertyList: filteredItems,
    format: .xml,
    options: 0
)
try! outputData.write(to: fileURL)
