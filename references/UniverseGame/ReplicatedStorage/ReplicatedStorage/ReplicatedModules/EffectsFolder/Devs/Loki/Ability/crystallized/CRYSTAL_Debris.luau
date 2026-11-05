  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FXHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.IgnoreWater = true;
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
u2.CollisionGroup = "Map";

function RaycastMap(p3, p4)
    -- upvalues: u2 (copy)
    return workspace:Raycast(p3, p4, u2);
end;

return function(p5) -- Line: 28
    -- upvalues: FXHandler (copy), Trove (copy), Fusion (copy), u1 (copy), TweenService (copy)
    local Origin = p5.Origin;

    if Origin == nil then
        return;
    end;

    local u6 = p5.Radius or 20;
    local v7 = p5.Size or Vector3.new(2, 2, 2);
    local v8 = p5.SpawnSpeed or 1;

    if typeof(v7) == "number" then
        v7 = Vector3.new(1, 1, 1) * v7;
    end;

    local u9 = p5.DelayAmount or 0.05;

    if typeof(Origin) == "Instance" then
        Origin = Origin.CFrame;
    end;

    if p5.Offset then
        Origin = Origin * p5.Offset;
    end;

    local u10 = FXHandler.ScaleQuality(p5.Amount or 30);
    local v11 = p5.Lifetime or 3;
    local v12 = 30;
    local v13 = 360 / u10;
    local v14 = Trove.new();

    if typeof(p5.AttachTo) == "Instance" then
        p5.BypassDuration = true;
        v14:AttachToInstance(p5.AttachTo);
    end;

    if not p5.BypassDuration then
        task.delay(v11 + u9 * u10 + 0.5, v14.Destroy, v14);
    end;

    local v15 = {};

    for i = 1, u10 do
        local v16 = Origin * CFrame.fromEulerAnglesXYZ(0, math.rad(v12), 0) * CFrame.new(u6 / 2 + u6 / 2.7, 10, 0);
        local v17 = Origin * CFrame.fromEulerAnglesXYZ(0, math.rad(v12), 0) * CFrame.new(u6 / 2 + u6 / 10, 10, 0);
        local v18 = RaycastMap(v16.Position, Vector3.new(0, -12, 0));
        local v19 = RaycastMap(v17.Position, Vector3.new(0, -12, 0));

        if v18 and v19 then
            table.insert(v15, { i, v18, v19 });
        end;

        v12 = v12 + v13;
    end;

    for _, v in v15 do
        local v20 = v[1];
        local v21 = v[2];
        local v22 = v[3];
        local u23 = {};
        local v24 = Fusion.New("Part")({
            Anchored = true,
            CanCollide = false,
            CanTouch = false,
            CanQuery = false,
            CastShadow = false,
            TopSurface = Enum.SurfaceType.SmoothNoOutlines,
            BottomSurface = Enum.SurfaceType.SmoothNoOutlines,
            Material = v21.Instance.Material,
            Color = v21.Instance.Color
        });
        local v25 = Vector3.new(v7.X * 1.3, v7.Y / 1.4, v7.Z * 1.3) * u1:NextNumber(1, 1.5);
        local v26 = Vector3.new(v24.Size.X * 1.01, v24.Size.Y * 0.25, v24.Size.Z * 1.01);
        v24.CFrame = CFrame.lookAt(v21.Position - Vector3.new(0, 0.5, 0), Origin.Position) * CFrame.fromEulerAnglesXYZ(u1:NextNumber(-0.25, 0.5), u1:NextNumber(-0.25, 0.25), u1:NextNumber(-0.25, 0.25));
        v24.Size = Vector3.new(0, 0, 0);
        v24.Parent = workspace.Effects;
        table.insert(u23, v24);
        local v27 = Instance.fromExisting(v24);
        v27.Size = Vector3.new(0, 0, 0);
        v27.CFrame = v24.CFrame * CFrame.new(0, v24.Size.Y / 2 - v26.Y / 2.1, 0);
        v27.Parent = workspace.Effects;
        table.insert(u23, v27);
        local v28 = Instance.fromExisting(v24);
        v28.CFrame = CFrame.lookAt(v22.Position - Vector3.new(0, v7.Y * 0.4, 0), Origin.Position) * CFrame.fromEulerAnglesXYZ(u1:NextNumber(-1, -0.3), u1:NextNumber(-0.15, 0.15), u1:NextNumber(-0.15, 0.15));
        v28.Parent = workspace.Effects;
        table.insert(u23, v28);
        TweenService:Create(v24, TweenInfo.new(0.325 / v8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = v25
        }):Play();
        TweenService:Create(v27, TweenInfo.new(0.4 / v8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = v26
        }):Play();
        TweenService:Create(v28, TweenInfo.new(0.35 / v8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = v25
        }):Play();
        v14:Add(v24);
        v14:Add(v27);
        v14:Add(v28);

        for _, child in pairs(v21.Instance:GetChildren()) do
            if child:IsA("Decal") then
                for _, v2 in pairs(u23) do
                    local child = Instance.fromExisting(child);
                    child.Parent = v2;
                end;
            end;
        end;

        if not p5.BypassDuration then
            local _ = v20 * u9;
            task.delay(v11, function() -- Line: 163
                -- upvalues: u23 (copy), u9 (copy), u10 (ref), u1 (ref), TweenService (ref), Origin (ref), u6 (copy)
                for _, v2 in u23 do
                    local v29 = u9 * u10 * u1:NextNumber(0.95, 1.25);
                    local v30, v31, v32 = v2.CFrame:ToEulerAnglesXYZ();
                    local v33 = TweenInfo.new(v29, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                    local v34 = {
                        Transparency = 1
                    };
                    local v35 = CFrame.new(v2.CFrame.Position - Vector3.new(0, v2.Size.Y / 2.25, 0) - (v2.Position * Vector3.new(1, 0, 1) - Origin.Position * Vector3.new(1, 0, 1)).Unit * u6 / 2) * CFrame.fromEulerAnglesXYZ(v30, v31, v32);
                    local Angles = CFrame.Angles;
                    local v36 = u1:NextNumber(-8, 8);
                    local v37 = math.rad(v36);
                    local v38 = u1:NextNumber(-6, 6);
                    local v39 = math.rad(v38);
                    local v40 = u1:NextNumber(-8, 8);
                    v34.CFrame = v35 * Angles(v37, v39, (math.rad(v40)));
                    v34.Size = v2.Size / 1.5;
                    TweenService:Create(v2, v33, v34):Play();

                    for _, child in v2:GetChildren() do
                        if child:IsA("Decal") then
                            TweenService:Create(child, TweenInfo.new(v29 * 0.95, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end;
            end);
        end;
    end;
end;