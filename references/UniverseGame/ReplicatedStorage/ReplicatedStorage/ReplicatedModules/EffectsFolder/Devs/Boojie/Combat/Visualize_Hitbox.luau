  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);

return function(p1, p2, p3) -- Line: 4
    local Part = Instance.new("Part");
    task.delay(1, Part.Destroy, Part);

    if typeof(p1) == "Vector3" then
        p1 = CFrame.new(p1) or p1;
    end;

    Part.CFrame = p1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Color = p3 and Color3.new(0.25, 0.8, 0.25) or Color3.new(1, 0, 0);
    Part.Material = "ForceField";
    Part.CastShadow = false;

    if typeof(p2) == "number" then
        Part.Shape = Enum.PartType.Ball;
        Part.Size = Vector3.new(p2, p2, p2) * 2;
    elseif typeof(p2) == "Vector3" then
        Part.Size = p2;
    end;

    task.delay(0.2, Part.Destroy, Part);
    Part.Parent = workspace.Effects;
end;