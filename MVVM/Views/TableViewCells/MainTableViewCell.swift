//
//  MainTableViewCell.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    let universityName: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .red
        return label
    }()
    
    let pageLink: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .blue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(universityName)
        contentView.addSubview(pageLink)
        
        universityName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(5)
            make.height.equalTo(50)
        }
        
        pageLink.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(35)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
