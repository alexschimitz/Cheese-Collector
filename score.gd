extends Node

const MAX_SCORES = 5
var high_scores: Array = [] 

func add_new_score(time_taken: float) -> bool:
	high_scores.append(time_taken)
	
	high_scores.sort() 
	
	var is_new_highscore = false
		
	if high_scores.size() <= MAX_SCORES:
		is_new_highscore = true
		
	elif high_scores.size() > MAX_SCORES:
		var worst_score_before_cut = high_scores.back()
		
		high_scores.resize(MAX_SCORES)
		
		if time_taken < worst_score_before_cut:
			is_new_highscore = true
		
	return is_new_highscore

func get_top_scores() -> Array:
	return high_scores
