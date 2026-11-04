  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.SoundManager);
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "BrazilMusicController"
});

function v1.KnitStart(p2) -- Line: 13
    -- upvalues: Knit (copy), LocalPlayer (copy), ReplicatedStorage (copy)
    local Service = Knit.GetService("GlobalService");

    if not LocalPlayer.Character then
        return;
    end;

    Service.PlayMusic:Connect(function() -- Line: 18
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref)
        game.SoundService:WaitForChild("SoundGroup"):WaitForChild("OST").Volume = 0;
        print("Playing brazil ost");
        ReplicatedStorage.Assets.Sfx.BrazilMapOst:Play();
        task.delay(100, function() -- Line: 23
            -- upvalues: LocalPlayer (ref)
            if LocalPlayer.Team == game.Teams.Visitor then
                game.SoundService:WaitForChild("SoundGroup"):WaitForChild("OST").Volume = 0.35;
            end;
        end);
    end);
end;

return v1;