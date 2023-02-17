//
//  FileProcessing.swift
//

import Foundation

// ------------------------------------------------------------------------------------------------
func readStringFromFile(filename: String) -> String?
{
    var contents : String?
        
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = dir.appendingPathComponent(filename)
            
    do
    {
        contents = try String(contentsOfFile: fileURL.path, encoding: .utf8 )
    }
    catch
    {
        print( "ERROR: file '\(filename)' could not be read!")
    }

    return contents
}

// ------------------------------------------------------------------------------------------------
func writeStringToFile(filename: String, contents: String)
{
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = dir.appendingPathComponent(filename)
            
    do
    {
        try contents.write(to: fileURL, atomically: true, encoding: .utf8)
    }
    catch
    {
        print( "ERROR: failed to write to file \(filename)!" )
    }
}

// ------------------------------------------------------------------------------------------------
func getDataFilename() -> String
{
    let now = Date()
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: now)
    
    let year = String(format: "%04d", components.year!)
    let month = String(format: "%02d", components.month!)
    let day = String(format: "%02d", components.day!)
    let hour = String(format: "%02d", components.hour!)
    let minute = String(format: "%02d", components.minute!)

    let filename = "\(year)\(month)\(day)\(hour)\(minute).jsonl"
    return filename
}

// ------------------------------------------------------------------------------------------------
func getFileList( extensionString : String ) -> [String]
{
    let documentsPath = NSSearchPathForDirectoriesInDomains(
        FileManager.SearchPathDirectory.documentDirectory,
        FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    var fileList = try! FileManager.default.contentsOfDirectory(atPath: documentsPath)
    
    return fileList.filter { $0.hasSuffix(extensionString) }
}
