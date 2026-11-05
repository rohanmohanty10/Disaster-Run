  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage:FindFirstChild("Client Assets");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2) -- Line: 14
    -- upvalues: AssetHandler (copy), u1 (copy), TweenService (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local Model = v3.Model;
    local Position = v3.Position;
    local v4 = v3.Duration or 1;

    if not Model then
        return;
    end;

    local v5 = AssetHandler.GetAsset(v3.Path or "Particles/ArmBash/WebBeams", v3.AbilityData or AssetHandler.GetAbilityData(Model));
    local Attachment = Instance.new("Attachment");
    Attachment.Position = Vector3.new(0, -1, 0);
    Attachment.Parent = Model:WaitForChild("Left Arm");
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = workspace.Terrain;
    local WorldPosition = Attachment.WorldPosition;
    local v6 = u1:NextNumber(-1.5, 1.5);
    local v7 = u1:NextNumber(0.5, 1.5);
    Attachment2.WorldPosition = WorldPosition + Vector3.new(v6, v7, u1:NextNumber(-1.5, 1.5));
    local v8 = u1:NextNumber(0.25, 0.33);
    TweenService:Create(Attachment2, TweenInfo.new(v8, Enum.EasingStyle.Linear), {
        WorldPosition = Position
    }):Play();
    local v9 = u1:NextNumber(6, 8.5) * (math.random(1, 2) == 1 and 1 or -1);
    local v10 = u1:NextNumber(6, 8.5) * (math.random(1, 2) == 1 and 1 or -1);
    local v11 = ParticleHandler.GetUnusualHSVData({
        Character = Model
    });

    for _, child in v5:GetChildren() do
        local v12 = child:Clone();
        v12.Attachment0 = Attachment;
        v12.Attachment1 = Attachment2;

        if v11 ~= nil then
            ParticleHandler.Unusualify({ v12 }, {
                HSVData = v11
            });
        end;

        v12.Parent = Attachment;
        v12.CurveSize0 = v9;
        v12.CurveSize1 = v10;
        TweenService:Create(v12, TweenInfo.new(v8, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {
            CurveSize0 = 0,
            CurveSize1 = 0
        }):Play();
    end;

    task.delay(v4, function() -- Line: 66
    end);
    task.delay(v4, Attachment.Destroy, Attachment);
    task.delay(v4, Attachment2.Destroy, Attachment2);
end;