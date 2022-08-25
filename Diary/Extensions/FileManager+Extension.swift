//
//  FileManager+Extension.swift
//  Diary
//
//  Created by SC on 2022/08/26.
//

import UIKit

extension UIViewController {
    func saveImageToDocuments(fileName: String, image: UIImage) {
        // Documents 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlertMessage(title: "사진을 저장할 Documents 폴더 찾기에 실패하였습니다.")
            return
        }
        let fileURL = documentDirectory.appendingPathComponent(fileName)  // 세부 경로. 이미지 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            showAlertMessage(title: "파일 압축에 실패하였습니다.")
            return
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("Error in saving the image file: \(error)")
        }
    }
}
