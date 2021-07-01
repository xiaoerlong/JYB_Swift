//
//  JYBThemeSettingViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/14.
//

import UIKit

/// 风格设置
class JYBThemeSettingViewController: UIViewController {

    let JYBThemeSettingCellIdentifier = "JYBThemeSettingCellIdentifier"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 45
        tableView.register(JYBThemeSettingCell.self, forCellReuseIdentifier: JYBThemeSettingCellIdentifier)
        return tableView
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
        self.themeChangedHandler = { [unowned self] in
            // navigationBar背景颜色
            self.tableView.backgroundColor = AppTheme.manager.deepSkinBackgroundColor
        }
    }
    
    // 设置导航栏
    func setNavigationBar() {
        navigationItem.title = "风格设置"
    }
    
    // 设置视图
    func setupView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo((UIEdgeInsets.zero))
        }
    }
}

extension JYBThemeSettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppTheme.self.Type.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JYBThemeSettingCellIdentifier) as! JYBThemeSettingCell
        let theme = AppTheme.self.Type.allCases[indexPath.row]
        cell.titleLabel.text = theme.rawValue
        cell.rightImageView.isHidden = true
        if theme == AppTheme.manager.currentTheme {
            cell.rightImageView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        AppTheme.manager.setTheme(AppTheme.self.Type.allCases[indexPath.row])
        tableView.reloadData()
    }
}

class JYBThemeSettingCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "selected_btn")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(rightImageView)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(13)
            make.centerY.equalTo(contentView)
        }
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-13)
            make.centerY.equalTo(contentView)
        }
        
        self.themeChangedHandler = { [unowned self] in
            self.titleLabel.textColor = AppTheme.manager.deepSkinBlackColor
            switch AppTheme.manager.currentTheme {
            case .default:
                self.backgroundColor = .white
            case .dark:
                self.backgroundColor = .clear
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
