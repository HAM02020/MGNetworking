//
//  ViewController.swift
//  iOS Example
//
//  Created by sheng on 2023/9/15.
//

import UIKit
import MGNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Task{
            let pictureModel: PictureModel = try await PictureApi.provider.request(.getPicture(pictureId: 1))
                .tryParseResultToModel()
            
            debugPrint(pictureModel)
            
            let pictureData = UIImage().jpegData(compressionQuality: 1) ?? Data()
            let multipartFormData = MultipartFormData()
            multipartFormData.append(pictureData, withName: "Picture.jpg", mimeType: "image/jpeg")
            
            await PictureApi.provider.request(.uploadPicture(multipartFormData: multipartFormData, uploadProgress: { progress in
                debugPrint("上传进度: \(progress)")
            }))
            
        }
        
    }


}

