 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);

return function(p1, p2) -- Line: 8
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    for _, v in Players:GetPlayers() do
        if v.Character ~= nil and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.ScoreTeam and v.Team ~= game.Teams.Visitor)) then
            local Character = v.Character;
            local HumanoidRootPart = v.Character.HumanoidRootPart;
            Character.IsRagdoll.Value = true;
            task.delay(1.8, function() -- Line: 18
                -- upvalues: Character (copy)
                Character.IsRagdoll.Value = false;
            end);
            task.wait(0.01);
            HumanoidRootPart.AssemblyLinearVelocity = ((HumanoidRootPart.Position - p2.CFrame.Position).Unit + Vector3.new(0, 0.75, 0)) * 220;
        end;
    end;

    ReplicatedStorage.Remotes.GoalEffect:FireAllClients(ReplicatedStorage.Effects.GoalEffects.Client.SLASH, {
        Vfx = p2.Vfx,
        CFrame = p2.CFrame
    });
end;