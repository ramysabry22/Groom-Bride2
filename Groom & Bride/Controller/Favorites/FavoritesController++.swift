

import UIKit
import Instructions

extension FavoritesController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        coachViews.bodyView.hintLabel.text = "Tap to remove from favorites"
        coachViews.bodyView.nextLabel.text = "OK"
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        
        return coachMarksController.helper.makeCoachMark(for: objCell.heartImageView)
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }
    
    func firstOpenDone() -> Bool {
        if UserDefaults.standard.bool(forKey: "isFirstInfoFavoriteOpenDonee"){
            return true
        }
        else {
            return false
        }
    }
    func finishCoachMark(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
           UserDefaults.standard.set(true, forKey: "isFirstInfoFavoriteOpenDonee")
           UserDefaults.standard.synchronize()
        }
    }
    
    
}

