import UIKit

protocol HeroDetailsViewUiDelegate: AnyObject {
}

final class HeroDetailsView: UIView {
    
    weak var uiDelegate: HeroDetailsViewUiDelegate?
    
    private lazy var scrollView: UIScrollView = {
        makeScrollView()
    }()
    
    private lazy var profileImageView: UIImageView = {
        makeProfileImageView()
    }()
    
    private lazy var descrpLabel: TopAlignedLabel = {
        makeDescrpLabel()
    }()
    
    private lazy var exploreMoreLabel: UILabel = {
        makeExploreMoreLabel()
    }()
    
    private lazy var otherHeroesCollectionView: OtherHeroesCollectionView = {
        makeOtherHeroesCollectionView(self, self)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.GlobalColor.background
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = AppColor.GlobalColor.background
        setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        setupAutoLayout()
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(descrpLabel)
        scrollView.addSubview(exploreMoreLabel)
        scrollView.addSubview(otherHeroesCollectionView)
    }
    
    private func setupAutoLayout() {
        activateScrollViewConstraints()
        activateProfileImageViewConstraints()
        activateDescrpLabelConstraints()
        activateExploreMoreLabelConstraints()
        activateOtherHeroesCollectionViewConstraints()
    }
    
    func finishLayoutSubviews() {
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
        descrpLabel.addInterlineSpacing(spacingValue: Constants.descrpLabelInterlineSpacing)
        activateSubviewsWidthLayoutConstraint()
    }
    
    // MARK: - Creating Subviews
    
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }
    
    private func makeProfileImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = AppColor.GlobalColor.cellBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    private func makeDescrpLabel() -> TopAlignedLabel {
        let label = TopAlignedLabel()
        label.font = AppFont.SFPro.regular14
        label.textColor = AppColor.GlobalColor.font
        label.numberOfLines = Constants.descrpLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func makeExploreMoreLabel() -> UILabel {
        let label = UILabel()
        label.font = AppFont.SFPro.bold34
        label.text = AppLocalize.HeroDetails.exploreMoreTitle
        label.textColor = AppColor.GlobalColor.font
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func makeOtherHeroesCollectionView(
        _ actionDelegate: OtherHeroesCollectionViewActionDelegate,
        _ dataSourceDelegate: OtherHeroesCollectionViewDataSourceDelegate) -> OtherHeroesCollectionView {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = Constants.FlowLayout.baseInsets
            
            let collectionView = OtherHeroesCollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.dataSourceDelegate = dataSourceDelegate
            collectionView.actionDelegate = actionDelegate
            
            return collectionView
        }
    
    // MARK: - AutoLayout
    
    private func activateScrollViewConstraints() {
        let subview = scrollView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            subview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func activateProfileImageViewConstraints() {
        let subview = profileImageView
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: scrollView.topAnchor),
            subview.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func activateDescrpLabelConstraints() {
        let subview = descrpLabel
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Constants.AutoLayout.baseOffset),
            subview.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,
                                         constant: Constants.AutoLayout.baseOffset),
            subview.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.AutoLayout.descrpLabelHeightValue)
        ])
    }
    
    private func activateExploreMoreLabelConstraints() {
        let subview = exploreMoreLabel
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Constants.AutoLayout.baseOffset),
            subview.topAnchor.constraint(equalTo: descrpLabel.bottomAnchor)
        ])
    }
    
    private func activateOtherHeroesCollectionViewConstraints() {
        let subview = otherHeroesCollectionView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            subview.topAnchor.constraint(equalTo: exploreMoreLabel.bottomAnchor,
                                         constant: Constants.AutoLayout.otherHeroesCollectionViewTopOffset),
            subview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            subview.heightAnchor.constraint(equalToConstant: Constants.AutoLayout.otherHeroesCollectionViewHeightValue)
        ])
    }
    
    private func activateSubviewsWidthLayoutConstraint() {
        let width = scrollView.bounds.width
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: width),
            profileImageView.widthAnchor.constraint(equalToConstant: width),
            otherHeroesCollectionView.widthAnchor.constraint(equalToConstant: width),
            descrpLabel.widthAnchor.constraint(equalToConstant: width - Constants.AutoLayout.descrpLabelTrailingOffset)
        ])
    }
    
    // MARK: - Constants
    
    enum Constants {
        static let descrpLabelNumberOfLines = 0
        static let descrpLabelInterlineSpacing: CGFloat =  1.32
        
        enum AutoLayout {
            static let baseOffset: CGFloat = 16
            
            static let descrpLabelTrailingOffset: CGFloat = 32
            static let descrpLabelHeightValue: CGFloat = 148
            
            static let otherHeroesCollectionViewTopOffset: CGFloat = 18
            static let otherHeroesCollectionViewHeightValue: CGFloat = 120
        }
        
        enum FlowLayout {
            static let baseInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}

// MARK: - ActionDelegate

extension HeroDetailsView: OtherHeroesCollectionViewActionDelegate {
}

// MARK: - DataSourceDelegate

extension HeroDetailsView: OtherHeroesCollectionViewDataSourceDelegate {
}
