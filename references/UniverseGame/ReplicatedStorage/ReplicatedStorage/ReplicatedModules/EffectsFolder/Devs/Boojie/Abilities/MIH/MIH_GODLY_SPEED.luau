  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local ClientAssets = PathShortcuts.ClientAssets;
local RunService = game:GetService("RunService");

return function(p1) -- Line: 7
    -- upvalues: ClientAssets (copy), GenericModule (copy), RunService (copy)
    local v2 = p1 or {};
    local v3 = v2.Time or 2.5;
    local v4 = v2.Offset or CFrame.new(0, 0, -3.5) * CFrame.Angles(0, 1.5707963267948966, 0);
    local CurrentCamera = workspace.CurrentCamera;
    local v5 = ClientAssets["King Crimson"].GodlySpeed:Clone();
    v5.Parent = CurrentCamera;

    for _, descendant in pairs(v5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    local v6 = os.clock();

    while os.clock() - v6 <= v3 do
        v5.CFrame = CurrentCamera.CFrame * (v4 or CFrame.identity);
        RunService.RenderStepped:Wait();
    end;

    v5:Destroy();
end;