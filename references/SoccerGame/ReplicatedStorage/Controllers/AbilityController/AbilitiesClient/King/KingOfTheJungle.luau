  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Teams = game:GetService("Teams");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

local function isPointInVolume(p1: vector, p2, p3: vector) -- Line: 22
    local v4 = p2:PointToObjectSpace(p1);
    local v5;

    if v4.X >= -p3.X / 2 and (v4.X <= p3.X / 2 and (v4.Y >= -p3.Y / 2 and (v4.Y <= p3.Y / 2 and v4.Z >= -p3.Z / 2))) then
        v5 = v4.Z <= p3.Z / 2;
    else
        v5 = false;
    end;

    return v5;
end;

local function setCFrameY(p6, p7) -- Line: 32
    return CFrame.new(p6.X, p7, p6.Z) * p6.Rotation;
end;

return function(u8: any, p9: userdata, u10: any) -- Line: 36
    -- upvalues: Teams (copy), isPointInVolume (copy), Popup (copy), TweenService (copy), RunService (copy), ReplicatedStorage (copy)
    local v11 = p9.Team == Teams:FindFirstChild("Home") and "Away" or "Home";
    local v12;

    if u10 then
        v12 = u10:FindFirstChild("HumanoidRootPart");
    else
        v12 = u10;
    end;

    if not (v12 and workspace.CurrentCamera) then
        return;
    end;

    if not u10.Values.HasBall.Value then
        return;
    end;

    if u8.AbilityOne > tick() then
        return;
    end;

    if u8.ABC then
        u8.ABC:Clean();
    end;

    local v13 = false;
    local v14 = workspace.AI:FindFirstChild(v11) and workspace.AI:FindFirstChild(v11):FindFirstChild("GoalBox").CFrame or workspace.AI:FindFirstChild("Keeper") and workspace.AI:FindFirstChild("Keeper").GoalBox.CFrame;
    local v15 = {};
    local v16 = v14 * CFrame.new(0, 0, -120);
    v15[1], v15[2] = CFrame.new(v16.X, 8.186, v16.Z) * v16.Rotation, Vector3.new(200, 1, 90);

    if not isPointInVolume(v12.CFrame.Position, v15[1], v15[2] + Vector3.new(0, 30, 0)) then
        Popup.Popup(p9, "Must be near the goal!");
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.Color = Color3.fromRGB(0, 255, 94);
        Part.Material = Enum.Material.Neon;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CFrame = v15[1];
        Part.Size = v15[2];
        Part.Transparency = 0.9;
        Part.Parent = workspace.Debris;
        TweenService:Create(Part, TweenInfo.new(0.2), {
            Transparency = 1
        });
        task.delay(0.2, Part.Destroy, Part);

        return;
    end;

    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and (v.Character:FindFirstChild("Values") and (v.Team ~= p9.Team and (v.Team.Name ~= "Visitor" and not (v.Character.Values.Goalie.Value or v.Character.Values.IsInPenalty.Value)))) then
            v13 = true;
            break;
        end;
    end;

    if not (v13 or workspace:FindFirstChild("PassRig")) then
        return Popup.Popup(p9, "There must be at least 1 player on the enemy team!");
    end;

    u8.StatesController.States.Ability = true;
    u8.Animations:StopAnims();
    u8.AbilityService.Ability:Fire("KingOfTheJungle");
    u8:AbilityCooldown("1", 50);
    u8.ABC:Add(function() -- Line: 99
        -- upvalues: u8 (copy)
        u8.InAbility = false;
        u8.StatesController.States.Ability = false;
        u8.Camera.Cutscene = false;
    end);
    u8.ABC:Add(task.delay(20, function() -- Line: 104
        -- upvalues: u8 (copy)
        print("cleaned");
        u8.ABC:Clean();
    end));
    local u17 = tick();
    local u18 = nil;
    u18 = u8.ABC:Connect(RunService.Heartbeat, function(p19) -- Line: 111
        -- upvalues: u17 (copy), u18 (ref), u10 (copy), u8 (copy)
        if tick() - u17 < 0.25 then
            return;
        end;

        u18:Disconnect();

        if not u10.Values.HasBall then
            u8.ABC:Clean();
        end;
    end);
    local Shiftlock = u8.Camera.Shiftlock;
    u8.Camera:SetShiftlock(false);
    u8.Camera.Cutscene = true;
    u8.InAbility = true;
    u8.ABC:Connect(u8.AbilityService.Ability, function(p20) -- Line: 131
        -- upvalues: u8 (copy), u10 (copy), ReplicatedStorage (ref), Shiftlock (copy)
        u8.StatesController.States.Ability = false;
        u8.Camera.Cutscene = false;
        p20.AssemblyLinearVelocity = (u10.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.05, 0)) * 300;
        u8.BallController:DragBall(ReplicatedStorage.Football.Value);
        print("dragged ball");
        u8.Camera:SetShiftlock(Shiftlock);
    end);
end;