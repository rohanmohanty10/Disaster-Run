  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = HumanoidRootPart:WaitForChild("RootJoint").C0;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local v3 = Knit.CreateController({
    Name = "PlrStats"
});

function v3.KnitStart(p4) -- Line: 21
    -- upvalues: LocalPlayer (copy), Players (copy), ReplicatedStorage (copy)
    local PlrStats = LocalPlayer.PlayerGui:WaitForChild("PlrStats");
    PlrStats:WaitForChild("BG"):WaitForChild("Profile"):WaitForChild("PlayerProfile").Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420);
    PlrStats.BG.Profile.PlayerName.Text = LocalPlayer.DisplayName;
    local u5 = ReplicatedStorage.Data:InvokeServer("GameStats");

    if u5 then
        for i, v in pairs(u5) do
            local v6 = ReplicatedStorage.Assets.UI.Stat:Clone();
            v6.Title.Text = i;
            v6.Val.Text = tostring(v);
            v6.Parent = PlrStats:WaitForChild("BG"):WaitForChild("Stats");
        end;
    end;

    p4.BaseTrove:Connect(PlrStats:GetPropertyChangedSignal("Enabled"), function() -- Line: 38
        -- upvalues: PlrStats (copy), u5 (ref), ReplicatedStorage (ref)
        if PlrStats.Enabled then
            if u5 then
                table.clear(u5);
            end;

            local Children = PlrStats.BG.Stats:GetChildren();

            for _, v in pairs(Children) do
                if v:IsA("Frame") ~= false then
                    v:Destroy();
                end;
            end;

            u5 = ReplicatedStorage.Data:InvokeServer("GameStats");

            for i, v in pairs(u5) do
                local v7 = ReplicatedStorage.Assets.UI.Stat:Clone();
                v7.Title.Text = i;
                v7.Val.Text = tostring(v);
                v7.Parent = PlrStats:WaitForChild("BG"):WaitForChild("Stats");
            end;

            if u5.MatchesPlayed < 1 then
                u5.MatchesPlayed = 1;
            end;

            local v8 = 50 + math.round(u5.Goals / 4 / (u5.MatchesPlayed / 60 + 1) + u5.Assists / 7 / (u5.MatchesPlayed / 60 + 1) + u5.Steals / 20 / (u5.MatchesPlayed / 60 + 1) + u5.AnkleBreakers / 15 / (u5.MatchesPlayed / 60 + 1) + u5.Saves / 15 / (u5.MatchesPlayed / 60 + 1));
            PlrStats.BG.Rank.Val.Text = v8;
            table.clear(u5);
            table.clear(Children);
        end;
    end);
end;

function v3.KnitInit(u9) -- Line: 76
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    u9.BaseTrove = Trove.new();
    u9.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p10) -- Line: 79
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p10;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u9.BaseTrove:Connect(game.Players.PlayerRemoving, function(p11) -- Line: 85
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u9 (copy)
        if p11 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u9.BaseTrove:Destroy();
        end;
    end);
end;

return v3;