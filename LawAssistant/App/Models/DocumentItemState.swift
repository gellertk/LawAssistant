//
//  DocumentItemState.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 13.11.2022.
//

import Foundation

enum DocumentItemViewState {
    case uploading(CGFloat)
    case downloading(CGFloat)
    case uploaded
    case downloaded(DocumentPreviewState)
}

enum DocumentPreviewState {
    case previewUnknown
    case previewDownloaded
    case previewUnavailable
}
