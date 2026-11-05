  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 21
    -- upvalues: RunService (copy), Players (copy)
    local v3 = p2 or {};
    local v4 = v3.Speed or 50;
    local v5 = v3.Damping or 8;
    local v6 = v3.TurnIntensity or 1.5;
    local Character = v3.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;

    local function GetDirection() -- Line: 32
        -- upvalues: HumanoidRootPart (copy), RunService (ref), Players (ref)
        local CFrame2 = HumanoidRootPart.CFrame;

        if not RunService:IsClient() then
            return CFrame2.LookVector;
        end;

        local v7 = Players.LocalPlayer:GetMouse();

        return (Vector3.new(v7.Hit.Position.X, CFrame2.Position.Y, v7.Hit.Position.Z) - CFrame2.Position).Unit;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(1000000, 0, 1000000);
    local CFrame2 = HumanoidRootPart.CFrame;
    local v8;

    if RunService:IsClient() then
        local v9 = Players.LocalPlayer:GetMouse();
        v8 = (Vector3.new(v9.Hit.Position.X, CFrame2.Position.Y, v9.Hit.Position.Z) - CFrame2.Position).Unit;
    else
        v8 = CFrame2.LookVector;
    end;

    BodyVelocity.Velocity = v8 * v4;
    BodyVelocity.Parent = HumanoidRootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.MaxTorque = Vector3.new(1000000, 1000000, 1000000);
    BodyGyro.P = 3000;
    BodyGyro.D = 150;
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.Parent = HumanoidRootPart;
    local CFrame3 = HumanoidRootPart.CFrame;
    local v10;

    if RunService:IsClient() then
        local v11 = Players.LocalPlayer:GetMouse();
        v10 = (Vector3.new(v11.Hit.Position.X, CFrame3.Position.Y, v11.Hit.Position.Z) - CFrame3.Position).Unit;
    else
        v10 = CFrame3.LookVector;
    end;

    local v12 = 0;

    while Character and (Character:IsDescendantOf(game) and Character:GetAttribute("WaterWheel")) do
        local v13 = task.wait();
        local CFrame4 = HumanoidRootPart.CFrame;
        local v14;

        if RunService:IsClient() then
            local v15 = Players.LocalPlayer:GetMouse();
            v14 = (Vector3.new(v15.Hit.Position.X, CFrame4.Position.Y, v15.Hit.Position.Z) - CFrame4.Position).Unit;
        else
            v14 = CFrame4.LookVector;
        end;

        local v16 = v5 * v13;
        local Y = v10:Cross(v14).Y;
        v10 = v10:Lerp(v14, v16);
        v12 = v12 + (Y * v6 - v12) * v16;
        BodyGyro.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + v14) * CFrame.Angles(0, 0, -v12);
        BodyVelocity.Velocity = BodyGyro.CFrame.LookVector * Vector3.new(1, 0, 1) * v4;
    end;

    BodyVelocity:Destroy();
    BodyGyro:Destroy();
end;