 

local u1 = game:GetService("CollectionService")
local u2 = game:GetService("Players").LocalPlayer.PlayerGui
local u3 = workspace.BountyCharacters
local u4 = require(script.Board)
local u5 = require(script.Poster)
return {
    ["Initialized"] = false,
    ["Boards"] = {},
    ["Tools"] = {},
    ["AddPoster"] = function(p6, p7) --[[ Name: AddPoster, Line 16 ]]
        for _, v8 in p6.Boards do
            v8:AddPoster(p7)
        end
    end,
    ["RemovePoster"] = function(p9, p10) --[[ Name: RemovePoster, Line 22 ]]
        for _, v11 in p9.Boards do
            v11:RemovePoster(p10)
        end
    end,
    ["AddBoard"] = function(p12, p13) --[[ Name: AddBoard, Line 28 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        if not p12.Boards[p13] then
            p12.Boards[p13] = u4.new({
                ["Board"] = p13
            })
        end
    end,
    ["RemoveBoard"] = function(p14, p15) --[[ Name: RemoveBoard, Line 33 ]]
        if p14.Boards[p15] then
            p14.Boards[p15]:Destroy()
            p14.Boards[p15] = nil
        end
    end,
    ["AddTool"] = function(u16, u17) --[[ Name: AddTool, Line 39 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
        --]]
        local u18 = Instance.fromExisting(script.Board.BoardUI)
        u18.ResetOnSpawn = false
        u18.LightInfluence = 1
        u18.Adornee = u17:WaitForChild("Handle")
        u18.Parent = u2:WaitForChild("BountyHunt"):WaitForChild("Tools")
        if u17:WaitForChild("Render") then
            local v19 = u17.Render.Value or u17.Render.Changed:Wait()
            local v20 = u5.new({
                ["HuntedCharacter"] = v19,
                ["ParentUI"] = u18
            })
            v20.Cleaner:AddTask(u18)
            local function v21() --[[ Line: 58 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u16
                    [3] = u18
                --]]
                if u17:IsDescendantOf(game) == false then
                    u16:RemoveTool(u17)
                else
                    u18.Enabled = u17.Parent:FindFirstChild("Humanoid") ~= nil
                end
            end
            local function v23(p22) --[[ Line: 63 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                if p22.Name == "Handle" then
                    u18.Adornee = p22
                end
            end
            local v24 = v20.UI
            v24.Background.Rotation = 0
            v24.Size = UDim2.fromScale(1, 1)
            if u17:IsDescendantOf(game) == false then
                u16:RemoveTool(u17)
            else
                u18.Enabled = u17.Parent:FindFirstChild("Humanoid") ~= nil
            end
            v20.Cleaner:AddTask(u17:GetPropertyChangedSignal("Parent"):Connect(v21))
            v20.Cleaner:AddTask(u17.ChildAdded:Connect(v23))
            print("tool added")
            u16.Tools[u17] = v20
        else
            u18:Destroy()
        end
    end,
    ["RemoveTool"] = function(p25, p26) --[[ Name: RemoveTool, Line 80 ]]
        if p25.Tools[p26] then
            print("tool destroyed")
            p25.Tools[p26]:Destroy()
            p25.Tools[p26] = nil
        end
    end,
    ["Initialize"] = function(u27) --[[ Name: Initialize, Line 89 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
        --]]
        if not u27.Initialized then
            local function v29(p28) --[[ Line: 92 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27:AddBoard(p28)
            end
            local function v31(p30) --[[ Line: 96 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27:RemoveBoard(p30)
            end
            for _, v32 in u1:GetTagged("Bounty Boards") do
                task.spawn(v29, v32)
            end
            u1:GetInstanceAddedSignal("Bounty Boards"):Connect(v29)
            u1:GetInstanceRemovedSignal("Bounty Boards"):Connect(v31)
            local function v34(p33) --[[ Line: 104 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27:AddPoster(p33)
            end
            local function v36(p35) --[[ Line: 108 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27:RemovePoster(p35)
            end
            for _, v37 in u3:GetChildren() do
                task.spawn(v34, v37)
            end
            u3.ChildAdded:Connect(v34)
            u3.ChildRemoved:Connect(v36)
            u1:GetInstanceAddedSignal("Bounty Posters"):Connect(function(p38) --[[ Name: AddTool, Line 116 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27:AddTool(p38)
            end)
            u1:GetInstanceRemovedSignal("Bounty Posters"):Connect(function(p39) --[[ Name: RemoveTool, Line 120 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27:RemoveTool(p39)
            end)
            warn("bounty hunting initialized")
            u27.Initialized = true
        end
    end
}