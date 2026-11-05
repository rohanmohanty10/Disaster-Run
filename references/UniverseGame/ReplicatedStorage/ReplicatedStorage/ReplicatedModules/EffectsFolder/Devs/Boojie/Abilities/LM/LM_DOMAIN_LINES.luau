  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local RunService = game:GetService("RunService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 8
    -- upvalues: AssetHandler (copy), RunService (copy)
    local v3 = p1 or {};
    local v4 = v3.Time or 2.5;
    local u5 = v3.Offset or CFrame.new(0, 0, -3.5) * CFrame.Angles(0, 1.5707963267948966, 0);
    local CurrentCamera = workspace.CurrentCamera;
    local u6 = AssetHandler.GetAsset("Particles/Domain/Lines", p2):Clone();
    u6.Parent = CurrentCamera;

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.spawn(function() -- Line: 24
        -- upvalues: u6 (copy), CurrentCamera (copy), u5 (copy), RunService (ref)
        os.clock();

        while u6:IsDescendantOf(CurrentCamera) do
            u6.CFrame = CFrame.new(CurrentCamera.CFrame.Position) * u5;
            RunService.RenderStepped:Wait();
        end;
    end);
    task.wait(v4);

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.wait(1.5);
    u6:Destroy();
end;