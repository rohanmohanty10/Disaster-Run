 

local u1 = {}
u1.__index = u1
local u2 = game.Players.LocalPlayer
game:GetService("UserInputService")
local u3 = u2.Character or u2.CharacterAdded:Wait()
function u1.new(p4) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v5 = u1
    local v6 = setmetatable({}, v5)
    v6.Utils = p4.Utils
    return v6
end
local u7 = false
function u1.PC_Activate(p8) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u7
    --]]
    if p8.Utils.hitStunned(u3) >= 1 then
        if u3:GetAttribute("evasiveBar") >= u3.Humanoid.MaxHealth * u3:GetAttribute("healthPercentEvasive") + u3:GetAttribute("baseEvasiveReq") then
            if u3:FindFirstChild("GrabTag") == nil and (_G.canuse == true and game.ReplicatedStorage.Events.Skill:InvokeServer("BasicEvasive") == true) then
                u7 = true
                task.delay(0.75, function() --[[ Line: 27 ]]
                    _G.canuse = false
                    task.wait(0.3)
                    _G.canuse = true
                end)
                return
            end
        else
            script.EvasiveSFX.EvasiveOnCooldown:Play()
        end
    end
end
local u9 = false
local function v12() --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u7
        [3] = u9
        [4] = u2
    --]]
    local v10 = u3.Humanoid.MaxHealth * u3:GetAttribute("healthPercentEvasive") + u3:GetAttribute("baseEvasiveReq")
    if u7 == true and (v10 <= u3:GetAttribute("evasiveBar") and u3:GetAttribute("evasiveBar") ~= 12345678) then
        if u9 == false then
            script.EvasiveSFX.EvasiveReady:Play()
            local v11 = script.Flash:Clone()
            v11.Parent = u2.PlayerGui
            _G.tween(v11.Frame, { 0.75, "Quad", Enum.EasingDirection.Out }, {
                ["BackgroundTransparency"] = 1
            })
            _G.destroy(v11, 0.75)
        end
        u9 = true
    else
        u9 = false
    end
end
u3:GetAttributeChangedSignal("evasiveBar"):Connect(v12)
u1.Mobile_Activate = u1.PC_Activate
return u1