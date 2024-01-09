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
    // Fetch all videos sorted by creation date
   let options = PHFetchOptions()
   options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
   options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)

   let allVideos = PHAsset.fetchAssets(with: options)

   // Iterate through each video asset
   allVideos.enumerateObjects
    { (asset, count, stop) in
       // Extract metadata
       let localIdentifier = asset.localIdentifier
       let creationDate = asset.creationDate
       let duration = asset.duration

       // Retrieve thumbnail
       PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil)
       { image, _ in
           // Use optional binding to safely handle the optional image
           if let image = image
           {
               print("Thumbnail:", image)
           }
           else
           {
               print("Failed to retrieve thumbnail")
           }
       }

       // Retrieve video asset for playback or editing (optional)
       PHImageManager.default().requestAVAsset(forVideo: asset, options: nil)
       { avAsset, _, _ in
           if let asset = avAsset as? AVURLAsset
           {   // Use the AVAsset for playback or other operations
               print("Video URL:", asset.url)
           }
       }
   }
}



