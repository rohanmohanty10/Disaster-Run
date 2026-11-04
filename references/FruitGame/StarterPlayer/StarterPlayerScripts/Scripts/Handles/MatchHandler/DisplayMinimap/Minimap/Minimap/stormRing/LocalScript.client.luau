 

local v1 = _G.stormResolution[1] / 11001
while true do
    local v2 = _G.stormPart.Mesh.Scale.X
    local v3 = v2 / (5.25 * v1)
    if game.ReplicatedStorage:FindFirstChild("resizeNum") then
        v3 = v2 / game.ReplicatedStorage.resizeNum.Value
    end
    local v4 = math.clamp(v3, 12, 100000000000)
    script.Parent.Size = UDim2.new(0, v4, 0, v4)
    task.wait()
end