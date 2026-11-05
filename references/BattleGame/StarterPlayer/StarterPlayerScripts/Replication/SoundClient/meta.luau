local meta = {}

function meta:GetSoundsForMaterial(material, type)
	local s,_ = string.gsub(tostring(material), "Enum.Material.", "")
	return game.ReplicatedStorage.Assets.Sounds.WalkSounds:FindFirstChild(s)
end

return meta