import CommonKit
import CoreTracker
import CoreUtils
import DependencyEngine
import MemberKit

protocol ExamplePresenterInterface { 
    var shouldShowButton: Bool { get }
    var fullName: String { get }
    var shouldShowXComponent: Bool { get }

    func firstMethod() -> Bool
    func secondMethod()
}

extension ExamplePresenter {
    private enum Constants {
        static let dataFetchLimit = 2
        static let defaultBarTitle = "..."
    }
}

final class ExamplePresenter {
    private typealias View = ExampleViewInterface
    private typealias Interactor = ExampleInteractorInterface

    static let staticProperty: Int = 1
    class var classProperty: String = "Trendyol"

    private weak var view: View?
    private let interactor: Interactor
    private let userId: Int
    private lazy var manager = FavoriteManager()

    // MARK: - Identitiy Properties
    private var name: String
    private var surname: String
    var fullName: String {
        "\(name) \(surname)"
    }

    // MARK: - X Component Properties
    private var xComponentTitle: String
    private var isXComponentFlagEnabled: Bool
    var shouldShowXComponent: Bool {
        !xComponentTitle.isEmpty && isXComponentFlagEnabled
    }

    var shouldShowButton: Bool {
        firstFlag && secondFlag
    }

    var barTitle: String {
        data.productName ?? Constants.defaultBarTitle
    }

    init(view: View, interactor: Interactor, userId: Int) {
        self.view = view
        self.interactor = interactor
        self.userId = userId
    }
    
    static func workHard(motivation: Bool = true) {
        .
        .
    }

    class func beHappy() {
        .
        .
    }
}

extension ExamplePresenter {
    private func fetchFirstData() {
        .
        .
        interactor.fetchFirstData()
        .
        .
    }

    private func fetchSecondData() {
        .
        .
        interactor.fetchSecondData()
        .
        .
    }

    @discardableResult
    private func handleName(with text: String?) -> Bool {
        guard let text else { return false }
        manager.name = text
        secondMethod()
        return true
    }
}

// MARK: - ExamplePresenterInterface
extension ExamplePresenter: ExamplePresenterInterface {
    func firstMethod() -> Bool {
        .
        .
        .
        return result
    }

    func secondMethod() {
        guard isXComponentFlagEnabled else { return }
        .
        .
        .
        .
        if firstCondition {
            .
            .
        } else if secondCondition {
            .
        } else {
            .
            .
        }
        .
        .
    }
}

// MARK: - TYPopupDelegate
extension ExamplePresenter: TYPopupDelegate {
    func tyPopup(_ popup: TYPopup, didClickButtonFor type: Type) {
        .
        .
    }
}

// MARK: - FavoriteManagerDelegate
extension ExamplePresenter: FavoriteManagerDelegate {
    func favoriteManagerDidAddToListSuccessfully(_ manager: FavoriteManager) {
        .
        .
        .
    }
}

// MARK: - ExampleInteractorOutput
extension ExamplePresenter: ExampleInteractorOutput {
    func handleResult(_ result: Result<ExampleResponseModel, Error>) {
        switch result {
        case .success(let data):
            let ids = data.products.compactMap{ $0.id }
            saveProducts(with: ids)
        case .failure:
            view?.showErrorAlert()
        }
    }
}