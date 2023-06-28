//
//  ScanTableViewCell.swift
//  FixSuksa
//
//  Created by 임준화 on 2023/06/28.
//

import UIKit
import SnapKit
import Then

final class ScanTableViewCell: UITableViewCell{
    
    static let identifier = "ScanCell"
    
    private let peripheralLabel = UILabel().then{
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.sizeToFit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        contentView.addSubview(peripheralLabel)
    }

    private func setLayout() {
        peripheralLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
    }
    
    func updatePeriphralsName(name : String?){
        guard name != nil else { return }
        peripheralLabel.text = name
    }
}

