
import UIKit
import SVProgressHUD
import Cosmos
import Instructions


extension DetailedHallController {
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        coachViews.bodyView.hintLabel.text = coachMarksTitles[index]
        coachViews.bodyView.nextLabel.text = "OK"
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        if index == 0 {
            return coachMarksController.helper.makeCoachMark(for: favoriteBackgroundView)
        }
        else if index == 1 {
            return coachMarksController.helper.makeCoachMark(for: newRateView)
        }
        else if index == 2 {
            return coachMarksController.helper.makeCoachMark(for: locationView)
        }
        else {
            return coachMarksController.helper.makeCoachMark(for: callView)
        }
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return coachMarksTitles.count
    }
    
    
    func firstOpenDone() -> Bool {
        if UserDefaults.standard.bool(forKey: "isFirstInfoOpenDonee"){
            return true
        }
        else {
            return false
        }
    }
    func finishCoachMark(){
        UserDefaults.standard.set(true, forKey: "isFirstInfoOpenDonee")
        UserDefaults.standard.synchronize()
        self.coachMarksController.stop(immediately: true)
    }
}
