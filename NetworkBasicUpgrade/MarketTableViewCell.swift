//
//  MarketTableViewCell.swift
//  NetworkBasicUpgrade
//
//  Created by 김윤우 on 6/5/24.
//

import UIKit
import SnapKit

class MarketTableViewCell: UITableViewCell {
    // 변경되지 않는 데이터
    // NIB == XIB xib가 없다면 이 코드는 실행되지 않음
    // 그릇을 세팅해주는 초기화 구문
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//    }
    let nameLabel = UILabel()
    static let identifier = "MarketTableViewCell"
    
    // viewDidload랑 비슷
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // VC view -> contentView
        // contentView.addSubview 버튼 동작에 이슈가 없음
        // 그냥 addSubView를 해도 보이기는 함
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        nameLabel.textColor = .brown
        nameLabel.font = .systemFont(ofSize: 16)
    }
    
    //
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
