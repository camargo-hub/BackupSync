import Foundation

struct BackupConfig {
    var sourcePath: String
    var destinationPaths: [String] = []
    var isMonitoring: Bool = false
    var excludePatterns: [String] = [".DS_Store", "*.tmp", "*.lock"]
    
    var isValid: Bool {
        return !sourcePath.isEmpty && destinationPaths.count == 2
    }
}

struct SyncEvent {
    enum EventType {
        case fileAdded
        case fileModified
        case fileDeleted
        case folderCreated
    }
    
    let path: String
    let type: EventType
    let timestamp: Date
    var status: SyncStatus = .pending
}

enum SyncStatus {
    case pending
    case syncing
    case completed
    case failed(String)
}

struct SyncMetadata: Codable {
    var lastSyncTimestamp: Date
    var syncedFiles: [String: FileMetadata]
}

struct FileMetadata: Codable {
    let path: String
    let modificationDate: Date
    let fileSize: Int64
    let checksum: String
}
