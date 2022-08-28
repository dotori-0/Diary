//
//  SettingsViewController.swift
//  Diary
//
//  Created by SC on 2022/08/27.
//

import UIKit

import Zip

class SettingsViewController: BaseViewController {
    let settingsView = SettingsView()
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "설정 화면"
        return label
    }()
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        title = "타이틀"  // Tab Bar Title
    }

    override func setUI() {
        super.setUI()
        print(self, #function)
        settingsView.navigationBar.delegate = self
        settingsView.addSubview(testLabel)
        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self
        settingsView.tableView.register(BackupFileTableViewCell.self, forCellReuseIdentifier: BackupFileTableViewCell.reuseIdentifier)
    }
    
    override func setConstraints() {
        testLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func setActions() {
        settingsView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        settingsView.bringBackupFileButton.addTarget(self, action: #selector(bringBackupFileButtonClicked), for: .touchUpInside)
    }
    
    @objc func backupButtonClicked() {
        var urlPaths = [URL]()  // 백업할 파일의 배열
        
        // 1. 도큐먼트 위치에 백업 파일이 있는지 확인
//        guard let documentsPath = getDocumentsDirectoryPath() else {
//            showAlertMessage(title: "앱 내 도큐먼트 위치에 오류가 있습니다.")
//            return
//        }
        guard let documentsPath = getDocumentsDirectoryPath() else { return }
        
        let realmFilePath = documentsPath.appendingPathComponent("default.realm")  // 렘 파일 경로 가져오기
        
        // realm 파일 존재 여부 확인
        guard FileManager.default.fileExists(atPath: realmFilePath.path) else {  // 👻 (atPath:isDirectory) 써 보기
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        
        urlPaths.append(realmFilePath)  //  urlPaths.append(URL(string: realmFile.path)!)와 동일
        
        // 2. 백업 파일을 압축: URL (오픈소스 활용)
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd_HH:mm:ss"
            print(formatter.string(from: Date.now))
            let fileName = formatter.string(from: Date.now)
            
            var isValidExtension = Zip.isValidFileExtension("diary")
            print("isValidExtension: \(isValidExtension)")
            Zip.addCustomFileExtension("diary")
            isValidExtension = Zip.isValidFileExtension("diary")
            print("isValidExtension: \(isValidExtension)")
            
//            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: fileName)  // 👻 quickZipFiles의 progress 파라미터 써 보기
            let zipFilePath = documentsPath.appendingPathComponent("\(fileName).diary")
            try Zip.zipFiles(paths: urlPaths, zipFilePath: zipFilePath, password: nil, progress: { progress in
                print(progress)
            })

            print("Archive Location: \(zipFilePath)")

            showAlertMessage(title: "백업 완료", message: "백업이 완료되었습니다.\n 백업 파일을 안전한 곳으로 내보내 주세요!") { _ in
                self.showActivityViewController(backupFileURL: zipFilePath)
            }
        } catch let error {
            showAlertMessage(title: "백업 파일 압축에 실패했습니다.")
            print(error)
        }
    }
    
    func showActivityViewController(backupFileURL: URL) {
        let activityVC = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        present(activityVC, animated: true)
    }
    
    @objc func bringBackupFileButtonClicked() {
        
    }
}


extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupFileTableViewCell.reuseIdentifier) as? BackupFileTableViewCell else {
            print("Cannot find BackupFileTableViewCell")
            return UITableViewCell()
        }
        
        fetchDiaryFilesFromDocuments()
        
        cell.fileNameLabel.text = "파일 이름"
        cell.fileSizeLabel.text = "파일 크기"
        
        return cell
    }
}


extension SettingsViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
