//
//  CounterViewController.swift
//  Closure_Practice
//
//  Created by Nabiyev Anar on 14.01.26.
//

import UIKit
import SnapKit

final class CounterViewController: UIViewController {
    
    let viewModel = CounterViewModel()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    private lazy var increButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "plus"), for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapIncre), for: .touchUpInside)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = String(describing: viewModel.count)
        return label
    }()
    
    private lazy var decreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "minus"), for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapDecre), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.addSubview(hStack)
        [increButton, countLabel, decreButton].forEach(hStack.addArrangedSubview)
        
        hStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.onCountChanged = { [weak self] newValue in
            self?.countLabel.text = "\(newValue)"
        }
    }
    
    @objc
    private func didTapIncre() {
        viewModel.increment()
    }
    
    @objc
    private func didTapDecre() {
        viewModel.decrement()
    }
}

