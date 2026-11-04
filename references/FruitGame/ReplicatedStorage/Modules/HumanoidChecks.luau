 

local v1 = {}
local u2 = game:GetService("CollectionService")
local u3 = game:GetService("Players")
local v4 = game:GetService("RunService")
local u5 = game:GetService("Teams")
local u6 = v4:IsServer()
local u7 = not u6
local u8 = workspace:WaitForChild("Ragdolls")
local u9 = workspace:WaitForChild("NPCs")
local u10 = u5:FindFirstChild("Eliminated")
if u10 == nil then
    task.spawn(function() --[[ Line: 14 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u5
        --]]
        u10 = u5:WaitForChild("Eliminated", 120)
    end)
end
local u11 = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("checkCanUse")
local function u15(p12) --[[ Line: 21 ]]
    local v13 = p12:GetChildren()
    for v14 = 1, #v13 do
        if v13[v14]:IsA("ObjectValue") and v13[v14].Name ~= "playerOwner" then
            return true
        end
    end
    return false
end
function v1.inspect(_, p16, p17, p18) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u9
        [3] = u7
        [4] = u2
        [5] = u15
        [6] = u3
        [7] = u10
        [8] = u6
        [9] = u11
    --]]
    if p16 == nil then
        return false
    end
    if _G.mobileButtonsEditting == true then
        return false
    end
    local v19 = p16.Parent
    if v19 == u8 then
        return false
    end
    if p16:GetAttribute("evading") == true then
        return false
    end
    if p16:GetAttribute("gripped") ~= nil then
        return false
    end
    local v20 = p16:FindFirstChild("Humanoid")
    if v20 == nil then
        return false
    end
    local v21 = v20.Health
    if v21 <= 0 or v21 ~= v21 then
        return false
    end
    if v20:GetAttribute("isRagdolled") then
        return false
    end
    if v20.Sit == true and v19 ~= u9 then
        return false
    end
    if p16:FindFirstChild("Head") == nil then
        return false
    end
    if p17 == nil then
        if u7 == true and _G.midDash == true then
            return false
        end
        if p16:FindFirstChild("Blocking") and v19 ~= u9 then
            return false
        end
    end
    if p16:FindFirstChild("hyperArmor") ~= nil == false then
        if u2:HasTag(p16, "Stun") or u2:HasTag(p16, "Cuffed") then
            return false
        end
        if u15(p16) then
            return false
        end
    end
    local v22 = u3:GetPlayerFromCharacter(p16)
    if v22 then
        local v23 = v22:FindFirstChild("StunFolder")
        if v23 and #v23:GetChildren() > 0 then
            return false
        end
        if u10 and v22.Team == u10 then
            return false
        end
    end
    local v24 = (p18 ~= nil and u6 and true or false) and (v22 or u3:GetPlayerFromCharacter(p16))
    if not v24 then
        return true
    end
    local v25, v26 = pcall(u11.InvokeClient, u11, v24)
    if v25 then
        v25 = v26 == true
    end
    return v25
end
return v1