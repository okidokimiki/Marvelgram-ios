import Foundation

final class HeroesListPresenter {
    
    weak var view: HeroesListViewInput?
    private var coordinator: HeroesListCoordinator
    
    required init(
        view: HeroesListViewInput,
        coordinator: HeroesListCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - ViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
}