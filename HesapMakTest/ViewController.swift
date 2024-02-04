// ViewController.swift
import UIKit

class ViewController: UIViewController {

    var calculator = Calculator()
    var calculatorView: CalculatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalculatorView()
    }

    func setupCalculatorView() {
        calculatorView = CalculatorView()
        calculatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calculatorView)

        NSLayoutConstraint.activate([
            calculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calculatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    // ... The rest of your ViewController code ...
}
