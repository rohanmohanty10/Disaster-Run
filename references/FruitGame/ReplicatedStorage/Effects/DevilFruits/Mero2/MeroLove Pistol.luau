 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
local _ = v1.LocalPlayer
local u3 = workspace.Effects
local u4 = {}
function Flipbook(p5, u6, u7, u8)
    local u9 = p5:FindFirstChildOfClass("SpecialMesh")
    if u9 and u6 then
        task.spawn(function() --[[ Line: 20 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u9
                [3] = u7
                [4] = u8
            --]]
            for v10 = 1, #u6 do
                u9.TextureId = u6[v10]
                task.wait(1 / u7)
            end
            if u8 == true then
                u9.Parent:Destroy()
            end
        end)
    end
end
local v11 = RaycastParams.new()
v11.FilterType = Enum.RaycastFilterType.Include
v11.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p12, p13, p14, u15, p16) --[[ Name: start, Line 78 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        if _G.checkRenderDistance(p13.PrimaryPart.Position) == false then
            return
        elseif p12 == "Hold" then
            u4[p13] = {}
            local v17 = CFrame.new(0, -0.1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
            local v18 = script.Heart:Clone()
            v18.CFrame = p13.RightHand.CFrame * v17
            v18.Parent = u3
            _G.customEmit(v18)
            _G.customWeld(v18, p13.RightHand, v17, v18)
            _G.PlaySound(v18, script.Mero2PistolKissStart)
            local v19 = u4[p13]
            table.insert(v19, v18)
        elseif p12 == "Shoot" then
            local v20 = (p14.Position - u15.Position).Magnitude
            local v21 = u4[p13]
            local v22 = table.unpack(v21)
            local v23 = v22:Clone()
            v22:Destroy()
            local u24 = v23
            u24.CFrame = p14
            u24.Parent = workspace.Effects
            _G.PlaySound(u24, script.Mero2PistolKissShoot)
            local v25 = script.Shoot:Clone()
            v25.CFrame = CFrame.new(p14.Position, u15.Position)
            v25.Parent = u3
            _G.customEmit(v25)
            _G.destroy(v25, 3)
            u2:Create(u24, TweenInfo.new(p16, Enum.EasingStyle.Linear), {
                ["CFrame"] = CFrame.new(p14.Position, u15.Position) * CFrame.new(0, 0, -v20)
            }):Play()
            task.delay(p16, function() --[[ Line: 119 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u3
                    [3] = u24
                --]]
                local v26 = script.HitEffect:Clone()
                v26.CFrame = u15
                v26.Parent = u3
                _G.customEmit(v26)
                _G.destroy(v26, 2)
                _G.PlaySound(v26, script.groundHit)
                u24:Destroy()
            end)
        end
    end
}