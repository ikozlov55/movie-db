//
//  PinAuthorizationNumpadViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 18.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип набора кнопок на клавиатуре ввод пин-кода
enum NumpadState {
    case makePin
    case fastLoginNoInput
    case fastLogin
}

/// Тип, ответственный за обработку нажатия кнопок на клавиатуре ввода пин-кода
protocol PinAuthorizationNumpadDelegate: class {
    
    /// Обработка нажатия кнопки на клавиатуре ввода пин-кода
    /// - Parameter type: Тип нажатой кнопки
    func buttonPressed(_ controller: PinAuthorizationNumpadViewController, type: NumpadButtonType)
}

final class PinAuthorizationNumpadViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: PinAuthorizationNumpadDelegate?
    
    // MARK: - Private Properties
    
    private var numpadView = PinAuthorizationNumpadView()
    
    private lazy var numpadDataSource = NumpadDataSource()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = numpadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numpadView.collectionView.delegate = self
        numpadView.collectionView.dataSource = numpadDataSource
    }
    
    // MARK: - Public methods
    
    /// Отображение набора кнопок на клавиатуре ввода в соответсвии с заданным типz
    /// - Parameter state: Тип клавиатуры, который необходимо отобразить
    func setNumpadState(_ state: NumpadState) {
        var numpad: [NumpadButtonType] = [
            .number(1), .number(2), .number(3),
            .number(4), .number(5), .number(6),
            .number(7), .number(8), .number(9),
            .placeholder, .number(0), .backspace
        ]
        
        switch state {
        case .makePin:
            break
        case .fastLoginNoInput:
            numpad[9] = .exit
            numpad[11] = .faceId
        case .fastLogin:
            numpad[9] = .exit
        }
        numpadDataSource.buttons = numpad
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PinAuthorizationNumpadViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let diameter = collectionView.frame.width / 3 - 20
        
        return CGSize(width: diameter, height: diameter)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.buttonPressed(self, type: numpadDataSource.buttons[indexPath.row])
    }
}
