local PhasingTracker = {}
local CollisionsModule = require(script.Parent.CollisionsModule)

local function getOrCreateFolder(character)
	local folder = character:FindFirstChild("PhasingRefs")
	if folder then return folder end

	folder = Instance.new("Folder")
	folder.Name = "PhasingRefs"
	folder.Parent = character

	folder.ChildAdded:Connect(function()
		if #folder:GetChildren() == 1 and character.Parent then
			pcall(function() CollisionsModule:SetCollisionGroup(character, "Phasing") end)
		end
	end)
	folder.ChildRemoved:Connect(function()
		if not character.Parent then return end
		if #folder:GetChildren() == 0 then
			pcall(function() CollisionsModule:SetCollisionGroup(character, "Players") end)
		else
			-- Defer so we run AFTER any bulk-reset code in the current call stack
			-- (e.g., cancelRagdoll setting all parts to "Players").
			task.defer(function()
				if folder.Parent and #folder:GetChildren() > 0 and character.Parent then
					pcall(function() CollisionsModule:SetCollisionGroup(character, "Phasing") end)
				end
			end)
		end
	end)
	return folder
end

function PhasingTracker.acquire(character, sourceName)
	if not character then return nil end
	local folder = getOrCreateFolder(character)
	local ref = Instance.new("ObjectValue")
	ref.Name = sourceName or "anonymous"
	ref.Parent = folder
	return ref
end

function PhasingTracker.release(ref)
	if ref and ref.Parent then
		ref:Destroy()
	end
end

function PhasingTracker.isPhasing(character)
	local folder = character and character:FindFirstChild("PhasingRefs")
	return folder ~= nil and #folder:GetChildren() > 0
end

return PhasingTracker