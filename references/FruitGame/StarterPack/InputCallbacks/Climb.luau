 

local u1 = {}
u1.__index = u1
local u2 = game.Players.LocalPlayer
game:GetService("UserInputService")
local u3 = u2.Character or u2.CharacterAdded:Wait()
local u4 = require(game.ReplicatedStorage.Util.Movement.GpoClimbing)
function u1.new(p5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u3
    --]]
    local v6 = u1
    local v7 = setmetatable({}, v6)
    v7.Handler = p5
    v7.Utils = p5.Utils
    p5.climbCD = false
    v7.ClimbingObject = u4:setup(u3)
    return v7
end
local u8 = RaycastParams.new()
u8.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u8.FilterType = Enum.RaycastFilterType.Include
function u1.PC_Activate(u9) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u8
    --]]
    local v10 = u2.Character
    local _ = v10.Humanoid
    if v10.PrimaryPart == nil then
        return
    else
        local v11 = u9.ClimbingObject
        if u3:GetAttribute("Grounded") == nil and (_G.swimming == false and (_G.check:inspect(u3) == true or v11 and v11.Enabled == true)) and u3:findFirstChild("kenTrain") == nil then
            if _G.canuse == false and v11.Enabled == false then
                return
            elseif u9.climbCD == true then
                return
            elseif game.ReplicatedStorage:FindFirstChild("Matchinfo") and game.ReplicatedStorage.Matchinfo.matchStarted.Value == false then
                return
            elseif u3:GetAttribute("flyMode") then
                return
            else
                local v12 = 2 + u3.PrimaryPart.Size.Y * 2
                local v13 = u3.PrimaryPart.Size.Z
                local v14 = u3.HumanoidRootPart.CFrame * CFrame.new(0, 0, v13)
                if workspace:Raycast(v14.Position, v14.LookVector * (v12 + v13 - 0.5), u8) then
                    if v10:FindFirstChild("ragcarry") == nil and (_G.check:inspect(v10) == false and v11.Enabled == false) then
                        return
                    elseif v11.Enabled == false and v10.PrimaryPart.CollisionGroupId == 1 then
                        return
                    else
                        if v11.Enabled == false then
                            v11.AlreadyStopped = false
                        end
                        if not v11.Enabled == true and (v11.climbingtime < 1 or _G.canuse == false) then
                            return
                        else
                            local v15 = not v11.Enabled
                            warn(v15, v11.Enabled)
                            if v15 == true then
                                if _G.canuse and v11.climbingtime >= 1 then
                                    _G.canuse = false
                                    print("START CLIMBING")
                                    game.ReplicatedStorage.Events.climb:InvokeServer(true)
                                    v11.Enabled = true
                                    v11.AlreadyStopped = false
                                    v11:step()
                                    if v11.Enabled == false then
                                        u9.climbCD = true
                                        task.delay(1, function() --[[ Line: 94 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u9
                                            --]]
                                            u9.climbCD = false
                                        end)
                                    end
                                else
                                    return
                                end
                            else
                                _G.canuse = true
                                v11.Enabled = false
                                v11:stop()
                                u9.climbCD = true
                                task.delay(1, function() --[[ Line: 103 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u9
                                    --]]
                                    u9.climbCD = false
                                end)
                                print("CLIMB STOP")
                                for _, v16 in v10:GetChildren() do
                                    if v16:IsA("BasePart") then
                                        v16.CollisionGroup = "Players"
                                    end
                                end
                                return
                            end
                        end
                    end
                else
                    return
                end
            end
        else
            return
        end
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1