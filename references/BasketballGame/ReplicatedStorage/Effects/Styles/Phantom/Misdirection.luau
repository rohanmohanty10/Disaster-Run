 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: Players (copy), LocalPlayer (copy), Essentials (copy), RunService (copy)
    local BallController = p1.BallController;
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;

    if not Character:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

    if not PlayerFromCharacter then
        return;
    end;

    Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    local Team = PlayerFromCharacter.Team;
    local Team2 = LocalPlayer.Team;
    local u4 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };
    Essentials:HideCharacter(Character, u4, Team == Team2 and PlayerFromCharacter ~= LocalPlayer);
    local u5 = nil;
    u5 = RunService.Heartbeat:Connect(function() -- Line: 44
        -- upvalues: BallController (copy), Character (copy), u5 (ref), Essentials (ref), u4 (copy)
        if not BallController:CharacterPossessesBall(Character) then
            return;
        end;

        u5:Disconnect();
        Essentials:UnhideCharacter(Character, u4);
        Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
    end);
    task.delay(5 - v3, function() -- Line: 53
        -- upvalues: u5 (ref), Essentials (ref), Character (copy), u4 (copy)
        if u5 then
            u5:Disconnect();
        end;

        Essentials:UnhideCharacter(Character, u4);
        Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
    end);
end;