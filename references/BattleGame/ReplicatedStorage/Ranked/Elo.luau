-- Standard Elo. 2v2 uses each team's average rating; both teammates get the same change.
local Elo = {}

-- Chance (0..1) that a player rated `rating` beats one rated `opponent`.
function Elo.Expected(rating: number, opponent: number): number
	return 1 / (1 + 10 ^ ((opponent - rating) / 400))
end

-- Rating change for one result. score: 1 = win, 0 = loss.
function Elo.Delta(rating: number, opponent: number, score: number, k: number): number
	return math.round(k * (score - Elo.Expected(rating, opponent)))
end

return Elo
