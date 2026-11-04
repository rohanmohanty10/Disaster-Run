 

function PlayFlipbook(p1, p2, p3, p4, p5)
    for v6 = p4, p5 do
        local v7
        if p2:FindFirstChild((tostring(v6))) then
            v7 = v6
        else
            v7 = v6 + 1
        end
        p1.Texture = p2[tostring(v7)].Texture
        task.wait(p3)
    end
end
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
Apply = require(script.Parent.ApplyRig)
return {
    ["start"] = function(_, u8, p9) --[[ Name: start, Line 78 ]]
        Random.new()
        local v10 = u8.Humanoid.RootPart
        local u11 = script.Transform:Clone()
        u11.CFrame = v10.CFrame * CFrame.new(0, 0.15, 0)
        u11.Parent = workspace.Effects
        if p9 == false then
            task.delay(0.1, function() --[[ Line: 90 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                for _, v12 in u8:GetDescendants() do
                    if v12:IsA("Beam") then
                        v12.Enabled = false
                    elseif v12.Name == "Shine" then
                        v12.Transparency = 1
                    end
                end
            end)
            Emit(u8.SmokeHolder, false)
            Emit(u11.Off, false, 0.1)
            Emit(u11, false, 0.3)
            _G.destroy(u11, 2)
        else
            task.delay(0.92, function() --[[ Line: 113 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u8
                --]]
                Emit(u11.First, false, 0.2)
                Emit(u11.Second, false, 0.05)
                task.wait(0.1)
                for _, v13 in u8:GetDescendants() do
                    if v13:IsA("Beam") then
                        v13.Enabled = true
                    elseif v13.Name == "Shine" then
                        v13.Transparency = 0
                    end
                end
                pcall(function() --[[ Line: 126 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u11
                    --]]
                    Emit(u8.SmokeHolder, false)
                    Emit(u11.Attachment, false, 0.2)
                    Emit(u11, false, 0.4)
                end)
                _G.destroy(u11, 2)
            end)
        end
    end
}