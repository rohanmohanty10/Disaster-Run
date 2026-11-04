 

local u1 = {}
u1.__index = u1
local u2 = game.Players.LocalPlayer
game:GetService("UserInputService")
if not u2.Character then
    u2.CharacterAdded:Wait()
end
local u3 = u2.Character
local u4 = u3:WaitForChild("Humanoid")
local u5 = u4.Animator:LoadAnimation(script.run)
_G.runAnim = u5
local u6 = nil
function u1.new(p7) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u6
        [3] = u5
        [4] = u3
    --]]
    local v8 = u1
    local u9 = setmetatable({}, v8)
    u9.Handler = p7
    u9.Utils = p7.Utils
    u9.HoldingRun = false
    function u9.hookRun() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
            [3] = u9
            [4] = u3
        --]]
        if u6 then
            u6:Disconnect()
            u6 = nil
        end
        u6 = u5.KeyframeReached:Connect(function(p10) --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u3
            --]]
            if u9.Utils.checkHoldingWeapon() == true then
                return
            elseif u3.PrimaryPart.Anchored ~= true then
                if p10:match("step") and (p10 ~= "step" and _G.footstep) then
                    _G.footstep(p10)
                end
            end
        end)
    end
    return u9
end
local u11 = 0
function u1.PC_Activate(p12) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
        [3] = u2
        [4] = u4
        [5] = u11
    --]]
    u5 = _G.runAnim
    local v13 = p12.Utils.checkHoldingWeapon
    if (_G.check:inspect(u3) == false or _G.canuse == false) and (u3:FindFirstChild("ragcarry") == nil and u3:findFirstChild("kenTrain") == nil) then
        repeat
            task.wait()
        until p12.HoldingRun == false or _G.check:inspect(u3) == true and _G.canuse == true
        if _G.check:inspect(u3) == false or p12.HoldingRun == false then
            return
        end
    end
    local v14 = 25
    if game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name).Customization.Race.Value:match("Fishman") == nil then
        p12.Handler.Fishman = false
    else
        p12.Handler.Fishman = true
    end
    if p12.Handler.Fishman == true and _G.swimming == true then
        v14 = u3:FindFirstChild("inCombat") == nil and 35 or v14 * 1.2
    end
    local v15 = u3:GetAttribute("sulongTransformed") == true and 35 or v14
    u4.WalkSpeed = v15
    if v13() == false then
        u5:Play()
        u5:AdjustSpeed(2)
        u5.TimePosition = u11
    end
    p12.hookRun()
    _G.running = true
    while true do
        v15 = u3:GetAttribute("customM1") == "BuddhaMode" and u3:FindFirstChild("inCombat") == nil and 32.5 or v15
        if u4.Health >= u4.MaxHealth / 4 and _G.canuse == true then
            if _G.swimming == false and v15 ~= 25 then
                v15 = 25
                u4.WalkSpeed = v15
            elseif _G.swimming == true and (v15 ~= 35 and p12.Handler.Fishman == true) then
                v15 = u3:FindFirstChild("inCombat") == nil and 35 or 30
                u4.WalkSpeed = v15
            end
            local v16 = u3:GetAttribute("sulongTransformed") == true and 35 or v15
            v15 = u3:GetAttribute("CustomRunSpeed") or v16
            local v17 = u3:FindFirstChildWhichIsA("ObjectValue")
            if (v17 == nil or v17 and v17.Name == "kenTrain") and (u4.WalkSpeed < v15 and _G.canuse == true) then
                u4.WalkSpeed = v15
            end
        end
        if v13() == false and (v15 <= u4.WalkSpeed and u3:FindFirstChild("Blocking") == nil) then
            if u4.FloorMaterial == Enum.Material.Air or u4.MoveDirection == Vector3.new(0, 0, 0) then
                u11 = u5.TimePosition
                u5:Stop()
            elseif u5.IsPlaying == false then
                u5:Play()
                u5:AdjustSpeed(2)
                u5.TimePosition = u11
            end
        else
            u11 = u5.TimePosition
            u5:Stop()
        end
        game["Run Service"].Heartbeat:Wait()
        if _G.running == false or p12.HoldingRun == false then
            _G.running = false
            u5:Stop()
            game.ReplicatedStorage.Events.sprint:FireServer(u5.Animation.AnimationId)
            if _G.canuse == false then
                repeat
                    task.wait()
                until _G.canuse == true
            end
            u4.WalkSpeed = 16
            return
        end
    end
end
return u1