 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = workspace.Effects
local u4 = Random.new()
local u5 = RaycastParams.new()
u5.FilterDescendantsInstances = { u3, workspace.PlayerCharacters, workspace.NPCs }
u5.FilterType = Enum.RaycastFilterType.Exclude
local function u14(p6, p7) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = p7 or 1
    local v9 = u2
    local v10 = TweenInfo.new(v8)
    local v11 = {}
    local v12 = p6.Position
    local v13 = p6.Size.Magnitude / 2
    v11.Position = v12 - Vector3.new(0, v13, 0)
    v9:Create(p6, v10, v11):Play()
    _G.destroy(p6, v8)
end
local function u19(p15) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u14
    --]]
    local v16 = p15.Raycast
    local _ = p15.Size
    local v17 = p15.FadeDuration
    local _ = p15.Direction
    local v18 = Instance.new("Part")
    v18.Anchored = true
    v18.CanCollide = false
    v18.Color = v16.Instance.Color
    v18.Material = v16.Material
    v18.CFrame = p15.CFrame
    v18.Size = p15.Size
    v18.TopSurface = "Smooth"
    v18.BottomSurface = "Smooth"
    v18.Parent = u3
    task.delay(v17, u14, v18)
    return v18
end
return {
    ["start"] = function(_, p20) --[[ Name: start, Line 64 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u14
            [4] = u19
            [5] = u1
            [6] = u5
        --]]
        local u21 = p20.PartCountLimit or 150
        local u22 = p20.Part
        local v23 = p20.Direction or u22.CFrame.LookVector
        local u24 = CFrame.new(u22.Position, u22.Position + v23 * Vector3.new(1, 0, 1)).LookVector
        local u25 = p20.DownVector or 20
        local u26 = p20.Radius
        local u27 = p20.Size
        local u28 = p20.FadeDuration
        local u29 = p20.Angle
        local u30 = p20.Interval or 0.05
        local u31 = p20.EndSegments or 10
        local u32 = {}
        local u33 = 0
        local u34 = {}
        for v35 = 0, u31 do
            local v36 = Instance.new("Part")
            v36.Anchored = true
            v36.CanCollide = false
            local v37 = 1.5707963267948966 / u31
            local v38 = math.sin(v37) * u26 * 2
            local v39 = u27.Y
            local v40 = u27.X
            v36.Size = Vector3.new(v38, v39, v40) * u4:NextNumber(0.85, 1.15)
            v36.Name = v35
            v36.TopSurface = "Smooth"
            v36.BottomSurface = "Smooth"
            v36.Parent = u3
            u32[v35] = {
                ["Part"] = v36,
                ["Thread"] = task.delay(u28, u14, v36),
                ["Angle"] = u29 * u4:NextNumber(0.85, 1.15)
            }
        end
        local u41 = {}
        local u42 = nil
        u22.Destroying:Connect(function() --[[ Line: 106 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            u42:Disconnect()
        end)
        local function u57(p43) --[[ Line: 110 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u4
                [3] = u29
                [4] = u41
                [5] = u19
                [6] = u28
                [7] = u24
                [8] = u34
            --]]
            local v44 = u27 * u4:NextNumber(0.85, 1.25)
            local v45 = u29 * u4:NextNumber(0.85, 1.25)
            for v46, v47 in pairs(p43) do
                if v47 then
                    local v48 = u41[v46]
                    local v49 = u19
                    local v50 = {
                        ["Raycast"] = v47
                    }
                    local v51
                    if v48 or not v44 then
                        local v52 = v44.X
                        local v53 = v44.Y
                        local v54 = (v47.Position - v48.Part.Position).Magnitude
                        v51 = Vector3.new(v52, v53, v54)
                    else
                        v51 = v44
                    end
                    v50.Size = v51
                    v50.FadeDuration = u28
                    v50.CFrame = not v48 and CFrame.new(v47.Position, v47.Position + u24) or CFrame.lookAt(v47.Position, v48.Part.Position, v47.Normal) * CFrame.new(0, 0, -(v47.Position - v48.Part.Position).Magnitude / 2) * CFrame.Angles(0, 0, (v46 == "Left" and 1 or -1) * v45)
                    local v55 = v49(v50)
                    local v56 = u34
                    table.insert(v56, v55)
                    v55.Transparency = v48 and 0 or 1
                    u41[v46] = {
                        ["Part"] = v55,
                        ["OldPart"] = v48 and v48.Part or nil,
                        ["HitInstance"] = v47.Instance,
                        ["HitPosition"] = v47.Position,
                        ["Size"] = v44,
                        ["Angle"] = v45
                    }
                end
            end
        end
        u42 = u1.Heartbeat:Connect(function(p58) --[[ Line: 141 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u25
                [3] = u24
                [4] = u31
                [5] = u32
                [6] = u26
                [7] = u5
                [8] = u28
                [9] = u14
                [10] = u41
                [11] = u57
                [12] = u34
                [13] = u21
                [14] = u33
                [15] = u30
            --]]
            local v59 = u22.CFrame * CFrame.new(0, u22.Size.Y / 2, -u22.Size.Z / 2).Position
            local v60 = -u25
            local v61 = Vector3.new(0, v60, 0)
            local v62 = u24:Cross(Vector3.new(0, 1, 0))
            for v63 = 0, u31 do
                local v64 = u32[v63].Part
                local v65 = 3.141592653589793 * v63 / u31 - 1.5707963267948966
                local v66 = v59 + v62 * math.sin(v65) * u26 + u24 * math.cos(v65) * u26
                local v67 = workspace:Raycast(v66, v61, u5)
                if v67 then
                    v64.Color = v67.Instance.Color
                    v64.Material = v67.Material
                    local v68 = CFrame.lookAt
                    local v69 = v67.Position
                    local v70 = v59.X
                    local v71 = v67.Position.Y
                    local v72 = v59.Z
                    v64.CFrame = v68(v69, Vector3.new(v70, v71, v72), v67.Normal) * CFrame.Angles(u32[v63].Angle, 0, 0)
                    task.cancel(u32[v63].Thread)
                    u32[v63].Thread = task.delay(u28, u14, v64)
                end
            end
            local v73 = {}
            local v74 = v59 - v62 * u26
            v73.Left = workspace:Raycast(v74, v61, u5)
            local v75 = v59 + v62 * u26
            v73.Right = workspace:Raycast(v75, v61, u5)
            for v76, v77 in pairs(v73) do
                if u41[v76] and u41[v76].OldPart then
                    if u41[v76].HitInstance == v77.Instance then
                        ::l10::
                        local v78 = (v76 == "Left" and u32[0] or u32[u31]).Part
                        local v79 = v78.CFrame * CFrame.new((v76 == "Left" and -1 or 1) * v78.Size.X / 2, 0, 0).Position
                        local v80 = (u41[v76].OldPart.CFrame * CFrame.new(0, 0, -u41[v76].OldPart.Size.Z / 2)).Position
                        local v81 = (v79 - v80).Magnitude
                        if v81 < 50 then
                            local v82 = u41[v76]
                            local v83 = v82.Part
                            v83.Transparency = 0
                            v83.CFrame = CFrame.lookAt(v80, v79, v77.Normal) * CFrame.new(0, 0, -v81 / 2) * CFrame.Angles(0, 0, (v76 == "Left" and 1 or -1) * v82.Angle)
                            local v84 = v82.Size.X
                            local v85 = v82.Size.Y
                            v83.Size = Vector3.new(v84, v85, v81)
                            if u21 <= #u34 then
                                task.spawn(u14, u34[1], 0.5)
                                table.remove(u34, 1)
                            end
                        end
                    elseif (v77.Position - u41[v76].HitPosition).Magnitude < 50 then
                        u57(v73)
                        goto l10
                    end
                end
            end
            u33 = u33 + p58
            if u33 > u30 then
                u33 = 0
                u57(v73)
            end
        end)
    end
}