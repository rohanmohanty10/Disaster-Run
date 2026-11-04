 

local v1 = {}
local u2 = game.Players.LocalPlayer
function v1.ready(_, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.getEffect == nil or u2 == nil then
        repeat
            task.wait()
        until _G.getEffect ~= nil and game.Players.LocalPlayer
        u2 = game.Players.LocalPlayer
    end
    local v4 = u2.Character
    if p3 == nil then
        if not v4 or (v4.Parent == nil or not v4) then
            v4 = u2.CharacterAdded:Wait()
        end
        u2:GetMouse().TargetFilter = v4
        if v4.Parent == nil or v4:FindFirstChild("Humanoid") == nil then
            repeat
                task.wait()
            until v4:FindFirstChild("Humanoid") or v4.Parent ~= nil
            while v4.Parent == nil do
                u2.Character.AncestryChanged:Wait()
            end
        end
        if u2.Loaded.Value == false then
            repeat
                task.wait()
            until u2.Loaded.Value == true
        end
        repeat
            task.wait()
        until v4.Parent == workspace.PlayerCharacters or v4.Parent == workspace.Ragdolls and _G.tween ~= nil
        local v5 = v4:WaitForChild("Humanoid")
        v5:WaitForChild("Animator")
        repeat
            task.wait()
        until v5:GetAttribute("AnimatorReady") ~= nil
        u2:WaitForChild("CrewPVP")
        workspace:WaitForChild("Env"):WaitForChild("WaterStuff")
    end
    local v6 = game.ReplicatedStorage:WaitForChild("Stats" .. u2.Name, 300)
    return u2, v4, game:GetService("UserInputService"), u2:GetMouse(), v6
end
return v1