
enum ScreenState {
    case choose
    case change
    case openentChoose
    case showOponent
    case tie
    case win
    case lose
    
}
enum Choices {
    case paper
    case rock
    case scissors
    case none
    
    var name: String {
        switch self {
        case .paper:
            return "📃"
        case .rock:
            return "🗿"
        case .scissors:
            return "✂️"
        case .none:
            return ""
        }
    }
    
}
