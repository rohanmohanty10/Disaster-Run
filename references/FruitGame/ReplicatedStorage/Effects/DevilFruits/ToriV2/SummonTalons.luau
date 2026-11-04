 

game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
local function u8(p1, p2, p3, p4) --[[ Line: 8 ]]
    local v5 = p4 and 1 or 0
    for _, v7 in pairs(p2) do
        if p1 then
            local v7 = p1:FindFirstChild(v7)
        end
        if v7:IsA("BasePart") and not table.find(p3, v7.Name) then
            v7.Transparency = v5
        end
    end
end
return {
    ["start"] = function(_, p9, p10, p11) --[[ Name: start, Line 23 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if _G.checkRenderDistance(p9.PrimaryPart.Position) == false then
            return
        else
            Random.new()
            if p11 and game.Players.LocalPlayer == p11 then
                return
            else
                local v12 = p9:FindFirstChild("TalonRF")
                local v13 = p9:FindFirstChild("TalonLF")
                local v14 = v12.TalonR.Transparency + v13.TalonL.Transparency
                if p10 == "Both" then
                    if v14 == 0 then
                        for v15, v16 in { "Right", "Left" } do
                            local v17 = p9:FindFirstChild(v16 .. "Foot")
                            v17.Transparency = 0
                            local v18 = p9.CharacterEffects.Transformation:FindFirstChild(v16 .. "Summon")
                            v18.CFrame = v17.CFrame
                            Emit(v18.Attachment, true)
                            Ess.Destroy(v18, 0.5)
                            for _, v19 in p9:FindFirstChild(v15 == 1 and "TalonRF" or "TalonLF"):GetDescendants() do
                                if v19:IsA("BasePart") then
                                    v19.Transparency = 1
                                end
                            end
                        end
                    else
                        for v20, v21 in { "Right", "Left" } do
                            local v22 = p9:FindFirstChild(v21 .. "Foot")
                            v22.Transparency = 1
                            local v23 = script.Summon:Clone()
                            v23.CFrame = v22.CFrame
                            v23.Name = v21 .. "Summon"
                            v23.Parent = p9.CharacterEffects.Transformation
                            Emit(v23.Attachment, true)
                            for _, v24 in p9:FindFirstChild(v20 == 1 and "TalonRF" or "TalonLF"):GetDescendants() do
                                if v24:IsA("BasePart") then
                                    v24.Transparency = 0
                                end
                            end
                        end
                    end
                else
                    local v25 = p9:FindFirstChild(p10 .. "Foot")
                    if v25.Transparency == 0 then
                        v25.Transparency = 1
                        local v26 = script.Summon:Clone()
                        v26.CFrame = v25.CFrame
                        v26.Name = p10 .. "Summon"
                        v26.Parent = p9.CharacterEffects.Transformation
                        Emit(v26.Attachment, true)
                        u8(nil, v12:GetChildren(), {}, false)
                    else
                        v25.Transparency = 0
                        local v27 = p9.CharacterEffects.Transformation:FindFirstChild("RightSummon")
                        v27.CFrame = v25.CFrame
                        Emit(v27.Attachment, true)
                        Ess.Destroy(v27, 0.5)
                        u8(nil, v12:GetChildren(), {}, true)
                    end
                end
            end
        end
    end
}