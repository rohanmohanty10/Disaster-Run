 

local _, _, _, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
game:GetService("StarterPlayer")
game:GetService("ReplicatedStorage")
game:GetService("MarketplaceService")
local _ = UserSettings().GameSettings.Parent
local v3 = v1.LocalPlayer
local v4 = script.Parent
local v5 = assert(v4, "Animate script has no parent!")
if not v5:IsA("Model") then
    v5 = nil
end
local u6 = assert(v5, "Parent of Animate must be a Model!")
local v7 = u6:FindFirstChildOfClass("Humanoid")
local u8 = assert(v7, "No Humanoid object found for the Animate script to use!")
local u9 = u8:FindFirstChildOfClass("Animator")
local u10 = u6:WaitForChild("HumanoidRootPart", 100000000000)
local u11 = nil
local u12 = u10.Position.Y
if not u9 then
    if v2:IsServer() then
        u9 = Instance.new("Animator", u8)
    else
        u9 = u8:WaitForChild("Animator")
    end
end
local u13 = {
    ["Animations"] = {},
    ["Defaults"] = {},
    ["Emotes"] = {},
    ["Callbacks"] = {},
    ["DidLoop"] = {},
    ["Dirty"] = {},
    ["Emotes"] = {
        ["wave"] = false,
        ["point"] = false,
        ["dance"] = true,
        ["dance2"] = true,
        ["dance3"] = true,
        ["laugh"] = false,
        ["cheer"] = false
    },
    ["Defaults"] = {
        ["idle"] = {
            {
                ["Id"] = "rbxassetid://7075728341",
                ["Weight"] = 1
            }
        },
        ["walk"] = {
            {
                ["Id"] = "rbxassetid://13630769186",
                ["Weight"] = 10
            }
        },
        ["run"] = {
            {
                ["Id"] = "rbxassetid://17650838050",
                ["Weight"] = 10
            }
        },
        ["swim"] = {
            {
                ["Id"] = "rbxassetid://507784897",
                ["Weight"] = 10
            }
        },
        ["swimidle"] = {
            {
                ["Id"] = "rbxassetid://507785072",
                ["Weight"] = 10
            }
        },
        ["jump"] = {
            {
                ["Id"] = "rbxassetid://10001707271",
                ["Weight"] = 10
            }
        },
        ["fall"] = {
            {
                ["Id"] = "rbxassetid://10001705684",
                ["Weight"] = 10
            }
        },
        ["climb"] = {
            {
                ["Id"] = "rbxassetid://507765644",
                ["Weight"] = 10
            }
        },
        ["sit"] = {
            {
                ["Id"] = "rbxassetid://2506281703",
                ["Weight"] = 10
            }
        },
        ["toolnone"] = {
            {
                ["Id"] = "rbxassetid://507768375",
                ["Weight"] = 10
            }
        },
        ["toolslash"] = {
            {
                ["Id"] = "rbxassetid://522635514",
                ["Weight"] = 10
            }
        },
        ["toollunge"] = {
            {
                ["Id"] = "rbxassetid://522638767",
                ["Weight"] = 10
            }
        },
        ["wave"] = {
            {
                ["Id"] = "rbxassetid://507770239",
                ["Weight"] = 10
            }
        },
        ["point"] = {
            {
                ["Id"] = "rbxassetid://507770453",
                ["Weight"] = 10
            }
        },
        ["dance"] = {
            {
                ["Id"] = "rbxassetid://507771019",
                ["Weight"] = 10
            },
            {
                ["Id"] = "rbxassetid://507771955",
                ["Weight"] = 10
            },
            {
                ["Id"] = "rbxassetid://507772104",
                ["Weight"] = 10
            }
        },
        ["dance2"] = {
            {
                ["Id"] = "rbxassetid://507776043",
                ["Weight"] = 10
            },
            {
                ["Id"] = "rbxassetid://507776720",
                ["Weight"] = 10
            },
            {
                ["Id"] = "rbxassetid://507776879",
                ["Weight"] = 10
            }
        },
        ["dance3"] = {
            {
                ["Id"] = "rbxassetid://507777268",
                ["Weight"] = 10
            },
            {
                ["Id"] = "rbxassetid://507777451",
                ["Weight"] = 10
            },
            {
                ["Id"] = "rbxassetid://507777623",
                ["Weight"] = 10
            }
        },
        ["laugh"] = {
            {
                ["Id"] = "rbxassetid://507770818",
                ["Weight"] = 10
            }
        },
        ["cheer"] = {
            {
                ["Id"] = "rbxassetid://507770677",
                ["Weight"] = 10
            }
        }
    }
}
local function u20(p14) --[[ Line: 321 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u9
        [3] = u13
    --]]
    if not p14.Track then
        local v15 = p14.Animation
        if v15 == nil then
            v15 = Instance.new("Animation")
            assert(v15)
            local v16 = p14.Id
            v15.AnimationId = assert(v16)
            p14.Animation = v15
        end
        local v17
        if script:GetAttribute("DebugHumanoidLoadAnimation") then
            v17 = u8
        else
            v17 = u9
        end
        local u18 = v17:LoadAnimation(assert(v15))
        u18.Priority = Enum.AnimationPriority.Core
        u18.DidLoop:Connect(function() --[[ Line: 344 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u18
            --]]
            u13.DidLoop[u18] = true
        end)
        p14.Track = u18
    end
    local v19 = p14.Track
    return assert(v19)
end
local function u25(p21) --[[ Line: 354 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    local v22 = p21.Parent
    if not (v22 and v22:IsA("StringValue")) then
        return nil
    end
    if v22.Parent == script then
        local v23 = v22.Name
        local v24 = u13.Animations[v23]
        if not v24 then
            v24 = {
                ["DefaultSet"] = {
                    ["TotalWeight"] = 0
                },
                ["CustomSet"] = {
                    ["TotalWeight"] = 0
                }
            }
            u13.Animations[v23] = v24
        end
        return v24.CustomSet
    end
end
local function v32(p26) --[[ Line: 431 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u20
    --]]
    local v27 = p26:IsA("Animation") and u25(p26)
    if v27 then
        local v28 = p26:FindFirstChild("Weight")
        local v29
        if v28 and v28:IsA("NumberValue") then
            v29 = v28.Value
        else
            v29 = p26:GetAttribute("Weight")
            if typeof(v29) ~= "number" then
                v29 = nil
            end
        end
        local v30 = v29 or 1
        v27.TotalWeight = v27.TotalWeight + v30
        local v31 = {
            ["Id"] = p26.AnimationId,
            ["Animation"] = p26,
            ["Weight"] = v30
        }
        u20(v31)
        table.insert(v27, v31)
    end
end
local function v38(p33) --[[ Line: 451 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    local v34 = p33:IsA("Animation") and u25(p33)
    if v34 then
        local v35 = nil
        for v36, v37 in ipairs(v34) do
            if v37.Animation == p33 then
                v34.TotalWeight = v34.TotalWeight - v37.Weight
                v35 = v36
                break
            end
        end
        if v35 then
            table.remove(v34, v35)
        end
    end
end
local function u40(p39) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u8
        [3] = u10
    --]]
    if u6.PrimaryPart.Anchored ~= true then
        if p39:match("step") and (u8.WalkSpeed < 25 and (u10.Anchored == false and (u10.AssemblyLinearVelocity.Magnitude >= 3 and (u10:FindFirstChildWhichIsA("BodyVelocity") == nil and _G.footstep)))) then
            _G.footstep(p39)
        end
    end
end
local function u51(p41) --[[ Line: 380 ]]
    --[[
    Upvalues:
        [1] = u20
    --]]
    local v42
    if #p41.CustomSet == 0 then
        v42 = p41.DefaultSet
    else
        v42 = p41.CustomSet
    end
    if #v42 == 1 then
        return u20(v42[1]), false
    end
    if #v42 == 0 then
        return nil, nil
    end
    local v43 = v42.TotalWeight
    local v44 = assert(v43)
    local v45 = math.random() * v44
    local v46 = 0
    local v47 = 1
    while v46 < v44 do
        local v48 = v42[v47]
        local v49 = assert(v48)
        local v50 = v46 + v49.Weight
        if v46 <= v45 and v45 < v50 then
            return u20(v49), true
        end
        v47 = v47 + 1
        v46 = v50
    end
    return nil, nil
end
for v52, v53 in u13.Defaults do
    local v54 = {
        ["TotalWeight"] = 0
    }
    for _, v55 in v53 do
        v54.TotalWeight = v54.TotalWeight + v55.Weight
        table.insert(v54, v55)
        u20(v55)
    end
    u13.Animations[v52] = {
        ["DefaultSet"] = v54,
        ["CustomSet"] = {
            ["TotalWeight"] = 0
        }
    }
end
for _, v56 in script:GetDescendants() do
    v32(v56)
end
script.DescendantAdded:Connect(v32)
script.DescendantRemoving:Connect(v38)
local u57 = nil
local u58 = nil
local u59 = 0
local u60 = 0
local function v61() --[[ Line: 510 ]]
    --[[
    Upvalues:
        [1] = u59
    --]]
    u59 = tick() + 0.4
end
local function v67() --[[ Line: 514 ]]
    --[[
    Upvalues:
        [1] = u59
        [2] = u13
    --]]
    local v62
    if tick() < u59 then
        local v63 = u13.Animations.jump
        local v64 = "Unknown animation name: " .. tostring("jump")
        v62 = assert(v63, v64)
    else
        local v65 = u13.Animations.fall
        local v66 = "Unknown animation name: " .. tostring("fall")
        v62 = assert(v65, v66)
    end
    v62.Weight = 1
    v62.FadeTime = 0.1
end
local function v71() --[[ Line: 525 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    local v68 = u13.Animations.sit
    local v69 = "Unknown animation name: " .. tostring("sit")
    local v70 = assert(v68, v69)
    v70.FadeTime = 0.4
    v70.Weight = 1
    v70.Speed = 0
end
local function v77() --[[ Line: 532 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u13
    --]]
    local v72 = u8.RootPart
    local v73 = not v72 and 0 or v72.AssemblyLinearVelocity.Y / 5
    local v74 = u13.Animations.climb
    local v75 = "Unknown animation name: " .. tostring("climb")
    local v76 = assert(v74, v75)
    v76.Speed = v73
    v76.Weight = 1
end
local function v86() --[[ Line: 546 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u13
    --]]
    local v78 = u8.RootPart
    local v79 = not v78 and 0 or v78.AssemblyLinearVelocity.Magnitude
    local v80 = u13.Animations.swim
    local v81 = "Unknown animation name: " .. tostring("swim")
    local v82 = assert(v80, v81)
    v82.FadeTime = 0.4
    local v83 = u13.Animations.swimidle
    local v84 = "Unknown animation name: " .. tostring("swimidle")
    local v85 = assert(v83, v84)
    v85.FadeTime = 0.4
    if v79 > 1 then
        v82.Speed = v79 / 10
        v82.Weight = 1
    else
        v85.Weight = 1
    end
end
local function v113() --[[ Line: 569 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u13
        [3] = u11
        [4] = u40
    --]]
    local v87 = u8.RootPart
    local v88
    if v87 then
        local v89 = v87.Size.Y / 2
        local v90 = Vector3.new(0, 1, 0) * (u8.HipHeight + v89)
        local _ = v87.Position - v90
        local v91 = v87.AssemblyLinearVelocity
        local v92 = v87.CFrame
        local v93 = v92.RightVector:Dot(v91)
        local v94 = v92.LookVector:Dot(v91)
        v88 = Vector2.new(v93, v94).Magnitude
    else
        local _ = Vector2.zero
        v88 = 0
    end
    local v95
    if u8.AutomaticScalingEnabled then
        local v96 = script
        local v97 = v96:FindFirstChild("ScaleDampeningPercent")
        local v98
        if v97 and v97:IsA("NumberValue") then
            v98 = v97.Value
        else
            v98 = v96:GetAttribute("ScaleDampeningPercent")
            if typeof(v98) ~= "number" then
                v98 = nil
            end
        end
        if v98 then
            v95 = 1 + (u8.HipHeight - 2) * v98 / 2
        else
            v95 = u8.HipHeight / 2
        end
    else
        v95 = 1
    end
    if v95 / 2 < v88 then
        local v99 = v88 / 12.8 / v95
        local v100 = (v99 - 0.5) / 0.5
        local v101 = u13.Animations.run
        local v102 = "Unknown animation name: " .. tostring("run")
        local v103 = assert(v101, v102)
        local v104 = v100 + 1
        local v105 = math.log(v104)
        v103.Speed = math.max(1, v105)
        v103.Weight = math.clamp(v100, 0.0001, 1)
        local v106
        if v103.Weight == 0.0001 then
            v106 = v99 / 0.5
        else
            v106 = 1 - v100
        end
        local v107 = u13.Animations.walk
        local v108 = "Unknown animation name: " .. tostring("walk")
        local v109 = assert(v107, v108)
        v109.Weight = math.clamp(v106, 0.0001, 1)
        if v109.ActiveTrack then
            local v110 = v109.ActiveTrack
            if u11 ~= nil then
                u11:Disconnect()
                u11 = nil
            end
            u11 = v110.KeyframeReached:Connect(u40)
            return
        end
    else
        local v111 = u13.Animations.idle
        local v112 = "Unknown animation name: " .. tostring("idle")
        assert(v111, v112).Weight = 1
    end
end
local function u119(p114) --[[ Line: 677 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u8
        [3] = u58
    --]]
    local v115 = nil
    if p114:sub(1, 3) == "/e " then
        v115 = p114:sub(4)
    elseif p114:sub(1, 7) == "/emote " then
        v115 = p114:sub(8)
    end
    if u13.Emotes[v115] ~= nil then
        local v116 = u8.MoveDirection
        local v117 = u8:GetState()
        local v118
        if v116 == Vector3.new(0, 0, 0) then
            v118 = v117 == Enum.HumanoidStateType.Running
        else
            v118 = false
        end
        if v118 then
            u58 = v115
        end
    end
end
u8.Jumping:Connect(v61)
if v3 then
    game.TextChatService.emote.Triggered:Connect(function(_, p120) --[[ Line: 695 ]]
        --[[
        Upvalues:
            [1] = u119
        --]]
        Instance.new("TextChatMessageProperties")
        u119(p120)
    end)
end
local v121 = Enum.HumanoidStateType.Seated
u13.Callbacks[v121] = v71
local v122 = Enum.HumanoidStateType.Running
u13.Callbacks[v122] = v113
local v123 = Enum.HumanoidStateType.Climbing
u13.Callbacks[v123] = v77
local v124 = Enum.HumanoidStateType.Freefall
u13.Callbacks[v124] = v67
local v125 = Enum.HumanoidStateType.Swimming
u13.Callbacks[v125] = v86
assert(u9)
local function u133(p126) --[[ Line: 732 ]]
    --[[
    Upvalues:
        [1] = u57
        [2] = u60
        [3] = u8
        [4] = u13
    --]]
    local v127 = tick()
    local v128 = "toolnone"
    local v129 = p126:FindFirstChild("toolanim")
    if v129 and v129:IsA("StringValue") then
        u57 = v129.Value
        u60 = v127 + 0.3
        v129.Parent = nil
    end
    if v127 < u60 then
        v128 = u57 == "Slash" and "toolslash" or (u57 == "Lunge" and not u8.Sit and "toollunge" or v128)
    elseif u57 then
        u57 = nil
    end
    local v130 = u13.Animations[v128]
    local v131 = "Unknown animation name: " .. tostring(v128)
    local v132 = assert(v130, v131)
    v132.Priority = Enum.AnimationPriority.Action
    v132.FadeTime = 0.1
    v132.Weight = 1
end
local function v154() --[[ Line: 759 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u133
        [3] = u58
        [4] = u8
        [5] = u13
        [6] = u51
        [7] = u12
        [8] = u10
    --]]
    local v134 = u6:FindFirstChildWhichIsA("Tool")
    if v134 and v134.RequiresHandle then
        u133(v134)
    end
    if u58 then
        local v135 = u8.MoveDirection
        local v136 = u8:GetState()
        local v137
        if v135 == Vector3.new(0, 0, 0) then
            v137 = v136 == Enum.HumanoidStateType.Running
        else
            v137 = false
        end
        if not v137 then
            goto l5
        end
        local v138 = u58
        local v139 = u13.Animations[v138]
        local v140 = "Unknown animation name: " .. tostring(v138)
        assert(v139, v140).Weight = 1
    else
        ::l5::
        local v141 = u8:GetState()
        local v142 = u13.Callbacks[v141]
        if v142 then
            v142()
        end
        u58 = nil
    end
    for _, v143 in u13.Animations do
        local v144 = v143.Speed
        local v145 = v143.Weight
        local v146 = v143.FadeTime
        local v147 = v143.ActiveTrack
        if not (v144 or v145) then
            if v147 and v147.IsPlaying then
                v147:Stop(v146 or 0.2)
            end
            goto l49
        end
        local v148
        if v147 then
            v148 = v147.IsPlaying
        else
            v148 = false
        end
        local v149
        if v148 and (v147 and u13.DidLoop[v147]) then
            local v150
            v149, v150 = u51(v143)
            if v150 then
                v148 = false
            end
            u13.DidLoop[v147] = nil
        else
            v149 = nil
        end
        if not v148 then
            if v147 and v147 ~= v149 then
                v147:Stop(v146 or 0.2)
            end
            v147 = v149 or u51(v143)
            v143.ActiveTrack = v147
        end
        if v147 then
            assert(v147)
            if v147.IsPlaying then
                local v151 = v143.Priority
                if v144 then
                    v143.Speed = nil
                    local v152 = v144 - v147.Speed
                    if math.abs(v152) > 0.01 then
                        v147:AdjustSpeed(v144)
                    end
                end
                if v145 then
                    v143.Weight = nil
                    if v145 == 0.0001 and v147.WeightTarget ~= 0.0001 then
                        v147:AdjustWeight(0.0001)
                    else
                        local v153 = v145 - v147.WeightTarget
                        if math.abs(v153) > 0.01 then
                            v147:AdjustWeight(v145)
                        end
                    end
                end
                if v151 then
                    v147.Priority = v151
                    v143.Priority = nil
                end
            else
                v147.TimePosition = 0
                v147:Play(v146 or 0.2, v145 or 1, v144 or 1)
            end
            ::l49::
            if v146 then
                v143.FadeTime = nil
            end
        end
    end
    if u8.FloorMaterial == Enum.Material.Air and u12 < u10.Position.Y then
        u12 = u10.Position.Y
    end
end
v2.Heartbeat:Connect(v154)
local u155 = u8:LoadAnimation(script.LandAnim)
u155.Priority = Enum.AnimationPriority.Action
local u156 = 0
u8.StateChanged:Connect(function(p157) --[[ Line: 873 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u8
        [3] = u12
        [4] = u10
        [5] = u156
        [6] = u155
    --]]
    if p157 == Enum.HumanoidStateType.Landed then
        local v158 = tick()
        while true do
            local v159, _, _ = _G.getRayFloor(u6.PrimaryPart.CFrame, u8.HipHeight + u6.PrimaryPart.Size.Y / 2 + 0.2)
            if v159 then
                break
            end
            task.wait()
            if v159 ~= nil or tick() - v158 >= 0.1 then
                break
            end
        end
        if u12 - u10.Position.Y >= 10 and (tick() - u156 >= 0.05 and _G.canuse == true) then
            u156 = tick()
            _G.footstep("land")
            u155:Play()
        end
        u12 = u10.Position.Y
    end
end)