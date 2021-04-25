//
//  UserTableViewCell.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import SnapKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for user: User) {
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
        avatarImageView.kf.setImage(with: URL(string: user.avatar), placeholder: UIImage(named: "avatar_placeholder"), options: [], completionHandler: nil)
    }
}

private extension UserTableViewCell {
    
    func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.addSubview(avatarImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userEmailLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.leading.top.bottom.equalToSuperview().inset(4).priority(.low)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-8)
            make.top.equalToSuperview().inset(4)
        }

        userEmailLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-8)
            make.top.equalTo(userNameLabel.snp.bottom)
        }
    }
}
