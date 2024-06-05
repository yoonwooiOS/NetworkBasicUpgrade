//
//  ViewController.swift
//  NetworkBasicUpgrade
//
//  Created by 김윤우 on 6/5/24.
//

import UIKit
import SnapKit
import Alamofire

struct Lotto: Decodable {
    let drwNoDate: String
    let totSellamnt:Int
}


class ViewController: UIViewController {
    
    let numberTextField = UITextField()
    let checkButton = UIButton()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
    }

    
    func configureHierarchy() {
        
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
        
    }
    
    func configureLayout() {
        numberTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        checkButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(300)
            make.height.equalTo(50)
            
        }
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(checkButton.snp.bottom).offset(20)
        }
        
    }
    
    func configureUI() {
        
        view.backgroundColor = .systemBackground
        numberTextField.backgroundColor = .gray
        checkButton.backgroundColor = .brown
        checkButton.setTitle("로또 당첨 번호 확인", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        resultLabel.backgroundColor = .darkGray
        resultLabel.numberOfLines = 0
        resultLabel.font = .systemFont(ofSize: 15)
    }

    // Swift.DecodingError.keyNotFound
    // 1. URL 확인
    // 2. responseString 확인하기
    // 3. nil 구조체에서 옵셔널 타입으로 바꿔서 nil값이 들어오는지 확인
    @objc func checkButtonClicked() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(numberTextField.text!)"
        print("11111")
//        AF.request(url).responseString { response in
//                print(response)
//        }
        
        //self
        //AF안에 resultLabel이 있을지 없을지 모름
        // 저 프로퍼티는 개발자가 쓴거야 라고 알려주는 것
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.resultLabel.text = "\(value.drwNoDate)\n1등 당첨 금액: \(value.totSellamnt.formatted())원"
            case .failure(let error):
                print(error)
                self.resultLabel.text = "올바른 값을 입력해주세요"
            }
            
        }
        print("2222222")
    }
}

