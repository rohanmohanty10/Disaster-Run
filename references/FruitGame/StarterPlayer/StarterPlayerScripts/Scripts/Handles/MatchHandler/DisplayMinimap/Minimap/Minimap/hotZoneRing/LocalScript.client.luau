 

while true do
    task.wait()
    local v1 = _G.stormPart.Mesh.Scale.X
    local v2 = v1 / 5.25
    if game.ReplicatedStorage:FindFirstChild("resizeNum") then
        v2 = v1 / game.ReplicatedStorage.resizeNum.Value
    end
    local v3 = math.clamp(v2, 12, 100000000000)
    script.Parent.Size = UDim2.new(0, v3, 0, v3)
end