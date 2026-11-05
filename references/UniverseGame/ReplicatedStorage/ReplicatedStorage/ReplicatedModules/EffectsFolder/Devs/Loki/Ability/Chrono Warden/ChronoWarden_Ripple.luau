  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local _ = Petal("Util").Tween;
local RenderStepped = game:GetService("RunService").RenderStepped;
local _ = Instance.new;
local new = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;
local _ = Color3.fromRGB;

local function Lerp(p2, p3, p4) -- Line: 16
    return p2:Lerp(p3, p4);
end;

local function Quad(p5, p6, p7, p8) -- Line: 21
    -- upvalues: Lerp (copy)
    return Lerp(p5:Lerp(p6, p8), p6:Lerp(p7, p8), p8);
end;

local u9 = RaycastParams.new();
u9.FilterType = Enum.RaycastFilterType.Whitelist;

local function RaycastMap(p10, p11, p12) -- Line: 30
    -- upvalues: u9 (copy)
    u9.FilterDescendantsInstances = { workspace.Map };
    local v13 = workspace:Raycast(p10, p11, u9);

    if p12 then
        return v13;
    end;

    if v13 then
        return v13.Position;
    end;
end;

return function(p14, u15) -- Line: 41
    -- upvalues: Trove (copy), u1 (copy), new (copy), u9 (copy), RenderStepped (copy)
    local u16 = Trove.new();
    local HumanoidRootPart = p14:FindFirstChild("HumanoidRootPart");
    local u17 = u15.GridSize or 10;
    local u18 = u15.CellSize or 5;

    local function CreateGrid() -- Line: 51
        -- upvalues: u17 (copy), u16 (copy), u1 (ref), u15 (copy), HumanoidRootPart (copy), u18 (copy), new (ref), u9 (ref)
        local v19 = table.create(u17, table.create(u17));
        local v20 = u16:Add(u1("Model")({
            Name = "FloorRippleGrid",
            Parent = u15.EffectParent or workspace.Effects
        }));

        for i = 1, u17 do
            for i2 = 1, u17 do
                local v21 = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 1.5;
                local v22 = v21 - new(u18 * u17 / 2 + u18 / 2, 0, u18 * u17 / 2 + u18 / 2) + new(i * u18, 0, i2 * u18);
                local Magnitude = (v21 - v22).Magnitude;
                u9.FilterDescendantsInstances = { workspace.Map };
                local v23 = workspace:Raycast(v22, Vector3.new(0, -5, 0), u9);

                if v23 and (v23.Instance and Magnitude < u18 * u17 / 2) then
                    local v24 = u1("Part")({
                        Anchored = true,
                        CanCollide = false,
                        Name = i .. "|" .. i2
                    });
                    v24.TopSurface = Enum.SurfaceType.SmoothNoOutlines;
                    v24.Size = Vector3.new(1, 1, 1) * u18;
                    v24.Position = v23.Position - new(0, u18 + 1, 0);
                    v24.Parent = v20;
                    v24.Color = v23.Instance.Color;
                    v24.Material = v23.Instance.Material;
                    table.insert(v19, v24);
                end;
            end;
        end;

        return v19, v20;
    end;

    local function GetCellXY(p25, p26, p27) -- Line: 81
        -- upvalues: u17 (copy)
        if p26 >= 0 and (u17 >= p26 and (p27 >= 0 and u17 >= p27)) then
            return p25:FindFirstChild(p26 .. "|" .. p27);
        end;

        warn(p26, p27, "Out of range");
    end;

    local function SpawnRippleAtCell(p28, p29, p30, p31, p32) -- Line: 90
        -- upvalues: u17 (copy), u18 (copy), new (ref), RenderStepped (ref)
        local v33;

        if p30 < 0 or (u17 < p30 or (p31 < 0 or u17 < p31)) then
            warn(p30, p31, "Out of range");
            v33 = nil;
        else
            v33 = p28:FindFirstChild(p30 .. "|" .. p31);
        end;

        if not v33 then
            warn(p30, p31, "Cell not defined");

            return;
        end;

        local u34 = p28:GetChildren();
        local v35 = {};

        for i = 1, p32 do
            local v36 = (u18 + 0.1) * i;

            for i2 = 1, #u34 do
                local Magnitude = (v33.Position - u34[i2].Position).Magnitude;

                if not v35[u34[i2]] and Magnitude <= v36 then
                    task.spawn(function() -- Line: 104
                        -- upvalues: u34 (copy), i2 (copy), i (copy), new (ref), Magnitude (copy), RenderStepped (ref)
                        local Position = u34[i2].Position;
                        local _ = u34[i2].Color;

                        for i3 = 1, 20 do
                            local v37 = Position + new(0, 13.5 - i / 2, 0);

                            if Magnitude < 4 then
                                v37 = v37 - Vector3.new(0, Magnitude * 1.5, 0);
                            end;

                            local v38 = i3 / 20;
                            local v39 = Position:Lerp(v37, v38):Lerp(v37:Lerp(Position, v38), v38);
                            u34[i2].Position = v39;
                            RenderStepped:Wait();
                        end;
                    end);
                    v35[u34[i2]] = true;
                end;
            end;

            RenderStepped:Wait();
            RenderStepped:Wait();
        end;
    end;

    local function SpawnRipple(p40) -- Line: 133
        -- upvalues: CreateGrid (copy), u16 (copy), SpawnRippleAtCell (copy), u17 (copy)
        local u41, v42 = CreateGrid();
        u16:Add(function() -- Line: 135
            -- upvalues: u41 (copy)
            table.clear(u41);
        end);
        SpawnRippleAtCell(v42, u41, u17 / 2, u17 / 2, p40);
    end;

    local v43 = u15.Resonance or 10;
    local u44, v45 = CreateGrid();
    u16:Add(function() -- Line: 135
        -- upvalues: u44 (copy)
        table.clear(u44);
    end);
    SpawnRippleAtCell(v45, u44, u17 / 2, u17 / 2, v43);
    task.delay(5, function() -- Line: 144
        -- upvalues: u16 (copy)
        u16:Destroy();
    end);
end;