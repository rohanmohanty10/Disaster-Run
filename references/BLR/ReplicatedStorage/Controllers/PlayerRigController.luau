  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = game.Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "PlayerRigController"
});

function v1.KnitStart(p2) -- Line: 12
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Players (copy)
    local u3 = nil;

    if LocalPlayer.UserId < 0 then
        local HumanoidDescription = Instance.new("HumanoidDescription");
        HumanoidDescription.Name = "PlrRig";
        HumanoidDescription.Parent = ReplicatedStorage;
    else
        Players.LocalPlayer.CharacterAppearanceLoaded:Connect(function() -- Line: 19
            -- upvalues: Players (ref), u3 (ref), ReplicatedStorage (ref)
            local Humanoid = Players.LocalPlayer.Character:WaitForChild("Humanoid");

            if u3 then
                u3:Destroy();
            end;

            u3 = Humanoid:GetAppliedDescription();
            u3.Name = "PlrRig";
            u3.Parent = ReplicatedStorage;
        end);

        if Players.LocalPlayer.Character then
            u3 = Players.LocalPlayer.Character:WaitForChild("Humanoid"):GetAppliedDescription();
            u3.Name = "PlrRig";
            u3.Parent = ReplicatedStorage;
        end;
    end;
end;

return v1;