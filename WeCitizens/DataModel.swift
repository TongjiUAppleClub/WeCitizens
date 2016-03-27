//
//  DataModel.swift
//  WeCitizens
//
//  Created by Teng on 2/10/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class DataModel {
    func convertPFFileToImage(rawFile:PFFile?) -> UIImage? {
        var image:UIImage? = nil
        do {
            let imageData = try rawFile?.getData()
            if let data = imageData {
                image = UIImage(data: data)
            }
        } catch {
            print("")
        }
        return image
    }
    
    func convertArrayToImages(rawArray:NSArray) -> [UIImage] {
        var imageList = [UIImage]()
        for tmp in rawArray {
            let imageFile = tmp as! PFFile
            
            do {
                let imageData = try imageFile.getData()
                let image = UIImage(data: imageData)
                imageList.append(image!)
            } catch {
                print("")
            }
        }
        return imageList
    }

    func convertImageToPFFile(rawImageArray:[UIImage]) -> [PFFile] {
        var imageFileArray = [PFFile]()
        
        for image in rawImageArray {
            let imageData = UIImageJPEGRepresentation(image, 0.5)
            
            if let data = imageData {
                let imageFile = PFFile(name: nil, data: data)
                imageFileArray.append(imageFile!)
            } else {
                let imageDataPNG = UIImagePNGRepresentation(image)
                if let dataPNG = imageDataPNG {
                    let imageFile = PFFile(name: nil, data: dataPNG)
                    imageFileArray.append(imageFile!)
                } else {
                    //图片格式非PNG或JPEG
                    print("图片格式非PNG或JPEG，给用户个提示")
                }
            }
        }
        
        return imageFileArray
    }
}
