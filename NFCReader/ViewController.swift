//
//  ViewController.swift
//  NFCReader
//
//  Created by Iko Nakari on 2017/12/14.
//  Copyright © 2017年 Iko Nakari. All rights reserved.
//

import UIKit
import CoreNFC
import SnapKit

class ViewController: UIViewController {

    var session: NFCNDEFReaderSession?
    
    let scanBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("scan", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(scanDidTap), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(scanBtn)
        
        scanBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func scanDidTap() {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "NFCタグをiPhoneに近づけてね"
        session?.begin()
    }

}

extension ViewController: NFCNDEFReaderSessionDelegate{
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("error")
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("success! \(messages.count)個のデータ取得")
        for message in messages {
            print("- \(message.records.count)個の詳細：")
            for record in message.records{
                print("- \(record)")
            }
        }
        
    }

}
