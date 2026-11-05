  

 

local Fortune = require(script.FortunesAlgorithm).Fortune;
local DelaunayToVoronoi = require(script.DelaunayToVoronoi).DelaunayToVoronoi;
local PoissonSampling = require(script.PoissonSampling).PoissonSampling;
local WedgePart = Instance.new("WedgePart");
WedgePart.Anchored = true;
WedgePart.TopSurface = Enum.SurfaceType.Smooth;
WedgePart.BottomSurface = Enum.SurfaceType.Smooth;
WedgePart.Massless = true;
WedgePart.CanCollide = false;
WedgePart.CastShadow = false;
WedgePart.CanQuery = false;
WedgePart.CanTouch = false;
WedgePart.Name = "Voronoi_Cache";
local v1 = script.Texture:Clone();
v1.Parent = WedgePart;
v1.Color3 = Color3.fromRGB(1260, 1150, 1850);
v1.Name = "T1";
local u2 = require(script.PartCache).new(WedgePart, 600, workspace.Terrain);
local u3 = require(script.Triangle)(u2);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u4 = {};
u4.__index = u4;
u4._Points = {};
u4._Shape = {};
local u5 = _G.Petal("Util");

local function PointToVector3(p6) -- Line: 44
    return vector.create(p6.X, 0, p6.Y);
end;

local function Vector3ToPoint(p7) -- Line: 48
    return Vector2.new(p7.X, p7.Z);
end;

local u8 = Random.new();
local u9 = {
    Color3.fromHSV(0.692861, 0.378378, 0.72549),
    Color3.fromHSV(0.60775, 0.535134, 0.72549),
    Color3.fromHSV(0.64175, 0.470268, 0.72549),
    Color3.fromHSV(0.474361, 0.351354, 0.72549)
};
local Neon = Enum.Material.Neon;

local function DrawPolygon(p10, p11, p12, p13) -- Line: 61
    -- upvalues: u9 (copy), u3 (copy), Neon (copy), u8 (copy)
    local v14 = u9[math.random(1, #u9)];
    local v15 = {};

    for i = 2, p13 - 1 do
        local v16 = p10[1];
        local v17 = vector.create(v16.X, 0, v16.Y) + Vector3.new(0, 1, 0) * p12.Y;
        local v18 = p10[i];
        local v19 = vector.create(v18.X, 0, v18.Y) + Vector3.new(0, 1, 0) * p12.Y;
        local v20 = p10[i + 1];
        local v21, v22, v23, v24 = u3(v17, v19, vector.create(v20.X, 0, v20.Y) + Vector3.new(0, 1, 0) * p12.Y, p11);
        v21.Color = v14;
        v22.Color = v14;
        v21.Material = Neon;
        v22.Material = Neon;
        v21.Size = v21.Size * 0.992;
        v22.Size = v22.Size * 0.992;
        v21.Transparency = 1;
        v22.Transparency = 1;
        table.insert(v15, v21);
        table.insert(v15, v22);
        local v25 = workspace;
        local v26 = {};
        local Angles = CFrame.Angles;
        local v27 = u8:NextNumber(-6, 6);
        local v28 = math.rad(v27);
        local v29 = u8:NextNumber(-6, 6);
        v26[1], v26[2] = v23 * Angles(v28, 0, (math.rad(v29))), v24;
        v25:BulkMoveTo({ v21, v22 }, v26, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    return v15;
end;

function CalculateMidpointPolygon(p30)
    local v31 = #p30;
    local v32 = 0;
    local v33 = 0;

    for i = 1, v31 do
        v32 = v32 + p30[i].X;
        v33 = v33 + p30[i].Y;
    end;

    return vector.create(v32 / v31, 0, v33 / v31);
end;

local u34 = RaycastParams.new();
u34.FilterType = Enum.RaycastFilterType.Include;
u34.FilterDescendantsInstances = { workspace.Map };

local function RaycastMap(p35, p36, p37) -- Line: 111
    -- upvalues: u34 (copy)
    local v38 = workspace:Raycast(p35, p36, u34);

    if p37 then
        return v38;
    end;

    if v38 then
        return v38.Position;
    end;
end;

function u4.Draw(p39, p40) -- Line: 120
    -- upvalues: Fortune (copy), DelaunayToVoronoi (copy), u34 (copy), DrawPolygon (copy), u8 (copy), u5 (copy)
    local Model = Instance.new("Model");
    Model.Name = "VoronoiGrid";
    local v41 = Fortune(p39._Points);
    local v42 = DelaunayToVoronoi(v41);
    Model.Parent = workspace.Effects;
    p39._Model = Model;
    local Highlight = Instance.new("Highlight");
    Highlight.Parent = Model;
    Highlight.FillTransparency = 1;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    local v43 = p40.TotalSize or 95;
    local u44 = p40.TimeScale or 1;
    local _Center = p39._Center;

    for i = 1, #v42 do
        local v45 = v42[i];
        local v46 = true;
        local v47 = #v45;

        if v47 >= 3 then
            for i2 = 1, v47 do
                local v48 = v45[i2];

                if (vector.create(v48.X, 0, v48.Y) + Vector3.new(0, 1, 0) * _Center.Y - _Center).Magnitude > v43 * 0.51 then
                    v46 = false;
                    break;
                end;
            end;

            if v46 then
                local v49 = CalculateMidpointPolygon(v45) + Vector3.new(0, 1, 0) * _Center.Y;
                local Magnitude = (_Center - v49).Magnitude;
                local v50 = workspace:Raycast(v49, Vector3.new(-0, -3.5, -0), u34);
                local v51;

                if v50 then
                    v51 = v50.Position;
                else
                    v51 = nil;
                end;

                if v51 then
                    local u52 = DrawPolygon(v45, Model, p39._Center, v47);
                    local u53 = 0.05 * math.random(10, 25) / 10 / u44;
                    task.delay(math.floor(Magnitude / 15) * 0.8 / u44, function() -- Line: 167
                        -- upvalues: u8 (ref), u44 (copy), u52 (copy), u5 (ref), u53 (copy)
                        if math.random(1, 5) == 5 then
                            task.wait(u8:NextNumber(0.05, 0.25) / u44);
                        end;

                        for i2 = 1, #u52 do
                            u5.Tween(u52[i2], u53, "Quart", "In", {
                                Transparency = 0
                            }).Completed:Once(function() -- Line: 175
                                -- upvalues: u52 (ref), i2 (copy)
                                u52[i2] = nil;
                            end);
                            u5.Tween(u52[i2].T1, u53, "Quart", "In", {
                                Transparency = 0.9
                            });
                        end;
                    end);
                end;
            end;
        end;
    end;

    table.clear(v42);
    table.clear(v41);
end;

function u4.FromPoissonDistribution(p54, p55, p56) -- Line: 190
    -- upvalues: u4 (copy), PoissonSampling (copy)
    local v57 = setmetatable({}, u4);
    v57._Shape = {
        Vector2.new(-0.5, 0.5) * p55,
        Vector2.new(0.5, 0.5) * p55,
        Vector2.new(0.5, -0.5) * p55,
        Vector2.new(-0.5, -0.5) * p55
    };
    v57._Center = p56.Center or Vector3.new(0, 0, 0);
    local v58 = PoissonSampling(Vector2.new(p55, p55), p54);
    local v59 = Vector2.new(-0.5, -0.5) * p55;

    for i = 1, #v58 do
        local _Center = v57._Center;
        v58[i] = Vector2.new(_Center.X, _Center.Z) + v58[i] + v59;
    end;

    v57._Points = v58;

    return v57;
end;

function u4.Destroy(p60) -- Line: 209
    if p60._Model then
        p60._Model:Destroy();
    end;

    table.clear(p60);
    table.freeze(p60);
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p61, p62) -- Line: 220
    -- upvalues: LocalPlayer (copy), u4 (copy), Trove (copy), u2 (copy)
    local v63 = p62 or {};
    debug.setmemorycategory("Voronoi Diagram");
    local v64 = LocalPlayer:DistanceFromCharacter(p61) > 150 and 7.5 or (LocalPlayer:DistanceFromCharacter(p61) > 250 and 8.5 or 6.65);
    debug.profilebegin("Voronoi_Render");
    local u65 = u4.FromPoissonDistribution(v63.DistributionFactor or v64, v63.TotalSize or 95, {
        Center = p61
    });
    u65:Draw(v63);
    debug.profileend();
    local u66 = Trove.new();
    u66:Add(function() -- Line: 244
        -- upvalues: u65 (copy), u2 (ref)
        for _, child in u65._Model:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 1;
                u2:ReturnPart(child);
            end;
        end;

        task.delay(0.25, u65.Destroy, u65);
    end);

    if v63.Reference then
        u66:Connect(v63.Reference.AncestryChanged, function() -- Line: 256
            -- upvalues: u66 (copy)
            u66:Destroy();
        end);

        return;
    end;

    task.delay(3, function() -- Line: 260
        -- upvalues: u66 (copy)
        u66:Destroy();
    end);
end;