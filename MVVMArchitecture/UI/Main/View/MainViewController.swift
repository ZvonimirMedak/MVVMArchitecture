//
//  MainViewController.swift
//  MVVMArchitecture
//
//  Created by Zvonimir Medak on 24.04.2021..
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        return tv
    }()
    
    private let progressView: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .large)
        progress.color = .red
        return progress
    }()
    
    
    private let disposeBag = DisposeBag()
    private let mainViewModel: MainViewModel
    
    public init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initializeViewModel()
        mainViewModel.loadDataSubject.onNext(())
    }
}

private extension MainViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(progressView)
        setupConstraints()
        setupTableView()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

private extension MainViewController {
    
    func initializeViewModel() {
        disposeBag.insert(mainViewModel.initializeViewModel())
        disposeBag.insert(initializeUsersRelay(for: mainViewModel.usersRelay))
        disposeBag.insert(initializeLoaderSubject(for: mainViewModel.loaderSubject))
    }
    
    func initializeUsersRelay(for subject: BehaviorRelay<[User]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [unowned self] (_) in
                tableView.reloadData()
            })
    }
    
    func initializeLoaderSubject(for subject: PublishSubject<Bool>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (status) in
                handleLoaderStatus(status)
            })
    }
    
    func handleLoaderStatus(_ status: Bool) {
        if status {
            progressView.isHidden = false
            progressView.startAnimating()
        } else {
            progressView.isHidden = true
            progressView.stopAnimating()
        }
    }
}

private extension MainViewController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.usersRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let safeUserCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        let currentItem = mainViewModel.usersRelay.value[indexPath.row]
        safeUserCell.configure(for: currentItem)
        return safeUserCell
    }
    
    
}
