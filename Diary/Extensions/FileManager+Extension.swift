//
//  FileManager+Extension.swift
//  Diary
//
//  Created by SC on 2022/08/26.
//

import UIKit

extension UIViewController {
    func getDocumentsDirectoryPath() -> URL? {
        // Documents 경로
        guard let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlertMessage(title: "Documents 폴더 찾기에 실패했습니다.")
            return nil
        }
        
        return documentDirectoryPath
    }
    
    func saveImageToDocuments(fileName: String, image: UIImage) {
        // Documents 경로
//        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            showAlertMessage(title: "사진을 저장할 Documents 폴더 찾기에 실패했습니다.")
//            return
//        }
        guard let documentDirectoryPath = getDocumentsDirectoryPath() else { return }
        let fileURL = documentDirectoryPath.appendingPathComponent(fileName)  // 세부 경로. 이미지 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            showAlertMessage(title: "파일 압축에 실패했습니다.")
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
//        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            showAlertMessage(title: "사진 경로 찾기에 실패했습니다.")
//            return nil
//        }
        guard let documentDirectoryPath = getDocumentsDirectoryPath() else { return nil }
        let fileURL = documentDirectoryPath.appendingPathComponent(fileName)  // 세부 경로. 이미지의 위치
        
        // 이미지 파일 존재 여부 확인
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "photo.artframe")  // 기본 이미지
        }
    }
    
    func removeImageFromDocuments(fileName: String) {
        guard let documentDirectoryPath = getDocumentsDirectoryPath() else { return }
        let fileURL = documentDirectoryPath.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch let error {
                showAlertMessage(title: "이미지 파일 삭제에 실패했습니다.")
                print(error)
            }
        }
//        else {
//            showAlertMessage(title: "이미지 파일 찾기에 실패했습니다.")
//        }
    }
    
    func fetchDiaryFilesFromDocuments() -> [String]? {
        do {
            guard let documentDirectoryPath = getDocumentsDirectoryPath() else { return nil }
//            let allFiles = try FileManager.default.contents(atPath: documentDirectoryPath.path)  // nil
            let allFilesURLs = try FileManager.default.contentsOfDirectory(at: documentDirectoryPath, includingPropertiesForKeys: nil)
//            print("allFiles: \(allFilesURLs)")
            print("allFiles.count: \(allFilesURLs.count)")
            
            let allDiaryFilesURLs = allFilesURLs.filter { $0.pathExtension == "diary" }  // pathExtension: 확장자
            let allDiaryFileNames = allDiaryFilesURLs.map { $0.lastPathComponent }
//            print("allDiaryFileNames: \(allDiaryFileNames)")
            print("allDiaryFileNames.count: \(allDiaryFileNames.count)")
            
            return allDiaryFileNames.sorted().reversed()
        } catch let error {
            showAlertMessage(title: "백업 파일 찾기 오류", message: "앱 내 Documents 폴더에서 백업 파일 찾기에 실패했습니다.")
            print(error)
            return nil
        }
    }
}


