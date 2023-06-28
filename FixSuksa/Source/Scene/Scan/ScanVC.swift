//
//  ScanVC.swift
//  FixSuksa
//
//  Created by 임준화 on 2023/06/28.
//

import UIKit
import CoreBluetooth

final class ScanVC: UIViewController, BluetoothSerialDelegate{
    
    private let tableView = UITableView()
    
    var peripheralList : [(peripheral : CBPeripheral, RSSI : Float)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        peripheralList = []
        serial.delegate = self
        serial.startScan()
    }

    func addView(){
        view.addSubview(tableView)
    }
    
    func setLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ScanVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheralList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScanTableViewCell.identifier, for: indexPath) as? ScanTableViewCell else {
            return UITableViewCell()
        }
        
        let peripheralName = peripheralList[indexPath.row].peripheral.name
        cell.updatePeriphralsName(name: peripheralName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        serial.stopScan()
        let selectedPeripheral = peripheralList[indexPath.row].peripheral
        serial.connectToPeripheral(selectedPeripheral)
    }
    
    func serialDidDiscoverPeripheral(peripheral : CBPeripheral, RSSI : NSNumber?) {
        for existing in peripheralList {
            if existing.peripheral.identifier == peripheral.identifier {return}
        }
        let fRSSI = RSSI?.floatValue ?? 0.0
        peripheralList.append((peripheral : peripheral , RSSI : fRSSI))
        peripheralList.sort { $0.RSSI < $1.RSSI}
        tableView.reloadData()
    }
    
    func serialDidConnectPeripheral(peripheral : CBPeripheral) {
        let connectSuccessAlert = UIAlertController(title: "블루투스 연결 성공", message: "\(peripheral.name ?? "알수없는기기")와 성공적으로 연결되었습니다.", preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: { _ in self.dismiss(animated: true, completion: nil) } )
        connectSuccessAlert.addAction(confirm)
        serial.delegate = nil
        present(connectSuccessAlert, animated: true, completion: nil)
    }
}
