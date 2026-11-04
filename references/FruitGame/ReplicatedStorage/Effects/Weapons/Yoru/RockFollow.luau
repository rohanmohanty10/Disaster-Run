 

local v1 = {}
local function u34(p2, p3, p4, _) --[[ Line: 4 ]]
    local v5 = CFrame.new(p2.Position)
    local v6 = Ray.new
    local v7 = v5.Position
    local v8 = p4.Size.Y
    local v9 = v6(v7 + Vector3.new(0, v8, 0), CFrame.new(v5.Position).UpVector * -(p4.Size.Y * 2))
    local v10, v11, v12 = _G.raycastWhitelist(v9, { workspace.Islands, workspace.Ships, workspace.Env })
    if v10 and (v10.CanCollide == true and v10:GetAttribute("ignoreTrail") == nil) then
        local u13 = script.Part:Clone()
        _G.matchMaterial(u13, v10)
        local v14 = CFrame.new(v11, v11 + v12)
        local v15 = CFrame.Angles
        local v16 = math.random(-360, 360)
        local v17 = math.rad(v16)
        local v18 = math.random(-360, 360)
        local v19 = math.rad(v18)
        local v20 = math.random(-360, 360)
        local u21 = v14 * v15(v17, v19, (math.rad(v20)))
        local v22 = Vector3.new(p3, p3, p3) * math.random(90, 110) / 100
        u13.Size = v22 / 4
        u13.Parent = workspace.Effects
        if true == nil then
            game:GetService("TweenService"):Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
                ["Size"] = v22
            }):Play()
        else
            u13.Size = v22
        end
        task.delay(2.5, function() --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u21
            --]]
            if u13.Parent ~= nil then
                local v23 = game:GetService("TweenService")
                local v24 = u13
                local v25 = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
                local v26 = {}
                local v27 = CFrame.new(u21.Position) * CFrame.new(0, -u13.Size.X, 0)
                local v28 = CFrame.Angles
                local v29 = math.random(-360, 360)
                local v30 = math.rad(v29)
                local v31 = math.random(-360, 360)
                local v32 = math.rad(v31)
                local v33 = math.random(-360, 360)
                v26.CFrame = v27 * v28(v30, v32, (math.rad(v33)))
                v23:Create(v24, v25, v26):Play()
            end
        end)
        _G.destroy(u13, 3)
        return u13, u21
    end
end
function Lerp(p35, p36, p37)
    return p35 + (p36 - p35) * p37
end
function v1.start(_, p38, p39, p40, p41, p42, p43, p44) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u34
    --]]
    if p38 == nil then
        return
    end
    if _G.checkRenderDistance(p38.Position) == false then
        return
    end
    local v45 = {}
    local v46 = CFrame.new()
    local v47 = tick()
    local v48 = p43 == nil and 100 or p43
    local v49
    if p44 == nil then
        p44 = CFrame.new()
        v49 = p40
    else
        v49 = p40
    end
    while true do
        if p41 == true then
            v49 = Lerp(p40 / 4, p40, (tick() - v47) / p42)
        end
        local v50 = p38.Size.X / 2
        local v51 = {}
        local v52 = {}
        if p39 <= ((p38.CFrame * p44).Position - v46.Position).Magnitude then
            local v53 = p38.CFrame * p44
            local v54 = 1
            for v55 = 1, 2 do
                v54 = v55 == 2 and -1 or v54
                local v56, v57 = u34(v53 * CFrame.new(v50 * v54, 0, 0), v49, p38)
                if v56 then
                    table.insert(v51, v56)
                    table.insert(v52, v57)
                end
            end
            v46 = v53
            for v58 = 1, #v45 do
                v45[v58]:Destroy()
            end
            table.clear(v45)
            for v59 = 1, 6 do
                local v60 = u34
                local v61 = CFrame.Angles
                local v62 = v59 * 30
                local v63, v64 = v60(v53 * v61(0, math.rad(v62), 0) * CFrame.new(v50, 0, 0), v49, p38, true)
                if v63 then
                    table.insert(v51, v63)
                    table.insert(v52, v64)
                    table.insert(v45, v63)
                end
            end
        end
        workspace:BulkMoveTo(v51, v52, Enum.BulkMoveMode.FireCFrameChanged)
        game["Run Service"].Heartbeat:Wait()
        if p38:IsDescendantOf(game) == false or v48 <= tick() - v47 then
            return
        end
    end
end
return v1