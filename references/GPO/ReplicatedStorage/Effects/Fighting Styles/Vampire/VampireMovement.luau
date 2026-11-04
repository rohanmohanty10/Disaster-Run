 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local u2 = game:GetService("Players")
require(v1.Modules.CraterHandler)
require(v1.Modules.Bezier)
local u3 = require(v1.Modules.Client.WeaponVFXRecolor)
local u4 = workspace.Effects
Random.new()
local u5 = {}
function Flipbook(p6, u7, u8, u9)
    local u10 = p6:FindFirstChildOfClass("SpecialMesh")
    if u10 and u7 then
        task.spawn(function() --[[ Line: 56 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u10
                [3] = u8
                [4] = u9
            --]]
            for v11 = 1, #u7 do
                u10.TextureId = u7[v11]
                task.wait(1 / u8)
            end
            if u9 == true then
                u10.Parent:Destroy()
            end
        end)
    end
end
local function u22(p12, p13, p14) --[[ Line: 68 ]]
    local function v20(u15, p16, p17) --[[ Line: 69 ]]
        for _, v18 in ipairs(u15:GetDescendants()) do
            if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                v18.Enabled = p16
            end
        end
        if p17 then
            task.delay(p17, function() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for _, v19 in ipairs(u15:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                        v19.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p12) == "table" then
        for _, v21 in p12 do
            v20(v21, p13, p14)
        end
    else
        v20(p12, p13, p14)
    end
end
local v23 = RaycastParams.new()
v23.FilterDescendantsInstances = { workspace.Env, workspace.Islands }
v23.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p24, u25, u26, _) --[[ Name: start, Line 110 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
            [3] = u3
            [4] = u4
            [5] = u22
        --]]
        if _G.checkRenderDistance(u25.PrimaryPart.Position) == false then
            return
        else
            local u27 = u2:GetPlayerFromCharacter(u25):GetMouse()
            if p24 == "Hold" then
                u5[u25] = {}
                u5[u25].Active = true
                local u28 = RaycastParams.new()
                u28.FilterType = Enum.RaycastFilterType.Include
                u28.FilterDescendantsInstances = { workspace.Env, workspace.Islands }
                local v29 = script.Cast:Clone()
                u3.apply(v29, u25)
                v29.CFrame = u26.CFrame
                v29.Parent = u4
                _G.customEmit(v29)
                _G.destroy(v29, 3)
                local u30 = script.DashEmit:Clone()
                u3.apply(u30, u25)
                u30.CFrame = u25.UpperTorso.CFrame
                u30.Parent = u4
                local v31 = u5[u25]
                table.insert(v31, u30)
                local v32 = u26.CFrame
                local v33 = Instance.new("WeldConstraint")
                v33.Part0 = u30
                v33.Part1 = u26
                v33.Part1.CFrame = v32
                v33.Parent = u30
                local v34 = script.Dash:Clone()
                u3.apply(v34, u25)
                v34.CFrame = u26.CFrame
                v34.Parent = u4
                u22(v34, true)
                local v35 = u26.CFrame
                local v36 = Instance.new("WeldConstraint")
                v36.Part0 = v34
                v36.Part1 = u26
                v36.Part1.CFrame = v35
                v36.Parent = v34
                local v37 = u5[u25]
                table.insert(v37, v34)
                u25.Archivable = true
                task.spawn(function() --[[ Line: 152 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u25
                        [3] = u30
                        [4] = u26
                        [5] = u27
                        [6] = u28
                    --]]
                    while u5[u25].Active do
                        _G.customEmit(u30)
                        task.delay(0.5, function() --[[ Line: 157 ]]
                            --[[
                            Upvalues:
                                [1] = u30
                            --]]
                            _G.customEmit(u30)
                        end)
                        local v38 = u26.CFrame
                        local v39 = u27.Hit
                        local v40 = (v39.Position - v38.Position).Unit * 60
                        local v41 = workspace:Raycast(v38.Position, v40, u28)
                        local v42
                        if v41 then
                            local v43 = (v38.Position - v41.Position).Magnitude
                            if v43 > 10 then
                                v42 = CFrame.lookAt(v38.Position, v41.Position) * CFrame.new(0, 0, -v43)
                                local _ = (v38.Position - v41.Position).Magnitude
                            else
                                v42 = u26.CFrame
                                local _ = (v38.Position - v41.Position).Magnitude
                            end
                        else
                            v42 = CFrame.lookAt(v38.Position, v39.Position) * CFrame.new(0, 0, -60)
                            local _ = (v38.Position - v42.Position).Magnitude
                        end
                        _G.tween(u26, {
                            0.3,
                            "Quint",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["CFrame"] = v42
                        })
                        for _, u44 in u25:GetDescendants() do
                            if (u44:IsA("BasePart") or (u44:IsA("MeshPart") or u44:IsA("Accessory"))) and u44.Name ~= "HumanoidRootPart" then
                                local _ = u44.Transparency
                                u44.Transparency = 1
                                task.delay(0.2, function() --[[ Line: 221 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u44
                                    --]]
                                    _G.tween(u44, {
                                        0.3,
                                        "Linear",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Transparency"] = 0
                                    })
                                end)
                            end
                        end
                        task.wait(0.6)
                    end
                end)
            elseif p24 == "End" then
                local v45 = u5[u25]
                local v46, v47 = table.unpack(v45)
                u5[u25].Active = false
                u22(v47, false)
                u22(v46, false)
                _G.destroy(v46, 2)
                _G.destroy(v47, 2)
                task.delay(1, function() --[[ Line: 241 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u25
                    --]]
                    for v48, _ in u5[u25] do
                        u5[u25][v48] = nil
                    end
                    u5[u25] = nil
                end)
            end
        end
    end
}