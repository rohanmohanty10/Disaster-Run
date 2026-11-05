  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FXHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = Random.new();

return function(p2) -- Line: 13
    -- upvalues: FXHandler (copy), Trove (copy), u1 (copy), TweenService (copy)
    local Origin = p2.Origin;

    if Origin == nil then
        return;
    end;

    local v3 = p2.Radius or 20;
    local v4 = p2.Size or Vector3.new(2, 2, 2);

    if typeof(v4) == "number" then
        v4 = Vector3.new(1, 1, 1) * v4;
    end;

    local v5 = p2.DelayAmount or 0.05;

    if typeof(Origin) == "Instance" then
        Origin = Origin.CFrame;
    end;

    if p2.Offset then
        Origin = Origin * p2.Offset;
    end;

    local v6 = FXHandler.ScaleQuality(p2.Amount or 30);
    local v7 = p2.Lifetime or 3;
    local v8 = 30;
    local v9 = 360 / v6;
    local v10 = RaycastParams.new();
    v10.FilterType = Enum.RaycastFilterType.Include;
    v10.FilterDescendantsInstances = { workspace.Map };
    local v11 = Trove.new();

    if typeof(p2.AttachTo) == "Instance" then
        p2.BypassDuration = true;
        v11:AttachToInstance(p2.AttachTo);
    end;

    if not p2.BypassDuration then
        task.delay(v7 + v5 * v6 + 0.5, v11.Destroy, v11);
    end;

    local v12 = {};

    for i = 1, v6 do
        local v13 = Origin * CFrame.fromEulerAnglesXYZ(0, math.rad(v8), 0) * CFrame.new(v3 / 2 + v3 / 2.7, 10, 0);
        local v14 = Origin * CFrame.fromEulerAnglesXYZ(0, math.rad(v8), 0) * CFrame.new(v3 / 2 + v3 / 10, 10, 0);
        local v15 = workspace:Raycast(v13.Position, Vector3.new(0, -20, 0), v10);
        local v16 = workspace:Raycast(v14.Position, Vector3.new(0, -20, 0), v10);

        if v15 and v16 then
            table.insert(v12, { i, v15, v16 });
        end;

        v8 = v8 + v9;
    end;

    for _, v in v12 do
        local v17 = v[1];
        local v18 = v[2];
        local v19 = v[3];
        local u20 = {};
        local v21 = v11:Construct(Instance, "Part");
        v21.Anchored = true;
        v21.CanCollide = false;
        v21.CanTouch = false;
        v21.Material = v18.Material;
        v21.Color = v18.Instance.Color;
        v21.CFrame = CFrame.lookAt(v18.Position - Vector3.new(0, 0.5, 0), Origin.Position) * CFrame.fromEulerAnglesXYZ(u1:NextNumber(-0.25, 0.5), u1:NextNumber(-0.25, 0.25), u1:NextNumber(-0.25, 0.25));
        v21.Size = Vector3.new(v4.X * 1.3, v4.Y / 1.4, v4.Z * 1.3) * u1:NextNumber(1, 1.5);
        v21.BottomSurface = Enum.SurfaceType.Smooth;
        v21.TopSurface = Enum.SurfaceType.Smooth;
        v21.Parent = workspace.Effects;
        table.insert(u20, v21);
        local v22 = v11:Clone(v21);
        v22.Size = Vector3.new(v21.Size.X * 1.01, v21.Size.Y * 0.25, v21.Size.Z * 1.01);
        v22.CFrame = v21.CFrame * CFrame.new(0, v21.Size.Y / 2 - v22.Size.Y / 2.1, 0);
        v22.Parent = workspace.Effects;
        table.insert(u20, v22);
        local v23 = v11:Clone(v21);
        v23.CFrame = CFrame.lookAt(v19.Position - Vector3.new(0, v4.Y * 0.4, 0), Origin.Position) * CFrame.fromEulerAnglesXYZ(u1:NextNumber(-1, -0.3), u1:NextNumber(-0.15, 0.15), u1:NextNumber(-0.15, 0.15));
        v23.Parent = workspace.Effects;
        table.insert(u20, v23);
        local v24 = v11:Clone(v22);
        v24.CFrame = v23.CFrame * CFrame.new(0, v23.Size.Y / 2 - v24.Size.Y / 2.1, 0);
        v24.Parent = workspace.Effects;
        table.insert(u20, v24);

        for _, child in pairs(v18.Instance:GetChildren()) do
            if child:IsA("Decal") then
                for _, v2 in pairs(u20) do
                    local child = Instance.fromExisting(child);
                    child.Parent = v2;
                end;
            end;
        end;

        if not p2.BypassDuration then
            task.delay(v7 + v17 * v5, function() -- Line: 122
                -- upvalues: u20 (copy), TweenService (ref)
                for _, v2 in pairs(u20) do
                    TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = Vector3.new(0, 0, 0),
                        Position = v2.CFrame.Position - Vector3.new(0, v2.Size.Y + 2, 0)
                    }):Play();
                end;
            end);
        end;
    end;
end;