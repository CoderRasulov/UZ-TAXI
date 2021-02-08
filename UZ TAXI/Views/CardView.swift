import UIKit

class CardView: UIView {
    
    // MARK: - Properties
    
    var panGR : UIPanGestureRecognizer!
    
    var progressBool : Bool = false
    var contentOffsetY: Bool = true
    
    var constHeight: CGFloat = 250

    let cardTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: MainTableViewCell.identifire
        )
        
        tableView.register(
            HistoryTableViewCell.self,
            forCellReuseIdentifier: HistoryTableViewCell.identifire
        )
    
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    

    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        panGR = UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGR.delegate = self
        addGestureRecognizer(panGR)
        
        
        layer.cornerRadius = 32
        layer.maskedCorners = [.layerMinXMinYCorner,
                               .layerMaxXMinYCorner]
        
        backgroundColor = .systemBackground
        
        configureCardTableView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Helper Functions
        
    func configureCardTableView() {
        addSubview(cardTableView)
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        cardTableView.anchor(
            top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
            paddingTop: 20, paddingBottom: 0.1 * UIScreen.main.bounds.height
        )
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension CardView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let workerMainCell = tableView.dequeueReusableCell(
                withIdentifier: MainTableViewCell.identifire, for: indexPath
            ) as! MainTableViewCell
            
            
            
            
            
            return workerMainCell
        } else {
            let workerDescriptionCell = tableView.dequeueReusableCell(
                withIdentifier: HistoryTableViewCell.identifire, for: indexPath
            ) as! HistoryTableViewCell
            
           
            
            return workerDescriptionCell
        }
        
    }
}

// MARK: - UIGestureRecognizerDelegate

extension CardView : UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}
