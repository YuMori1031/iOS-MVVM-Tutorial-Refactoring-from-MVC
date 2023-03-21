/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import RxSwift

class WeatherViewController: UIViewController {
  private let geocoder = LocationGeocoder()
  private let viewModel = WeatherViewModel()
  
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  override func viewDidLoad() {
    viewModel.locationName
      .bind(to: cityLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.date
      .bind(to: dateLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.icon
      .bind(to: currentIcon.rx.image)
      .disposed(by: disposeBag)
    
    viewModel.summary
      .bind(to: currentSummaryLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.forecastSummary
      .bind(to: forecastSummary.rx.text)
      .disposed(by: disposeBag)
    
    /*
    viewModel.locationName.subscribe(onNext: { [weak self] city in
      self?.cityLabel.text = city
    }).disposed(by: disposeBag)
    
    viewModel.date.subscribe(onNext: { [weak self] date in
      self?.dateLabel.text = date
    }).disposed(by: disposeBag)
    
    viewModel.icon.subscribe(onNext: { [weak self] icon in
      self?.currentIcon.image = icon
    }).disposed(by: disposeBag)
    
    viewModel.summary.subscribe(onNext: { [weak self] summary in
      self?.currentSummaryLabel.text = summary
    }).disposed(by: disposeBag)
    
    viewModel.forecastSummary.subscribe(onNext: { [weak self] forecastsummary in
      self?.forecastSummary.text = forecastsummary
    }).disposed(by: disposeBag)
    */
    
    /*
    viewModel.locationName.bind { [weak self] locationName in
      self?.cityLabel.text = locationName
    }
    
    viewModel.date.bind { [weak self] date in
      self?.dateLabel.text = date
    }
    
    viewModel.icon.bind { [weak self] image in
      self?.currentIcon.image = image
    }
    
    viewModel.summary.bind { [weak self] summary in
      self?.currentSummaryLabel.text = summary
    }
    
    viewModel.forecastSummary.bind { [weak self] forecast in
      self?.forecastSummary.text = forecast
    }
    */
  }
  
  @IBAction func promptForLocation(_ sender: Any) {
    let alert = UIAlertController(
      title: "Choose location",
      message: nil,
      preferredStyle: .alert)
    alert.addTextField()
    let submitAction = UIAlertAction(
      title: "Submit",
      style: .default) { [unowned alert, weak self] _ in
        guard let newLocation = alert.textFields?.first?.text else { return }
        self?.viewModel.changeLocation(to: newLocation)
      }
    alert.addAction(submitAction)
    present(alert, animated: true)
  }
}
