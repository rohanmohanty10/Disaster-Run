  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("Players");
local LocalPlayer = game.Players.LocalPlayer;
local environment = require(ReplicatedStorage.Shared.environment);
local v1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = "AntiLeakController"
});
local u2 = { "shutupidkaname", "james_taym", 2333758830, 2397012770, 2299856346, 4606431104, 372370262, 1507524939, 7050245799 };

function v1.KnitStart(p3) -- Line: 28
    -- upvalues: ReplicatedStorage (copy), environment (copy), RunService (copy), u2 (copy), LocalPlayer (copy)
    local PlayerNameLeak = ReplicatedStorage.Assets.UI.PlayerNameLeak;

    if environment.env == "Dev" and not RunService:IsStudio() then
        local u4 = nil;

        if (table.find(u2, LocalPlayer.Name) or table.find(u2, LocalPlayer.UserId) or pcall(function() -- Line: 38
            -- upvalues: u4 (ref), LocalPlayer (ref)
            u4 = LocalPlayer:GetRankInGroup(34671275);
        end)) and u4 >= 80 then
            return;
        end;

        for i = 1, 200 do
            local v5 = PlayerNameLeak:Clone();
            v5.Text = LocalPlayer.Name;
            v5.Parent = LocalPlayer.PlayerGui.AntiLeak;
            local _ = i;
        end;

        LocalPlayer.PlayerGui.AntiLeak.Enabled = true;
    end;
end;

return v1;