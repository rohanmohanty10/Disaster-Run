  

local GamepadService = game:GetService("GamepadService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Tweens);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local v2 = Knit.CreateController({
    Name = "Leaderboard"
});
tick();

function v2.Open(p3) -- Line: 28
    -- upvalues: CollectionService (copy), ReplicatedStorage (copy), LocalPlayer (copy)
    local Players = game.Teams.Visitor:GetPlayers();
    local Tagged = CollectionService:GetTagged("PlayingTeam");
    local Children = ReplicatedStorage.Teams:GetChildren();
    local Descendants = LocalPlayer.PlayerGui.Leaderbord.BG.TeamsList:GetDescendants();

    for _, v in pairs(Descendants) do
        if v:IsA("ImageLabel") ~= false and v.Name == "Plr" then
            v:Destroy();
        end;
    end;

    LocalPlayer.PlayerGui.Leaderbord.BG.Visitors.Plrs.Text = "";

    for _, v in pairs(Players) do
        LocalPlayer.PlayerGui.Leaderbord.BG.Visitors.Plrs.Text = LocalPlayer.PlayerGui.Leaderbord.BG.Visitors.Plrs.Text .. " " .. v.Name;
    end;

    for _, v in Tagged do
        local v4 = v;

        for _, v3 in v:GetPlayers() do
            local v5 = ReplicatedStorage.Assets.UI.Plr:Clone();
            v5.Parent = LocalPlayer.PlayerGui.Leaderbord.BG.TeamsList[v4.Name].StatsList;
            v5.Plr.Text = v3.Name;
            v5.Goals.Text = math.round(v3.GameStats.Goals.Value);
            v5.Assists.Text = math.round(v3.GameStats.Assists.Value);
            v5.Steals.Text = math.round(v3.GameStats.Steals.Value);
            v5.Ping.Text = math.round(v3.GameStats.Ping.Value);
            v5.Saves.Text = math.round(v3.GameStats.Saves.Value);
            v5.Points.Text = math.round(v3.GameStats.Points.Value);

            if v3.GameStats.Ping.Value > 200 then
                v5.PingImg.Image = "rbxassetid://130455564439618";
            else
                v5.PingImg.Image = "rbxassetid://112088789476009";
            end;

            local v6 = v3;

            for _, v7 in Children do
                for _, child in pairs(v7:GetChildren()) do
                    if child.Value == v6 then
                        v5.Pos.Text = child.Name;
                        break;
                    end;
                end;
            end;
        end;
    end;
end;

function v2.KnitStart(u7) -- Line: 80
    -- upvalues: LocalPlayer (copy), UserInputService (copy)
    local Leaderbord = LocalPlayer.PlayerGui:WaitForChild("Leaderbord");
    u7.BaseTrove:Connect(UserInputService.InputBegan, function(p8, p9) -- Line: 83
        -- upvalues: Leaderbord (copy), u7 (copy)
        if p9 then
            return;
        end;

        if p8.KeyCode == Enum.KeyCode.Tab then
            Leaderbord.Enabled = true;
            u7:Open();
        end;
    end);
    u7.BaseTrove:Connect(UserInputService.InputEnded, function(p10, p11) -- Line: 92
        -- upvalues: Leaderbord (copy)
        if p11 then
            return;
        end;

        if p10.KeyCode == Enum.KeyCode.Tab then
            Leaderbord.Enabled = false;
        end;
    end);
end;

function v2.KnitInit(u12) -- Line: 100
    -- upvalues: LocalPlayer (copy), GamepadService (copy), Trove (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    local Leaderbord = LocalPlayer.PlayerGui:WaitForChild("Leaderbord");
    GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(function() -- Line: 103
        -- upvalues: GamepadService (ref), LocalPlayer (ref), u12 (copy), Leaderbord (copy)
        if GamepadService.GamepadCursorEnabled and LocalPlayer.Team ~= game.Teams.Visitor then
            u12:Open();

            return;
        end;

        Leaderbord.Enabled = false;
    end);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 112
        -- upvalues: GamepadService (ref), LocalPlayer (ref), u12 (copy), Leaderbord (copy)
        if GamepadService.GamepadCursorEnabled and LocalPlayer.Team ~= game.Teams.Visitor then
            u12:Open();

            return;
        end;

        Leaderbord.Enabled = false;
    end);
    u12.BaseTrove = Trove.new();
    u12.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p13) -- Line: 123
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
        u1 = p13;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u12.BaseTrove:Connect(game.Players.PlayerRemoving, function(p14) -- Line: 129
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u12 (copy)
        if p14 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u12.BaseTrove:Destroy();
        end;
    end);
end;

return v2;