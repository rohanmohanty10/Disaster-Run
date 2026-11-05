--!strict
-- Character animation ids. All R6 — set the game to R6 (Game Settings → Avatar → Avatar Type).
--
-- IMPORTANT: Roblox only plays an animation in a game owned by the same account or group that
-- uploaded it. These ids come from the reference games; if Disaster Run is published under a
-- different owner, re-upload the animations under that owner and swap the ids here.
--
-- Chosen set: the round-loop reference (ValleyRun) locomotion pack — it's a runner game with
-- a matching sprint speed (its run clip is tuned for 28 studs/s, ours sprints at 26).
-- Alternatives found in the references are listed under Alternatives.

local AnimationConfig = {}

AnimationConfig.Locomotion = {
	Idle = "rbxassetid://100864411216756", -- ValleyRun Idle (1.67s loop)
	Walk = "rbxassetid://96488535941159", -- ValleyRun Walk (normal speed)
	Run = "rbxassetid://128648389885279", -- ValleyRun Run (sprinting, 0.57s loop)
	Fall = "rbxassetid://98481609866072", -- ValleyRun Fall
	Land = "rbxassetid://91745397222432", -- ValleyRun Land
}

AnimationConfig.Actions = {
	Slide = "rbxassetid://18668814876", -- SoccerGame Movement.Slide (slide tackle)
	Dive = "rbxassetid://86862385170379", -- ValleyRun DiveForward
	DashForward = "rbxassetid://86862385170379", -- ValleyRun DiveForward
	DashLeft = "rbxassetid://119684194794142", -- ValleyRun DashLeft
	DashRight = "rbxassetid://118340857540547", -- ValleyRun DashRight
	DashBack = "rbxassetid://120746730484733", -- ValleyRun DashBack
	StandUp = "rbxassetid://18678636598", -- SoccerGame Movement.StandUp
}

-- How fast the clips were animated for; playback speed scales with the character's speed.
AnimationConfig.WalkReferenceSpeed = 10
AnimationConfig.RunReferenceSpeed = 28

-- Other run animations in the references, if you want to try a different feel.
AnimationConfig.Alternatives = {
	SoccerRun = "rbxassetid://72668568236405", -- SoccerGame Movement.CustomR (athletic sprint)
	SoccerWalk = "rbxassetid://18668804075", -- SoccerGame Movement.CustomW
	SoccerIdle = "rbxassetid://18708846381",
	BasketballRun = "rbxassetid://90744009309769", -- BasketballGame Movement.RunF (+ 8-way strafe set)
	BasketballWalk = "rbxassetid://119260199499679",
	BasketballIdle = "rbxassetid://134894961343601",
}

return AnimationConfig
