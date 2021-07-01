//
//  JYBNewsChannelViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/27.
//

import UIKit

class JYBNewsChannelViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tabelView = UITableView.init(frame: CGRect.zero, style: .plain)
        tabelView.backgroundColor = .white
        tabelView.estimatedRowHeight = 77
        tabelView.tableFooterView = UIView()
        tabelView.separatorStyle = .none
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(NewsChannelCell.self, forCellReuseIdentifier: "ChannelCell")
        return tabelView
    }()
    
    private var dataArray = [JYBNewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        tableView.addPullToRefresh { [unowned self] in
            self.refresh()
        }
        tableView.addInfiniteScrolling { [unowned self] in
            self.loadmore()
        }
    }
    
    private func refresh() {
        JYBNetworkClient.requestTagNews(page: 1) { (response, error) in
            self.tableView.es.stopPullToRefresh()
            if let error = error {
                print(error)
            } else {
                if let arr = response as? [JYBNewsModel] {
                    self.dataArray = arr
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func loadmore() {
        
    }
}


extension JYBNewsChannelViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell") as! NewsChannelCell
        cell.refresh(with: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


class NewsChannelCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var stockBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitleColor(.blue, for: .normal)
        button.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(stockBtnClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var iView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        return line
    }()
    
    var whiteOnly: Bool = false
    private var constraint: Constraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView()
        setupView()
        changeSkin()
        themeChangedHandler = { [unowned self] in
            self.changeSkin()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(iView)
        iView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.right.equalTo(-13)
            make.height.equalTo(60)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(13)
            make.right.lessThanOrEqualTo(iView.snp.left).offset(-8)
            make.top.equalTo(8)
            make.height.equalTo(39)
        }
        contentView.addSubview(stockBtn)
        stockBtn.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(22)
        }
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            self.constraint = make.top.equalTo(titleLabel.snp.bottom).offset(8).constraint
            make.top.equalTo(stockBtn.snp.bottom).offset(4).priority(.medium)
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(-8)
        }
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView).inset(13)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
    }
    
    private func changeSkin() {
        if whiteOnly {
            backgroundColor = .white
            selectedBackgroundView?.backgroundColor = UIColor(hex: 0xeeeeee)
            line.backgroundColor = JYBColor_SeparateLine
            timeLabel.textColor = JYBColor_Gray
        } else {
            backgroundColor = AppTheme.manager.deepSkinBackgroundColor
            selectedBackgroundView?.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
            line.backgroundColor = AppTheme.manager.deepSkinSeparateLineColor
            timeLabel.textColor = AppTheme.manager.deepSkinGrayColor
        }
    }
    
    private func changeTitleColor() {
        
    }
    
    @objc private func stockBtnClicked() {
        
    }
    
    func refresh(with model: JYBNewsModel) {
//        iView.snp.updateConstraints { (make) in
//            make.width.equalTo((model.m_img!.count != 0) ? 88 : 0)
//        }
        titleLabel.text = model.m_title
        timeLabel.text = model.m_time
        
    }
}
