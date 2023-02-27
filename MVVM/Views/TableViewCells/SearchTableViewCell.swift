//
//  SearchTableViewCell.swift
//  MVVM
//
//  Created by Adil Gumarov on 08.11.2022.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    private let label = UILabel()
    private let stateImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(10)
        }
        contentView.addSubview(stateImageView)
        stateImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func setText(_ text: String) {
        label.text = text
    }
    
    func setAddedState(_ state: Bool) {
        if state {
            selectionStyle = .none
            stateImageView.image = UIImage(systemName: "checkmark")
        } else {
            selectionStyle = .default
            stateImageView.image = UIImage(systemName: "plus")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
