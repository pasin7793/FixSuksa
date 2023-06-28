//
//  ViewController.swift
//  FixSuksa
//
//  Created by 임준화 on 2023/06/28.
//

import UIKit
import Then
import SnapKit

final class MainVC: UIViewController, BluetoothSerialDelegate{

    private let scanButton = UIButton().then{
        $0.addTarget(self, action: #selector(scanButtonDidTap), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serial = BluetoothSerial.init()
    }

    @objc func scanButtonDidTap(){
        let vc = ScanVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

