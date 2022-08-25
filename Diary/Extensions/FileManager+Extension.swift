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
    
    func loadImageFromDocuments(fileName: String) -> UIImage? {
        // Documents 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlertMessage(title: "사진 경로 찾기에 실패하였습니다.")
            return nil
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)  // 세부 경로. 이미지의 위치
        
        // 이미지 파일 존재 여부 확인
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "photo.artframe")  // 기본 이미지
        }
    }
}


