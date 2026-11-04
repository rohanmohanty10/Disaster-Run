 

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("ContentProvider")
local v4 = v1.LocalPlayer.PlayerGui
local u5 = script.Flipbooks
local u6 = script.SFX
local u7 = nil
local u8 = nil
local u9 = nil
local u10 = nil
script.WholeCakeDialogue:Clone().Parent = v4
local u11 = v4:WaitForChild("WholeCakeDialogue")
local u12 = u11:WaitForChild("Main")
local v13 = u12:WaitForChild("Character")
local u14 = v13:WaitForChild("Textbox"):WaitForChild("TextFrame")
local u15 = u14:WaitForChild("TextReference")
local u16 = v13:WaitForChild("NPCIcon")
local u17 = u11:WaitForChild("Close")
local function u20() --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u7
        [3] = u9
        [4] = u8
        [5] = u2
        [6] = u12
        [7] = u11
    --]]
    u17.Visible = false
    if u7 and coroutine.status(u7) ~= "dead" then
        task.defer(task.cancel, u7)
        u7 = nil
    end
    if u9 and coroutine.status(u9) ~= "dead" then
        task.defer(task.cancel, u9)
        u9 = nil
    end
    if u8 and coroutine.status(u8) ~= "dead" then
        task.defer(task.cancel, u8)
        u8 = nil
    end
    u2:Create(u12, TweenInfo.new(0.5), {
        ["GroupTransparency"] = 1
    }):Play()
    task.wait(0.5)
    u11.Enabled = false
    local v18 = script.SFX:QueryDescendants("Sound")
    for v19 = 1, #v18 do
        v18[v19]:Stop()
    end
end
u17.MouseButton1Click:Connect(u20)
local u21 = require(script.TextCache)
local v22 = {}
task.spawn(function() --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3:PreloadAsync({ script })
end)
function v22.start(_, p23) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u17
        [3] = u14
        [4] = u7
        [5] = u10
        [6] = u6
        [7] = u2
        [8] = u12
        [9] = u21
        [10] = u15
        [11] = u9
        [12] = u8
        [13] = u5
        [14] = u16
        [15] = u20
    --]]
    local u24 = p23.Text
    local u25 = p23.Duration
    local u26 = p23.Mood or "Normal"
    local u27 = p23.Character or "Big Mom"
    u11.Enabled = true
    u17.Visible = false
    local v28 = u14.UIPadding.PaddingLeft.Offset + u14.UIPadding.PaddingRight.Offset
    local u29 = u14.AbsoluteSize.Y * 0.24
    local u30 = u14.AbsoluteSize.X - v28
    local v31 = 0
    local v32 = nil
    for _, v33 in u14:QueryDescendants("#Line") do
        v33:Destroy()
    end
    if u24 then
        v32 = script.Line:Clone()
        v32.Parent = u14
        v31 = 0
        if u7 and coroutine.status(u7) ~= "dead" then
            task.defer(task.cancel, u7)
        end
        local u34 = v32
        local u35 = v31
        for _, v36 in script.SFX:QueryDescendants("Sound") do
            v36:Stop()
        end
        u7 = task.spawn(function() --[[ Line: 119 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u26
                [3] = u6
                [4] = u27
                [5] = u2
                [6] = u12
                [7] = u24
                [8] = u21
                [9] = u15
                [10] = u29
                [11] = u35
                [12] = u30
                [13] = u34
                [14] = u14
                [15] = u9
                [16] = u8
                [17] = u5
                [18] = u16
                [19] = u25
                [20] = u20
                [21] = u17
                [22] = u7
            --]]
            if u10 ~= u26 then
                local v37 = u6[u27].Appear[u26]:GetChildren()
                v37[math.random(#v37)]:Play()
            end
            u10 = u26
            u2:Create(u12, TweenInfo.new(0.5), {
                ["GroupTransparency"] = 0
            }):Play()
            local v38 = 1
            local v39 = {}
            while true do
                if v38 > #u24 then
                    if u9 and coroutine.status(u9) ~= "dead" then
                        task.defer(task.cancel, u9)
                    end
                    if u8 and coroutine.status(u8) ~= "dead" then
                        task.defer(task.cancel, u8)
                    end
                    local u40 = u5[u27][u26]
                    u8 = task.spawn(function() --[[ Line: 216 ]]
                        --[[
                        Upvalues:
                            [1] = u40
                            [2] = u16
                        --]]
                        local v41 = u40.Talking
                        local v42 = 1
                        while true do
                            u16.ImageContent = v41["Talk" .. v42].ColorMapContent
                            v42 = v42 % #v41:GetChildren() + 1
                            task.wait(0.075)
                        end
                    end)
                    local v43 = u6[u27][u26]:GetChildren()
                    local v44 = v43[math.random(#v43)]
                    v44:Play()
                    for _, v45 in v39 do
                        local v46 = v45.Character
                        local v47 = v46.TextLabel
                        local v48 = v47.Position
                        v47.Position = v47.Position - UDim2.fromOffset(0, 5)
                        v47.TextColor3 = u26 == "Mad" and Color3.fromRGB(255, 0, 0) or Color3.new(1, 1, 1)
                        v47.Transparency = 1
                        u2:Create(v47, TweenInfo.new(0.2), {
                            ["TextTransparency"] = 0,
                            ["Position"] = v48
                        }):Play()
                        v46.Parent = v45.Line
                        task.wait()
                    end
                    v44:Stop()
                    if u8 and coroutine.status(u8) ~= "dead" then
                        task.defer(task.cancel, u8)
                    end
                    u9 = task.spawn(function() --[[ Line: 255 ]]
                        --[[
                        Upvalues:
                            [1] = u40
                            [2] = u16
                        --]]
                        local v49 = u40.Idle
                        local v50 = 1
                        while true do
                            u16.ImageContent = v49["Idle" .. v50].ColorMapContent
                            v50 = v50 % #v49:GetChildren() + 1
                            task.wait(0.5)
                        end
                    end)
                    if u25 then
                        task.wait(u25)
                        u20()
                    else
                        task.wait(60)
                        u17.Visible = true
                    end
                    u7 = nil
                    u10 = nil
                    return
                end
                local v51 = 0
                local v52 = {}
                repeat
                    local v53 = u24:sub(v38, v38)
                    if #v53 > 0 then
                        local v54 = u21:GetText({
                            ["Font"] = u15.FontFace,
                            ["TextSize"] = u29,
                            ["Text"] = v53
                        })
                        v38 = v38 + 1
                        v51 = v51 + v54.Size.X.Offset
                        table.insert(v52, v54)
                    end
                until not v53:match("%w")
                if u35 + v51 < u30 then
                    for _, v55 in v52 do
                        local v56 = {
                            ["Character"] = v55,
                            ["Line"] = u34
                        }
                        table.insert(v39, v56)
                    end
                elseif v51 < u30 then
                    u34 = script.Line:Clone()
                    u34.Parent = u14
                    u35 = 0
                    for _, v57 in v52 do
                        local v58 = {
                            ["Character"] = v57,
                            ["Line"] = u34
                        }
                        table.insert(v39, v58)
                    end
                else
                    local v59 = #v52
                    local v60 = 1
                    while v60 < v59 do
                        local v61 = u35
                        local v62 = false
                        while v60 < v59 do
                            local v63 = v52[v60].Size.X.Offset
                            local v64 = v52[v60 + 1] and (v52[v60 + 1].Size.X.Offset or 0) or 0
                            if v61 + v63 + v64 >= u30 then
                                v62 = true
                                break
                            end
                            local v65 = {
                                ["Character"] = u27,
                                ["Line"] = u34
                            }
                            table.insert(v39, v65)
                            v60 = v60 + 1
                            v61 = v61 + v63
                        end
                        if v60 <= v59 and v62 then
                            local v66 = {
                                ["Character"] = u21:GetText({
                                    ["Font"] = u15.FontFace,
                                    ["TextSize"] = u29,
                                    ["Text"] = "-"
                                }),
                                ["Line"] = u34
                            }
                            table.insert(v39, v66)
                        end
                        u34 = script.Line:Clone()
                        u34.Parent = u14
                        u35 = 0
                    end
                end
                u35 = u35 + v51
            end
        end)
    else
        u11.Enabled = false
    end
end
return v22