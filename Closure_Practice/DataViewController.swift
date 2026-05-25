//
//  DataViewController.swift
//  Closure_Practice
//
//  Created by Nabiyev Anar on 18.01.26.
//

import UIKit
import SnapKit

final class DataViewController: UIViewController {
    
    private let viewModel = DataViewModel()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Salam"
        label.textColor = .black
        return label
    }()
    
    private lazy var loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(loadTapped), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.addSubview(vStack)
        view.addSubview(activityIndicator)
        [titlelabel, loadButton].forEach(vStack.addArrangedSubview)
        
        vStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.onLoadingStarted = { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.loadButton.isEnabled = false
        }
        
        viewModel.onLoadingFinished = { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.loadButton.isEnabled = true
        }
        
        viewModel.onDataLoaded = { [weak self] data in
            self?.titlelabel.text = data.joined(separator: "\n")
        }
        
        viewModel.onError = { [weak self] error in
            self?.titlelabel.text = error
        }
    }
    
    @objc
    private func loadTapped() {
        viewModel.loadData()
    }
}
