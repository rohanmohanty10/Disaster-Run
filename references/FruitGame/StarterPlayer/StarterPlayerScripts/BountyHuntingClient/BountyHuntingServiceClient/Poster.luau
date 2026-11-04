 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.BountyHunting
local v4 = v3.Modules
local u5 = v3.Remotes
local u6 = v2.LocalPlayer
local _ = u6.PlayerGui
local u7 = require(v4.Maid)
local u8 = require(v4.Signal)
local u9 = {}
u9.__index = u9
function u9.new(p10) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u7
        [3] = u8
    --]]
    local v11 = u9
    local v12 = setmetatable({}, v11)
    v12.Cleaner = u7.new()
    v12.Destroyed = u8.new()
    v12.HuntedCharacter = p10.HuntedCharacter
    v12.Parent = p10.Parent
    v12.UI = v12:_createUI(p10.ParentUI)
    v12:_main()
    return v12
end
function u9._createUI(p13, p14) --[[ Line: 32 ]]
    local u15 = script.BountyPoster:Clone()
    p13.UI = u15
    local u16 = u15.Background.ViewportFrame
    local u17 = p13.HuntedCharacter:Clone()
    u17.Parent = u16
    p13.Cleaner:AddTask(task.spawn(function() --[[ Line: 42 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u16
            [3] = u15
        --]]
        local v18 = u17.Humanoid
        local v19 = u17:WaitForChild("HumanoidRootPart")
        local _ = v19.Size.Y * 0.5 + v18.HipHeight
        local v20 = Instance.new("Camera")
        v20.CFrame = u17.Head.CFrame * CFrame.new(0, 0, -v19.Size.Z * 3) * CFrame.Angles(0, 3.141592653589793, 0)
        v20.Parent = u16
        u16.CurrentCamera = v20
        u15.Name = u17.Name
    end))
    p13.Cleaner:AddTask(p13.UI)
    u15.Parent = p14
    return u15
end
function u9._main(u21) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
    --]]
    local u22 = u21.UI.Background
    u22.PlayerName.Text = u21.HuntedCharacter.Name
    local function v24() --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u22
        --]]
        local v23 = u21.HuntedCharacter:GetAttribute("Bounty")
        u22.Peli.Text = v23
        u21.UI.Visible = u21.HuntedCharacter:GetAttribute("NPC") or v23 >= 10000
        if _G.arena == true then
            u21.UI.Visible = true
        end
    end
    local function v26(_) --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u6
            [3] = u5
        --]]
        if u21.Parent then
            local v25 = u21.Parent.Model
            if u6.Character.Name == u21.HuntedCharacter.Name then
                warn("same person")
                return
            elseif (v25.Position - u6.Character.HumanoidRootPart.Position).Magnitude >= 25 then
                warn("too far")
            else
                u5.Interact:FireServer({
                    ["ID"] = u21.Parent.ID,
                    ["Board"] = v25,
                    ["Wanted"] = u21.HuntedCharacter
                })
            end
        else
            warn("no parent")
            return
        end
    end
    local v27 = u21.HuntedCharacter:GetAttribute("Bounty")
    u22.Peli.Text = v27
    u21.UI.Visible = u21.HuntedCharacter:GetAttribute("NPC") or v27 >= 10000
    if _G.arena == true then
        u21.UI.Visible = true
    end
    u21.Cleaner:AddTask(u21.HuntedCharacter:GetAttributeChangedSignal("Bounty"):Connect(v24))
    u21.Cleaner:AddTask(u22.Activated:Connect(v26))
end
function u9.Destroy(p28) --[[ Line: 96 ]]
    p28.Cleaner:Destroy()
    p28.Destroyed:Fire()
    setmetatable(p28, nil)
end
return u9