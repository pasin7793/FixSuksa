//
//  ViewController.swift
//  FixSuksa
//
//  Created by 임준화 on 2023/06/28.
//

import UIKit
import Then
import SnapKit
import CoreBluetooth

final class MainVC: UIViewController, BluetoothSerialDelegate{

    private let scanButton = UIButton().then{
        $0.addTarget(self, action: #selector(scanButtonDidTap), for: .touchUpInside)
        $0.setTitle("스캔", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        serial = BluetoothSerial.init()
    }

    func addView(){
        view.addSubview(scanButton)
    }
    
    func setLayout(){
        scanButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func scanButtonDidTap(){
        let vc = ScanVC()
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
}

