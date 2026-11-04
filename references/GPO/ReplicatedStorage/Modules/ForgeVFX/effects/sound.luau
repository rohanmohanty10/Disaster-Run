 

local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u3 = require("../mod/attributes")
local u4 = require("../mod/tween")
require("../types")
local u5 = require("../mod/utility")
local u6 = require("../pkg/Promise")
local u7 = Random.new()
local v8 = {}
local u9 = nil
local function u21(p10) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u7
    --]]
    local v11 = u3.get(p10, "SoundPoolTag", "")
    if v11 == "" then
        return p10
    end
    local v12 = {}
    local v13 = {}
    local v14 = 0
    for _, v15 in u2:GetTagged(v11) do
        if v15:IsA("Sound") then
            table.insert(v12, v15)
            local v16 = u3.get(v15, "SoundPoolWeight", 1)
            table.insert(v13, v16)
            v14 = v14 + v16
        end
    end
    if #v12 == 0 then
        return p10
    end
    if v14 > 0 then
        local v17 = u7:NextNumber() * v14
        local v18 = 0
        for v19, v20 in v13 do
            v18 = v18 + v20
            if v17 <= v18 then
                return v12[v19]
            end
        end
    end
    return v12[u7:NextInteger(1, #v12)]
end
local function u29(p22, p23, p24) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
    --]]
    local v25 = p23:Clone()
    for _, v26 in v25:GetTags() do
        v25:RemoveTag(v26)
    end
    local v27 = p22:FindFirstAncestorWhichIsA("BasePart")
    local v28 = nil
    if u5.PLUGIN_CONTEXT then
        if v27 then
            v28 = Instance.new("Part")
            v28.Name = "SoundEmitter"
            v28.Anchored = true
            v28.CanCollide = false
            v28.CanQuery = false
            v28.CanTouch = false
            v28.Transparency = 1
            v28.Size = Vector3.new(1, 1, 1)
            v28.CFrame = v27.CFrame
            v28.Parent = u9
            v25.Parent = v28
            table.insert(p24, v28)
        else
            v25.Parent = u9
            table.insert(p24, v25)
        end
    else
        if v27 then
            v25.Parent = v27
        else
            v25.Parent = workspace.Terrain
        end
        table.insert(p24, v25)
    end
    return v25, v28
end
local function u64(p30, p31, u32, u33, p34, p35) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u1
    --]]
    local u36 = u32.PlaybackSpeed
    local u37 = u3.get(p31, "Volume_End", u32.Volume)
    local u38 = u3.get(p31, "Volume_Start", u32.Volume)
    u32.Volume = u38
    if u38 == u37 then
        u32.Volume = u38
    else
        local v39 = u3.get(p31, "Volume_Duration", u32.TimeLength)
        local v40 = u4.fromParams
        local v41 = u3.get(p31, "Volume_Curve", u5.default_bezier)
        local function v44(p42, p43) --[[ Line: 129 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u5
                [3] = u38
                [4] = u37
                [5] = u36
            --]]
            u32.Volume = u5.lerp(u38, u37, p42)
            return p43 * u36
        end
        table.insert(p34, v40(v41, v39, v44))
    end
    local u45 = u3.get(p31, "Speed_End", u32.PlaybackSpeed)
    local u46 = u3.get(p31, "Speed_Start", u32.PlaybackSpeed)
    local u47 = u46
    local u48 = nil
    if u46 == u45 then
        u32.PlaybackSpeed = u46
    else
        local v49 = u3.get(p31, "Speed_Duration", u32.TimeLength)
        u48 = u4.fromParams(u3.get(p31, "Speed_Curve", u5.default_bezier), v49, function(p50, p51) --[[ Line: 151 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u5
                [3] = u46
                [4] = u45
                [5] = u32
            --]]
            u47 = u5.lerp(u46, u45, p50)
            u32.PlaybackSpeed = u47
            return p51
        end)
        table.insert(p34, u48)
    end
    local u52 = u3.get(p31, "RollOff_End", u32.RollOffMinDistance)
    local u53 = u3.get(p31, "RollOff_Start", u32.RollOffMinDistance)
    if u53 ~= u52 then
        local v54 = u3.get(p31, "RollOff_Duration", u32.TimeLength)
        local v55 = u4.fromParams
        local v56 = u3.get(p31, "RollOff_Curve", u5.default_bezier)
        local function v59(p57, p58) --[[ Line: 174 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u5
                [3] = u53
                [4] = u52
                [5] = u47
            --]]
            u32.RollOffMinDistance = u5.lerp(u53, u52, p57)
            return p58 * u47
        end
        table.insert(p34, v55(v56, v54, v59, u48))
    end
    if u32.PlayOnRemove and not u5.PLUGIN_CONTEXT then
        u32:Destroy()
    else
        u32:Play()
    end
    local u60 = u33 and p30:FindFirstAncestorWhichIsA("BasePart")
    if u60 then
        local v61 = u1.Heartbeat
        table.insert(p34, v61:Connect(function() --[[ Line: 195 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u60
            --]]
            if u33.Parent then
                u33.CFrame = u60.CFrame
            end
        end))
    end
    if p35 > 0 then
        task.wait(p35)
        u32:Stop()
    else
        u4.timer(u32.TimeLength, function(p62, p63) --[[ Line: 208 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u48
            --]]
            if u32.PlaybackSpeed > 0 or p63 > 0 and (u48 and u48.Connected) then
                return p62 * u32.PlaybackSpeed
            else
                return nil
            end
        end, u48, p34)
    end
    return u48
end
function v8.init() --[[ Line: 218 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
    --]]
    if u5.PLUGIN_CONTEXT then
        local v65 = script:FindFirstAncestorOfClass("Plugin")
        if v65 then
            u9 = v65:CreateDockWidgetPluginGui("VFXForgeSoundPlayer", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, true, 200, 100, 100, 50))
            if u9 then
                u9.Name = "VFXForgeSoundPlayer"
            end
        end
    else
        return
    end
end
function v8.deinit() --[[ Line: 239 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    if u9 then
        u9:Destroy()
        u9 = nil
    end
end
function v8.emit(u66, u67) --[[ Line: 246 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u21
        [3] = u6
        [4] = u29
        [5] = u64
        [6] = u7
    --]]
    if u66.Playing then
        u66:Stop()
    end
    local v68 = u3.get(u66, "SoundPoolIsSource", false)
    local v69 = u3.get(u66, "SoundPoolInheritAttributes", false)
    if v69 then
        if not v68 then
            u66 = u21(u66) or u66
        end
    end
    local v70 = u3.get(u66, "EmitDelay", 0)
    local u71 = u3.get(u66, "EmitDuration", 0)
    local v72 = u3.get(u66, "EmitCount", 1)
    local v73 = u3.getRange(u66, "EmitInterval", NumberRange.new(0, 0))
    local v74 = u3.get(u66, "RepeatCount", 1)
    local v75 = u3.getRange(u66, "RepeatInterval", NumberRange.new(0, 0))
    task.wait(v70)
    local v76 = {}
    for v77 = 1, v72 do
        local u78 = v69 and u66
        if not u78 then
            if v68 then
                u78 = u66
            else
                u78 = u21(u66) or u66
            end
        end
        if u78 then
            local u79
            if v69 and u78 ~= u66 then
                u79 = u78
            else
                u79 = u66
            end
            for v80 = 1, v74 do
                local v81 = u6.new
                local function v85(p82) --[[ Line: 283 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u66
                        [3] = u78
                        [4] = u67
                        [5] = u64
                        [6] = u79
                        [7] = u71
                    --]]
                    local v83, v84 = u29(u66, u78, u67)
                    u64(u66, u79, v83, v84, u67, u71)
                    if v84 then
                        v84:Destroy()
                    else
                        v83:Destroy()
                    end
                    p82()
                end
                table.insert(v76, v81(v85))
                if v80 < v74 and v75.Max > 0 then
                    task.wait(u7:NextNumber(v75.Min, v75.Max))
                end
            end
            if v77 < v72 and v73.Max > 0 then
                task.wait(u7:NextNumber(v73.Min, v73.Max))
            end
        end
    end
    u6.all(v76):await()
end
return v8