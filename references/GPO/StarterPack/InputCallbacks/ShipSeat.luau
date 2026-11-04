 

local u1 = {}
u1.__index = u1
local v2 = game.Players.LocalPlayer
game:GetService("UserInputService")
local u3 = v2.Character or v2.CharacterAdded:Wait()
function u1.new(p4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v5 = u1
    local v6 = setmetatable({}, v5)
    v6.Handler = p4
    v6.SeatLoop = nil
    v6.SitAnim = u3.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Util.Movement.Sit)
    v6.SitAnim.Priority = Enum.AnimationPriority.Action4
    v6.Utils = p4.Utils
    return v6
end
function u1.PC_Activate(u7) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u8 = u7.SitAnim
    local v9 = u3.Humanoid
    if v9 and v9:GetStateEnabled(Enum.HumanoidStateType.Seated) == false then
        return
    elseif u3:GetAttribute("flyMode") then
        _G.displayMessage("<Color=Red>Cant sit while flying!")
    else
        local v10, _ = game.ReplicatedStorage.Events.shipSit:InvokeServer()
        local u11 = _G.awaitObject(v10)
        if u11 == nil or u8.IsPlaying ~= false then
            if u7.SeatLoop then
                u7.SeatLoop:Disconnect()
                u7.SeatLoop = nil
            end
            u8:Stop()
        else
            if u7.SeatLoop then
                u7.SeatLoop:Disconnect()
                u7.SeatLoop = nil
            end
            u7.SeatLoop = game["Run Service"].Stepped:Connect(function() --[[ Line: 40 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u3
                    [3] = u7
                    [4] = u8
                --]]
                if u11.Occupant ~= u3.Humanoid then
                    if u7.SeatLoop then
                        u7.SeatLoop:Disconnect()
                        u7.SeatLoop = nil
                    end
                    u8:Stop()
                end
            end)
            u8:Play()
        end
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1