 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 20, Name: Drive100
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), ReplicatedStorage (copy), Essentials (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.CameraController;

    if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) < 145 then
        u5:ResetCD(4);
        Effects:Popup("Only usable from other side of the court.");

        return;
    end;

    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    Effects:Popup("MOVE AROUND TO SELECT DIRECTION!", 4, Color3.new(1, 1, 1), UDim2.new(0.7, 0, 0.4, 0));
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u5.AC:Add(task.delay(8, function() -- Line: 39
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end));
    u1.Ability:Fire("Drive100", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u3:StopAll();

    local function returnRandom() -- Line: 48
        return math.random(1, 2) == 1 and "R" or "L";
    end;

    local function returnTotal() -- Line: 51
        local v6 = "";

        for i = 1, math.random(1, 2) do
            v6 = v6 .. (math.random(1, 2) == 1 and "R" or "L");
            local _ = i;
        end;
    end;

    u5.AC:Connect(u1.Ability, function(p7, p8) -- Line: 58
        -- upvalues: u5 (copy), u2 (ref), Character (copy), ReplicatedStorage (ref), Essentials (ref), u3 (ref), TweenService (ref), HumanoidRootPart (copy)
        u5.AC:Clean();
        u2.States.Ability = true;
        local v9 = Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Movement.RunF);
        v9.Priority = Enum.AnimationPriority.Action2;
        v9:Play();

        for i = 1, Essentials:TableLength(p7) do
            u2.States.Ability = true;
            local v10 = p7[i][2] and "R" or "L";
            local v11 = `{v10}{v10}{math.random(1, 2) == 1 and "R" or "L"}{math.random(1, 2) == 1 and "R" or "L"}`;
            u3:StopAll();
            u3:PlayChar(`{v10}DCombo`, v11, Enum.AnimationPriority.Action3);
            u3:PlayBall(`{v10}DCombo`, v11, Enum.AnimationPriority.Action3);
            TweenService:Create(HumanoidRootPart, TweenInfo.new(p7[i][3], Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                CFrame = p7[i][1] * CFrame.new(0, 3, 0)
            }):Play();
            task.wait(p7[i][3]);
            local _ = i;
        end;

        v9:Stop();

        if p8 then
            u2.States.Ability = true;
            u3:StopAll();
            u3:PlayChar("Ace", "DriveDunk100", Enum.AnimationPriority.Action4);
            u3:PlayBall("Ace", "DriveDunk100Ball", Enum.AnimationPriority.Action4);
            task.wait(4);
        end;

        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
end;