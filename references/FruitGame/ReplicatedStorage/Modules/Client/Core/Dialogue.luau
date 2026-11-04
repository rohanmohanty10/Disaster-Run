 

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local v3 = v1.LocalPlayer
local _ = v3.PlayerGui
local u4 = script.Dialogue
u4.Parent = v3.PlayerGui
local u5 = u4.Main
local v6 = u5.Character
local u7 = v6.Background
local u8 = v6.NPCIcon
local u9 = u4.Main.Character.Title
local v10 = script.Utils
local v11 = require(v10.Cleaner)
local v12 = require(v10.RichText)
v12.Init()
local u13 = {
    ["Cleaner"] = v11.new()
}
local v14 = v12.new
local v16 = {
    ["Parent"] = u4.Main.Character.Textbox.TextFrame,
    ["CharacterAdded"] = function(p15) --[[ Name: CharacterAdded, Line 30 ]]
        task.wait(p15 == "." and 0.05 or 0.025)
    end,
    ["TextProperties"] = {
        ["TextColor3"] = Color3.new(1, 1, 1),
        ["TextScaled"] = 0.3
    }
}
u13.TextBox = v14(v16)
local v17 = v12.new
local v18 = {
    ["Parent"] = u9.TextFrame,
    ["CharacterAdded"] = function(_) --[[ Name: CharacterAdded, Line 41 ]]
        task.wait(0.05)
    end,
    ["TextProperties"] = {
        ["TextScaled"] = 0.3,
        ["TextColor3"] = Color3.new(1, 1, 1)
    }
}
u13.Title = v17(v18)
u13.Queue = {}
u13.QueueRunning = false
u13._ImageCache = nil
u13._CachedImages = {}
u13._CacheInactivityThread = nil
function u13._CreateCachePart(p19) --[[ Line: 60 ]]
    if p19._ImageCache and p19._ImageCache.Parent then
        return p19._ImageCache
    end
    local v20 = Instance.new("Part")
    v20.Name = "DialogueImageCache"
    v20.Anchored = true
    v20.CanCollide = false
    v20.CanQuery = false
    v20.CanTouch = false
    v20.Transparency = 1
    v20.Size = Vector3.new(1, 1, 1)
    v20.CFrame = CFrame.new(Vector3.new(0, 10000, 0))
    v20.Parent = workspace:FindFirstChild("Effects")
    p19._ImageCache = v20
    p19._CachedImages = {}
    return v20
end
function u13._CacheImages(p21, p22) --[[ Line: 82 ]]
    if p22 then
        local v23 = p21:_CreateCachePart()
        for _, v24 in p22 do
            if not p21._CachedImages[v24] then
                local v25 = Instance.new("Decal")
                v25.Texture = v24
                v25.Parent = v23
                p21._CachedImages[v24] = true
            end
        end
    end
end
function u13._ResetCacheTimer(u26) --[[ Line: 98 ]]
    if u26._CacheInactivityThread then
        task.cancel(u26._CacheInactivityThread)
        u26._CacheInactivityThread = nil
    end
    u26._CacheInactivityThread = task.delay(300, function() --[[ Line: 104 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        u26:_DestroyCache()
    end)
end
function u13._DestroyCache(p27) --[[ Line: 109 ]]
    if p27._CacheInactivityThread then
        task.cancel(p27._CacheInactivityThread)
        p27._CacheInactivityThread = nil
    end
    if p27._ImageCache then
        p27._ImageCache:Destroy()
        p27._ImageCache = nil
    end
    table.clear(p27._CachedImages)
end
function u13.StartQueue(_) --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    if not u13.QueueRunning then
        u13.QueueRunning = true
        task.spawn(function() --[[ Line: 127 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            while #u13.Queue > 0 do
                table.remove(u13.Queue, 1)()
                task.wait(0.5)
            end
            u13.QueueRunning = false
        end)
    end
end
function u13.Display(_, u28) --[[ Line: 138 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u4
        [3] = u5
        [4] = u2
        [5] = u9
        [6] = u8
        [7] = u7
    --]]
    local v29 = u13.Queue
    local function v44() --[[ Line: 139 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u13
            [3] = u4
            [4] = u5
            [5] = u2
            [6] = u9
            [7] = u8
            [8] = u7
        --]]
        local v30 = u28.Title
        local _ = u28.Text
        local u31 = u28.Duration or 5
        local u32 = u28.Sound
        local u33 = u28.CharacterSound
        local u34 = u28.Character
        local v35
        if u34 then
            v35 = u34.BackgroundColor
        else
            v35 = u34
        end
        local u36
        if u34 then
            u36 = u34.Talking
        else
            u36 = u34
        end
        if u34 then
            u34 = u34.Idle
        end
        local u37 = u13.TextBox
        local v38 = u28.AppearSound
        u13:_CacheImages(u36)
        u13:_CacheImages(u34)
        u13:_ResetCacheTimer()
        u13.Cleaner:Destroy()
        u13.TextBox:Clear()
        u13.Title:Clear()
        if not u4.Enabled then
            u4.Enabled = true
            u5.UIGradient.Offset = Vector2.zero
            if v38 then
                v38[math.random(#v38)]:Play()
            end
        end
        u2:Create(u5.UIGradient, TweenInfo.new(1.5), {
            ["Offset"] = Vector2.xAxis
        }):Play()
        u9.Visible = v30 ~= nil
        if v30 then
            u13.Title:Display(v30)
        end
        u13.Cleaner.OnCharacterAdded = u37.OnCharacterAdded:Connect(function(p39) --[[ Line: 185 ]]
            --[[
            Upvalues:
                [1] = u33
            --]]
            if u33 and p39 ~= " " then
                local v40 = u33[math.random(#u33)]:Clone()
                v40.Parent = script
                v40:Play()
                task.wait(v40.TimeLength + 3)
                v40:Destroy()
            end
        end)
        u13.Cleaner.TextThread = task.delay(0.1, function() --[[ Line: 198 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u37
                [3] = u28
                [4] = u31
                [5] = u13
            --]]
            if u32 then
                u32:Play()
            end
            u37:Display(u28.Text)
            repeat
                task.wait()
            until u37.IsTextFinished
            if u32 then
                u32:Stop()
            end
            task.wait(u31)
            u13:Clear()
        end)
        u13.Cleaner.UpdateSprites = task.spawn(function() --[[ Line: 213 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u36
                [3] = u37
                [4] = u34
            --]]
            u8.Visible = u36 ~= nil
            if u36 then
                local v41 = 1
                repeat
                    u8.Image = u36[v41]
                    v41 = v41 % #u36 + 1
                    task.wait(0.2)
                until u37.IsTextFinished
            end
            u8.Visible = u34 ~= nil
            if u34 then
                local v42 = 1
                while true do
                    u8.Image = u34[v42]
                    v42 = v42 % #u34 + 1
                    task.wait(0.35)
                end
            else
                return
            end
        end)
        u13.Cleaner.Exit = u4.Close.MouseButton1Click:Connect(function() --[[ Line: 237 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            u13:FastClear()
        end)
        local u43 = u13.TextBox.ScrollingFrame
        u13.Cleaner.AutoScroll = u43:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() --[[ Line: 242 ]]
            --[[
            Upvalues:
                [1] = u43
            --]]
            task.wait()
            u43.CanvasPosition = Vector2.new(0, u43.AbsoluteCanvasSize.Y)
        end)
        u7.Visible = v35 ~= nil
        if v35 then
            u7.ImageColor3 = v35
        end
    end
    table.insert(v29, v44)
    u13:StartQueue()
end
function u13.FastClear(_) --[[ Line: 257 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u13
    --]]
    u4.Enabled = false
    u13.Cleaner:Destroy()
    u13.TextBox:Clear()
    u13.Title:Clear()
end
function u13.ClearQueue(_) --[[ Line: 265 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    table.clear(u13.Queue)
    u13.QueueRunning = false
end
function u13.Clear(_) --[[ Line: 270 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u13
    --]]
    u2:Create(u5.UIGradient, TweenInfo.new(1), {
        ["Offset"] = Vector2.zero
    }):Play()
    u13.Cleaner.CleanThread = task.delay(1, u13.FastClear, u13)
end
return u13