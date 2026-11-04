 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.BountyHunting.Modules
local u4 = workspace.BountyCharacters
local u5 = v2.LocalPlayer.PlayerGui
local u6 = require(v3.Maid)
require(v3.Signal)
local u7 = require(script.Parent.Poster)
local u8 = require(v1.Modules.Shared.Queues.QueueTask)
local u9 = {}
u9.__index = u9
function u9.new(p10) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u6
        [3] = u8
    --]]
    local v11 = u9
    local v12 = setmetatable({}, v11)
    v12.Cleaner = u6.new()
    v12.Model = p10.Board
    v12.ID = v12.Model:GetAttribute("ID")
    v12.Posters = {}
    v12.UI = v12:_createUI()
    v12.Serialized = {}
    v12.Queue = u8.new()
    v12:_main()
    return v12
end
function u9._createUI(p13) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v14 = script.BoardUI:Clone()
    v14.Adornee = p13.Model
    v14.Parent = u5:WaitForChild("BountyHunt"):WaitForChild("Board")
    p13.Cleaner:AddTask(v14)
    return v14
end
function u9.GetPoster(p15, p16) --[[ Line: 47 ]]
    return p15.Posters[p16]
end
function u9.AddPoster(u17, u18) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if not u17:GetPoster(u18) then
        u17.Queue:QueueTask(function() --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u18
                [3] = u7
            --]]
            u17.Posters[u18] = u7.new({
                ["HuntedCharacter"] = u18,
                ["ParentUI"] = u17.UI:WaitForChild("CanvasGroup"):WaitForChild("ScrollingFrame", 2),
                ["Parent"] = u17
            })
            task.wait(0.5)
        end)
        u17.Serialized[u18] = u17.Queue.pendingTasks[#u17.Queue.pendingTasks]
    end
end
function u9.RemovePoster(p19, p20) --[[ Line: 62 ]]
    local v21 = table.find(p19.Queue.pendingTasks, p19.Serialized[p20])
    if v21 then
        table.remove(p19.Queue.pendingTasks, v21)
        p19.Serialized[p20] = nil
    end
    if p19:GetPoster(p20) then
        p19.Posters[p20]:Destroy()
        p19.Posters[p20] = nil
    end
end
function u9._main(p22) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    for _, v23 in u4:GetChildren() do
        p22.Cleaner:AddTask(task.delay(0, p22.AddPoster, p22, v23))
    end
end
function u9.Destroy(p24) --[[ Line: 84 ]]
    for _, v25 in p24.Posters do
        v25:Destroy()
    end
    p24.Cleaner:Destroy()
    setmetatable(p24, nil)
end
return u9