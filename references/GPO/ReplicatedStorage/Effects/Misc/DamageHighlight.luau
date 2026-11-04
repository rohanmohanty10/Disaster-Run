 

local v1 = {}
local u2 = {}
require(game.ReplicatedStorage.Modules.Trove)
game:GetService("ReplicatedStorage")
function v1.start(_, u3, p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u3 == nil then
        return
    elseif u3 and u3.Parent == nil then
        return
    elseif u3.PrimaryPart == nil then
        return
    elseif _G.checkRenderDistance(u3.PrimaryPart.Position, 100) == false then
        return
    else
        local _, v5 = workspace.CurrentCamera:WorldToScreenPoint(u3.PrimaryPart.Position)
        if v5 == false then
            return
        else
            local v6 = u3:FindFirstChildWhichIsA("Highlight")
            if not v6 or v6.Name == "damageHighlight" then
                local u7
                if u2[u3] then
                    u7 = u2[u3].Highlight
                else
                    u7 = Instance.new("Highlight")
                    u7.OutlineTransparency = 1
                    u7.DepthMode = Enum.HighlightDepthMode.Occluded
                    u7.FillTransparency = 0.5
                end
                u7.Name = "damageHighlight"
                u7.Adornee = u3
                if p4 == true then
                    u7.FillColor = Color3.fromRGB(255, 255, 255)
                end
                pcall(function() --[[ Line: 57 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                    --]]
                    u7.Parent = script
                end)
                local v8 = u2[u3]
                local v9 = v8 and v8.Tween
                if v9 then
                    v9:Pause()
                    v9:Destroy()
                    v8.cnt:Disconnect()
                end
                u7.FillTransparency = 0.5
                local u10 = game:GetService("TweenService"):Create(u7, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["FillTransparency"] = 1
                })
                u10:Play()
                local function u11() --[[ Line: 84 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u3
                        [3] = u10
                        [4] = u7
                    --]]
                    if u2[u3] then
                        u2[u3].Tween:Destroy()
                        u2[u3].Highlight:Destroy()
                        u2[u3].cnt:Disconnect()
                        u2[u3] = nil
                    end
                    u10:Destroy()
                    u7:Destroy()
                end
                u2[u3] = {
                    ["Tween"] = u10,
                    ["Highlight"] = u7,
                    ["cnt"] = u10.Completed:Connect(function() --[[ Line: 95 ]]
                        --[[
                        Upvalues:
                            [1] = u11
                        --]]
                        u11()
                    end)
                }
                task.delay(0.75, function() --[[ Line: 101 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u3
                        [3] = u10
                        [4] = u11
                    --]]
                    if u2[u3] and u2[u3].Tween == u10 then
                        u11()
                    end
                end)
            end
        end
    end
end
return v1