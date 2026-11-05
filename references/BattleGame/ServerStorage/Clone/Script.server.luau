--Script for reblocking dummy.
local character = script.Parent
local animator = script.Parent.Humanoid.Animator
local animationsModule = require(game.ReplicatedStorage.Modules.Animations)

animationsModule.Load(character, animator, game.ReplicatedStorage.Assets.Animations)



