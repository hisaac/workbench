#!/usr/bin/swift

import Foundation

// Read the plist file
let inputFileURL = URL(fileURLWithPath: "/Users/ihalvorson/Developer/mine/workbench/src/SystemDefaults/Tests/Resources/Secrets.plist")
let outputFileURL = URL(fileURLWithPath: "/Users/ihalvorson/Developer/mine/workbench/src/SystemDefaults/Tests/Resources/filteredSecrets.plist")
guard let inputData = try? Data(contentsOf: inputFileURL),
	let plist = try? PropertyListSerialization.propertyList(from: inputData, format: nil) as? [[String: Any]] else {
	fatalError("Failed to read plist")
}

// var bundleIDs = Set<String>()
// for dict in plist {
// 	guard let bundle = dict["bundle"] as? String else {
// 		continue
// 	}
// 	bundleIDs.insert(bundle)
// }

// print("\nBundle IDs:")
// for bundleID in bundleIDs.sorted() {
// 	print(bundleID)
// }

// var displayBundleIDs = Set<String>()
// for dict in plist {
// 	guard let displayBundle = dict["display_bundle"] as? String else {
// 		continue
// 	}
// 	displayBundleIDs.insert(displayBundle)
// }

// print("\nDisplay Bundle IDs:")
// for bundleID in displayBundleIDs.sorted() {
// 	print(bundleID)
// }

let knownBadBundleIDs = [
	"$HOME/.MacOSX/environment",
	"$HOME/Library/Application Support/Adium 2.0/Users/Default/Dual Window Interface",
	"$HOME/Library/Application Support/Adium 2.0/Users/Default/Status Menu Item",
	"$HOME/Library/Preferences/kJams/kJams Preferences",
	"ch.sudo.cyberduck",
	"com.1passwd",
	"com.abyssoft.teleport",
	"com.adiumx.adiumX",
	"com.adiumx.Adiumx",
	"com.barebones.bbedit",
	"com.blacktree.Quicksilver",
	"com.blacktree.secrets",
	"com.bruji.DVDpedia",
	"com.DanSchimpf.MacJournal",
	"com.echoone.doubletake",
	"com.echoone.FileJuicer",
	"com.extensis.portfolio.eight",
	"com.extensis.SuitcaseFusion",
	"com.flyingmeat.Acorn",
	"com.flyingmeat.VoodooPad_Pro",
	"com.google.Desktop.QSB",
	"com.google.GmailNotifier",
	"com.houdah.HoudahSpot",
	"com.iconfactory.Twitterrific",
	"com.karelia.Sandvox",
	"com.ksuther.chax",
	"com.macromates.textmate",
	"com.mactelnet.MacTelnet",
	"com.malcolmhardie.sqleditor.cocoa",
	"com.microsoft.Entourage",
	"com.omnigroup.OmniFocus",
	"com.omnigroup.OmniWeb5",
	"com.potionfactory.Tangerine",
	"com.ranchero.NetNewsWire",
	"com.red-sweater.FastScripts",
	"com.rogueamoeba.AudioHijackPro2",
	"com.rogueamoeba.fission",
	"com.rogueamoeba.ScheduleHelper",
	"com.roxio.toast",
	"com.skorpiostech.Changes",
	"com.thecocoabots.Hyperspaces",
	"com.tivo.desktop",
	"info.colloquy",
	"iTerm",
	"KHogszuHZmSlhG",
	"NSGlobalDomain",
	"org.bergstrand.iscrobbler",
	"org.m0k.transmission",
	"org.mozilla.camino",
	"org.smultron.Smultron",
	"org.tynsoe.buddypop",
	"org.webkit.nightly.WebKit",
	"org.x.X11",
	"UEBBIftBM",
	"uk.co.markallan.clamxav.ClamXavSentry",
	"uk.co.opencommunity.vienna2",
	"widget-com.philipefatio.widget.To Do",
]

let knownBadDisplayBundleIDs = [
	"/Library/InputManagers/Chax/Chax.bundle",
	"/Library/PreferencePanes/TiVoDesktop.prefPane",
	"com.adiumx.Adiumx",
	"com.kjams.kJams",
	"com.potionfactory.Tangerine",
	"com.rogueamoeba.AudioHijackPro2",
	"org.bergstrand.iScrobbler",
	"org.x.X11",
	"SQLEditor",
	"vZxeMZufQoqkixGFr",
	"YaXSUdzezdqBscUO",
]

// filter out known bad bundle IDs
let filteredItems = plist.filter {
	if let bundleID = $0["bundle"] as? String {
		return !knownBadBundleIDs.contains(bundleID)
	}

	if let displayBundleID = $0["display_bundle"] as? String {
		return !knownBadDisplayBundleIDs.contains(displayBundleID)
	}

	return true
}

// Sort items by bundle ID
let sortedItems = filteredItems.sorted {
	if let bundleID1 = $0["bundle"] as? String, let bundleID2 = $1["bundle"] as? String {
		return bundleID1 < bundleID2
	}
	return false
}

// Write to output file
let outputData = try! PropertyListSerialization.data(
	fromPropertyList: filteredItems,
	format: .xml,
	options: 0
)
try! outputData.write(to: outputFileURL)
