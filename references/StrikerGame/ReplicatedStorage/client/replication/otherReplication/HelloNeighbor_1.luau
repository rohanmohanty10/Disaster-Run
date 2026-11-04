 
 

local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Draw = require(ReplicatedStorage.util.hitbox.Draw);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};

local function hitboxesEnabled() -- Line: 11
    -- upvalues: LocalPlayer (copy)
    local setting = LocalPlayer:FindFirstChild("setting");

    if setting then
        return setting.showHitboxes.Value;
    end;

    return false;
end;

function v1.testerlog(p2: string) -- Line: 20
    warn(p2);
end;

function v1.drawHitbox(...) -- Line: 24
    -- upvalues: Draw (copy)
    Draw(...);
end;

local function VisualConeDebug(p3: boolean, p4, p5: number, p6: number) -- Line: 28
    local v7 = p3 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
    local math_rad_ret = math.rad(p5 * 0.5);
    local Model = Instance.new("Model");

    for i = 0, 18 do
        local v8 = (i / 18 - 0.5) * 2 * math_rad_ret;
        local Unit = (p4.LookVector * math.cos(v8) + p4.RightVector * math.sin(v8)).Unit;
        local Position = p4.Position;
        local v9 = Position + Unit * p6;
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.ForceField;
        Part.Color = v7;
        Part.Size = Vector3.new(0.05, 0.05, (v9 - Position).Magnitude);
        Part.CFrame = CFrame.lookAt(Position, v9) * CFrame.new(0, 0, -Part.Size.Z / 2);
        Part.Parent = Model;
        local _ = i;
    end;

    Model.Parent = workspace.Effects;

    return Model;
end;

function v1.modernHitboxDraw(p10, p11, p12, p13, p14) -- Line: 62
    -- upvalues: LocalPlayer (copy), VisualConeDebug (copy)
    local setting = LocalPlayer:FindFirstChild("setting");
    local v15;

    if setting then
        v15 = setting.showHitboxes.Value;
    else
        v15 = false;
    end;

    if not v15 then
        return;
    end;

    local ID = p10.ID;
    local v16 = workspace.Effects:FindFirstChild(ID);

    if v16 then
        v16:Destroy();
    end;

    local v17 = nil;

    if typeof(p10.FOV) == "number" then
        if p13 == "number" then
            v17 = VisualConeDebug(p14, p12, p10.FOV, p11);
            v17.Name = ID;
        end;
    else
        v17 = Instance.new("Part");
        v17.CFrame = p12;

        if p13 == "Vector3" then
            v17.Size = p11;
            v17.Shape = Enum.PartType.Block;
        else
            v17.Size = Vector3.new(1, 1, 1) * (p11 * 2);
            v17.Shape = Enum.PartType.Ball;
        end;

        v17.Transparency = 0.975;
        v17.Color = p14 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
        v17.Anchored = true;
        v17.CanCollide = false;
        v17.Material = Enum.Material.ForceField;
        v17.CastShadow = false;
        v17.Name = ID;
        v17.Parent = workspace.Effects;
    end;

    if v17 then
        task.delay(0.15, v17.Destroy, v17);
    end;
end;

function v1.oldHitboxDraw(p18) -- Line: 105
    -- upvalues: LocalPlayer (copy), Debris (copy)
    local setting = LocalPlayer:FindFirstChild("setting");
    local v19;

    if setting then
        v19 = setting.showHitboxes.Value;
    else
        v19 = false;
    end;

    if not v19 then
        return;
    end;

    local id = p18.id;
    local v20 = workspace.Effects:FindFirstChild(id);

    if v20 then
        v20:Destroy();
    end;

    local Part = Instance.new("Part");
    Part.Parent = workspace.Effects;
    Part.CFrame = p18.cf;
    local size = p18.size;
    local v21;

    if typeof(p18.size) == "Vector3" then
        v21 = size.Magnitude;
    else
        v21 = size * 2;
    end;

    Part.Size = Vector3.new(1, 1, 1) * v21 * 2;
    Part.Shape = Enum.PartType.Ball;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.ForceField;
    Part.Transparency = 0.975;
    Part.Color = p18.ballOnly and Color3.new(1, 0.666667, 0) or Color3.fromRGB(255, 0, 0);
    Part.Name = id;
    Debris:AddItem(Part, 0.15);
end;

return v1;