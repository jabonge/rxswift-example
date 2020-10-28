//
//  MainFeedTableViewCell.swift
//  realworld
//
//  Created by Mac on 2020/09/17.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import UIKit
import Then
import SnapKit
import Kingfisher

class MainFeedTableViewCell: UITableViewCell {

    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    private let profileImageView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 15
        $0.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    private let userNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    private let dateLabel =  UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }

        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .lightGray
        contentView.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
        }
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        let verticalStackView = UIStackView().then {
            $0.addArrangedSubview(userNameLabel)
            $0.addArrangedSubview(dateLabel)
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .equalSpacing
            $0.spacing = 5
        }
        addSubview(verticalStackView)
        let horizontalStackView = UIStackView().then {
            $0.addArrangedSubview(profileImageView)
            $0.addArrangedSubview(verticalStackView)
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 5
        }
        addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }

    }
    
    func setArticle(article: Article) {
        titleLabel.text = article.title
        contentLabel.text = article.body
        userNameLabel.text = article.author.username
        dateLabel.text = article.createdAt
        guard let url = URL(string: article.author.image) else { return }
        profileImageView.kf.setImage(with: url)
    }
    
}
