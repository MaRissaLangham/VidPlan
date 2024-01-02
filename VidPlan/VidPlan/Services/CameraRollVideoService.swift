//
//  CameraRollVideoService.swift
//  VidPlan
//
//  Created by Marissa Langham on 1/1/24.
//

import Photos

// Request authorization to access the photo library
func PhotoLibraryAuthorization() 
{ PHPhotoLibrary.requestAuthorization
    { status in
        if status == .authorized{fetchVideos()}
        else {print("Access to photo library denied")}
    }
}

func fetchVideos() 
{
    // Fetch all videos from the photo library
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
    let allVideos = PHAsset.fetchAssets(with: fetchOptions)

    // Iterate through each video asset
    allVideos.enumerateObjects 
    { (asset, count, stop) in
        // Extract metadata
        let filename = asset.value(forKey: "filename") as? String ?? "Unknown"
        let creationDate = asset.creationDate
        let duration = asset.duration
        let mediaType = asset.mediaType
    }
}
