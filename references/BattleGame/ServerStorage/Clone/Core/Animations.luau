--Animations ModuleScipt in starterCharacterScripts

local module = {}

module.connections = {} --To disconnect the m1s. 
module.loadedAnimations = {}

--This code will always run when the Animations Module is called.

function module.loadAnims(animator: Animator, folder: Folder) 
	for _, anim in folder:GetDescendants() do --Gets descendants which are the swings folder and everything under. 
		if anim:IsA("Animation") then--checks to see if it is an actual animation
			local fullName = anim:GetFullName()
			fullName = fullName:split("ReplicatedStorage.Assets.Animations.")[2] --[2] makes it look nicer. Cause the animations in another folder called swings. And it prints swings as well. So this prevents it.
			local loaded = animator:LoadAnimation(anim) 
			loaded.Looped = false
			module.loadedAnimations[fullName] = loaded--Creates another dictionary where fullName is the key, and anim is the value.
		end
	end
end

return module
