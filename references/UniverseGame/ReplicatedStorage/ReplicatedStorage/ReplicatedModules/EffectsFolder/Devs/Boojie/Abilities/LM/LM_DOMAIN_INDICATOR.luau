  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 9
    -- upvalues: TweenService (copy)
    local v2 = p1.Origin or CFrame.new(0, 0, 0);
    local v3 = p1.Size or 100;
    local v4 = p1.In or 1;
    local v5 = p1.Out or 0.25;
    local v6 = p1.Time or 1;
    local ConfirmTime = p1.ConfirmTime;
    local Part = Instance.new("Part");
    Part.Name = "DomainIndicator";
    Part.Material = Enum.Material.ForceField;
    Part.CanCollide = false;
    Part.CastShadow = false;
    Part.Anchored = true;
    Part.Color = Color3.new(0, 0, 0);
    Part.Size = Vector3.new(v3, v3, v3);
    Part.CFrame = v2;
    local SpecialMesh = Instance.new("SpecialMesh");
    SpecialMesh.Scale = Vector3.new(0, 0, 0);
    SpecialMesh.MeshType = Enum.MeshType.Sphere;
    SpecialMesh.Parent = Part;
    Part.Parent = workspace.Effects;
    TweenService:Create(SpecialMesh, TweenInfo.new(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = Vector3.new(1, 1, 1)
    }):Play();

    if ConfirmTime then
        task.delay(ConfirmTime, function() -- Line: 41
            -- upvalues: TweenService (ref), Part (copy)
            TweenService:Create(Part, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                Color = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    task.wait(v6);
    TweenService:Create(Part, TweenInfo.new(v5, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    task.wait(v5);
    Part:Destroy();
end;