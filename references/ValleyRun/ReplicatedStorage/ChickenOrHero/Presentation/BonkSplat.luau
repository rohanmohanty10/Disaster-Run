 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("ContentProvider");
local LocalLooks = require(script.Parent:WaitForChild("LocalLooks"));
local u1 = {
    Image = "rbxassetid://6564835070",
    BonkSeconds = 0.2,
    BonkSize = 5.5,
    FallTimeout = 0.6,
    Squash = 0.08,
    Flat = 4,
    Pop = 0.28,
    Range = 250
};
local ParticleEmitter = Instance.new("ParticleEmitter");
ParticleEmitter.Name = "Bonk";
ParticleEmitter.Texture = u1.Image;
ParticleEmitter.Rate = 0;
ParticleEmitter.Lifetime = NumberRange.new(u1.BonkSeconds);
ParticleEmitter.Speed = NumberRange.new(0);
ParticleEmitter.Rotation = NumberRange.new(0);
ParticleEmitter.RotSpeed = NumberRange.new(0);
ParticleEmitter.LightEmission = 0;
ParticleEmitter.LightInfluence = 0;
ParticleEmitter.ZOffset = 2;
ParticleEmitter.LockedToPart = true;
local v2 = {};

for _, v in { 0, 0.1, 0.2, 0.35, 0.5, 0.7, 1 } do
    table.insert(v2, NumberSequenceKeypoint.new(v, u1.BonkSize * (0.12 + 0.88 * (1 - (1 - v) ^ 3))));
end;

ParticleEmitter.Size = NumberSequence.new(v2);
ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8, 0), NumberSequenceKeypoint.new(1, 1) });
local u3 = {};
local u4 = nil;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;

local function smooth(p5) -- Line: 64
    local math_clamp_ret = math.clamp(p5, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

local function backOut(p6) -- Line: 69
    local v7 = math.clamp(p6, 0, 1) - 1;

    return 1 + 2.9 * v7 * v7 * v7 + 1.9 * v7 * v7;
end;

local function floorUnder(p8, p9) -- Line: 75
    -- upvalues: Players (copy), RaycastParams_new_ret (copy)
    local v10 = { workspace.CurrentCamera, p9 };

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v10, v.Character);
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v10;
    local v11 = workspace:Raycast(p8 + Vector3.new(0, 2, 0), Vector3.new(-0, -14, -0), RaycastParams_new_ret);

    return v11 and v11.Position.Y or p8.Y - 0.6;
end;

local function upright(p12) -- Line: 88
    local math_abs_ret = math.abs(p12.XVector.Y);
    local math_abs_ret2 = math.abs(p12.YVector.Y);
    local math_abs_ret3 = math.abs(p12.ZVector.Y);

    return math_abs_ret <= math_abs_ret2 and math_abs_ret3 <= math_abs_ret2 and 2 or (math_abs_ret3 <= math_abs_ret and 1 or 3);
end;

local function laid(p13, p14) -- Line: 97
    local function level(p15) -- Line: 98
        return Vector3.new(p15.X, 0, p15.Z).Unit;
    end;

    if p14 == 2 then
        local XVector = p13.XVector;

        return CFrame.fromMatrix(Vector3.new(0, 0, 0), Vector3.new(XVector.X, 0, XVector.Z).Unit, p13.YVector.Y >= 0 and Vector3.new(0, 1, 0) or Vector3.new(-0, -1, -0));
    end;

    if p14 == 1 then
        local YVector = p13.YVector;

        return CFrame.fromMatrix(Vector3.new(0, 0, 0), p13.XVector.Y >= 0 and Vector3.new(0, 1, 0) or Vector3.new(-0, -1, -0), Vector3.new(YVector.X, 0, YVector.Z).Unit);
    end;

    local v16 = p13.ZVector.Y >= 0 and Vector3.new(0, 1, 0) or Vector3.new(-0, -1, -0);
    local XVector = p13.XVector;
    local Unit = Vector3.new(XVector.X, 0, XVector.Z).Unit;

    return CFrame.fromMatrix(Vector3.new(0, 0, 0), Unit, v16:Cross(Unit), v16);
end;

local function copyOf(p17) -- Line: 112
    local v18 = {};

    for _, descendant in p17:GetDescendants() do
        if descendant:IsA("BasePart") and (descendant.Transparency < 1 and descendant.Name ~= "HumanoidRootPart") then
            table.insert(v18, descendant);
            descendant:SetAttribute("BonkSplatPart", #v18);
        end;
    end;

    local Archivable = p17.Archivable;
    p17.Archivable = true;
    local success, result = pcall(p17.Clone, p17);
    p17.Archivable = Archivable;

    for _, v in v18 do
        v:SetAttribute("BonkSplatPart", nil);
    end;

    if not (success and result) then
        return nil;
    end;

    for i in result:GetAttributes() do
        result:SetAttribute(i, nil);
    end;

    local v19 = result:FindFirstChildOfClass("Humanoid");

    if v19 then
        v19.RequiresNeck = false;
        v19.BreakJointsOnDeath = false;
        v19.EvaluateStateMachine = false;
        v19.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        v19.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    end;

    local v20 = {
        character = p17,
        copy = result,
        entries = {},
        faces = {},
        hidden = {}
    };

    for _, descendant in result:GetDescendants() do
        if descendant:IsA("BasePart") then
            local Attribute = descendant:GetAttribute("BonkSplatPart");

            if Attribute and v18[Attribute] then
                descendant:SetAttribute("BonkSplatPart", nil);
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.CastShadow = false;
                descendant.LocalTransparencyModifier = 1;
                local v21 = descendant:FindFirstChildOfClass("SpecialMesh");

                if not (v21 and (v21.MeshType == Enum.MeshType.FileMesh and v21)) then
                    v21 = nil;
                end;

                local entries = v20.entries;
                local v22 = {
                    real = v18[Attribute],
                    part = descendant,
                    mesh = v21
                };
                local v23;

                if v21 then
                    v23 = v21.Scale;
                else
                    v23 = v21;
                end;

                v22.scale = v23;

                if v21 then
                    v21 = v21.Offset;
                end;

                v22.offset = v21;
                table.insert(entries, v22);
            else
                descendant:Destroy();
            end;
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            v20.faces[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        elseif descendant:IsA("Highlight") then
            v20.outline = descendant;
            descendant.Enabled = false;
            descendant.Adornee = result;
        elseif descendant:IsA("JointInstance") or (descendant:IsA("Constraint") or (descendant:IsA("LuaSourceContainer") or (descendant:IsA("Animator") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Light") or (descendant:IsA("LayerCollector") or (descendant:IsA("ForceField") or (descendant:IsA("ProximityPrompt") or descendant:IsA("ClickDetector")))))))))))) then
            descendant:Destroy();
        end;
    end;

    result.Name = "BonkSplat";
    result.Parent = workspace.CurrentCamera;

    return v20;
end;

local function takeOver(p24) -- Line: 199
    -- upvalues: LocalLooks (copy), floorUnder (copy)
    for _, descendant in p24.character:GetDescendants() do
        if descendant:IsA("BasePart") then
            p24.hidden[descendant] = "LocalTransparencyModifier";
            LocalLooks.hold(descendant, "LocalTransparencyModifier", p24);
            descendant.LocalTransparencyModifier = 1;
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            p24.hidden[descendant] = "Transparency";
            LocalLooks.hold(descendant, "Transparency", p24);
            descendant.Transparency = 1;
        elseif descendant:IsA("Highlight") then
            p24.hidden[descendant] = "Enabled";

            if LocalLooks.hold(descendant, "Enabled", p24) then
                p24.realOutline = descendant;
            end;

            descendant.Enabled = false;
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Light"))) then
            p24.hidden[descendant] = "Enabled";
            LocalLooks.hold(descendant, "Enabled", p24);
            descendant.Enabled = false;
        end;
    end;

    for _, v in p24.entries do
        local CFrame2 = v.real.CFrame;
        local math_abs_ret = math.abs(CFrame2.XVector.Y);
        local math_abs_ret2 = math.abs(CFrame2.YVector.Y);
        local math_abs_ret3 = math.abs(CFrame2.ZVector.Y);
        v.axis = math_abs_ret <= math_abs_ret2 and math_abs_ret3 <= math_abs_ret2 and 2 or (math_abs_ret3 <= math_abs_ret and 1 or 3);
        v.part.LocalTransparencyModifier = 0;
    end;

    for i, v in p24.faces do
        i.Transparency = v;
    end;

    if p24.outline then
        p24.outline.Enabled = p24.realOutline ~= nil;
    end;

    local Position = p24.torso.Position;
    local v25 = floorUnder(Position, p24.character);
    local X = Position.X;
    local Z = Position.Z;
    p24.floor = v25;
    p24.floorX = X;
    p24.floorZ = Z;
end;

local function draw(p26, p27, p28, p29) -- Line: 238
    -- upvalues: floorUnder (copy), laid (copy)
    local Position = p26.torso.Position;
    local X = Position.X;
    local Z = Position.Z;

    if math.abs(X - p26.floorX) + math.abs(Z - p26.floorZ) > 1.5 then
        p26.floor = floorUnder(Position, p26.character);
        p26.floorX = X;
        p26.floorZ = Z;
    end;

    local floor = p26.floor;
    local v30 = math.max(0, 1 - p27) * 0.03;

    for _, v in p26.entries do
        local real = v.real;
        local part = v.part;

        if real.Parent then
            local CFrame2 = real.CFrame;
            local Position2 = CFrame2.Position;
            local v31;

            if p29 > 0 then
                v31 = CFrame2.Rotation:Lerp(laid(CFrame2, v.axis), p29);
            else
                v31 = CFrame2.Rotation;
            end;

            part.CFrame = v31 + Vector3.new(X + (Position2.X - X) * p28, floor + (Position2.Y - floor) * p27 + v30, Z + (Position2.Z - Z) * p28);
            local v32;

            if v.axis == 1 then
                v32 = Vector3.new(p27, p28, p28);
            elseif v.axis == 2 then
                v32 = Vector3.new(p28, p27, p28);
            else
                v32 = Vector3.new(p28, p28, p27);
            end;

            part.Size = real.Size * v32;

            if v.mesh then
                v.mesh.Scale = v.scale * v32;
                v.mesh.Offset = v.offset * v32;
            end;

            real.LocalTransparencyModifier = 1;
        elseif part.Transparency < 1 then
            part.Transparency = 1;
        end;
    end;

    local realOutline = p26.realOutline;
    local outline = p26.outline;

    if realOutline and (outline and realOutline.Parent) then
        outline.FillColor = realOutline.FillColor;
        outline.OutlineColor = realOutline.OutlineColor;
        outline.FillTransparency = realOutline.FillTransparency;
        outline.OutlineTransparency = realOutline.OutlineTransparency;
    end;
end;

local function finish(p33) -- Line: 281
    -- upvalues: u3 (copy), LocalLooks (copy), u4 (ref)
    local v34 = u3[p33];

    if not v34 then
        return;
    end;

    u3[p33] = nil;

    for i, v in v34.hidden do
        local v35, v36 = LocalLooks.release(i, v, v34);

        if v35 then
            i[v] = v36;
        end;
    end;

    v34.copy:Destroy();
    table.clear(v34.hidden);
    table.clear(v34.entries);
    table.clear(v34.faces);

    if next(u3) == nil and u4 then
        u4:Disconnect();
        u4 = nil;
    end;
end;

local function step() -- Line: 304
    -- upvalues: u3 (copy), finish (copy), u1 (copy), takeOver (copy), draw (copy)
    local os_clock_ret = os.clock();

    for i, v in u3 do
        if i.Parent and (v.torso.Parent and (os_clock_ret - v.started <= 7 and (not v.ragdolled or i:GetAttribute("Ragdolled") == true))) then
            if v.phase == "Fall" then
                local v37 = os_clock_ret - v.started;

                if u1.FallTimeout <= v37 or v37 >= 0.12 and (not v.ragdolled or math.abs(v.torso.CFrame.UpVector.Y) < 0.4) then
                    takeOver(v);
                    v.phase = "Squash";
                    v.at = os_clock_ret;
                end;
            end;

            if v.phase == "Squash" then
                local v38 = (os_clock_ret - v.at) / u1.Squash;

                if v38 >= 1 then
                    local v39 = v.at + u1.Squash;
                    v.phase = "Flat";
                    v.at = v39;
                else
                    local v40 = v38 * v38;
                    draw(v, 1 - 0.96 * v40, 1 + 0.17999999999999994 * v40, v40);
                end;
            end;

            if v.phase == "Flat" then
                local v41 = os_clock_ret - v.at;

                if u1.Flat <= v41 then
                    local v42 = v.at + u1.Flat;
                    v.phase = "Pop";
                    v.at = v42;
                else
                    draw(v, 0.04, math.exp(-v41 * 9) * 0.08099999999999997 * math.sin(v41 * 30) + 1.18, 1);
                end;
            end;

            if v.phase == "Pop" then
                local v43 = (os_clock_ret - v.at) / u1.Pop;

                if v43 >= 1 then
                    finish(i);
                else
                    local v44 = math.clamp(v43, 0, 1) - 1;
                    local math_clamp_ret = math.clamp(v43, 0, 1);
                    local math_clamp_ret2 = math.clamp(v43, 0, 1);
                    draw(v, 0.04 + 0.96 * (1 + 2.9 * v44 * v44 * v44 + 1.9 * v44 * v44), 1.18 + -0.17999999999999994 * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret)), 1 - math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2));
                end;
            end;
        else
            finish(i);
        end;
    end;
end;

function u1.bonk(p45) -- Line: 358
    -- upvalues: ParticleEmitter (copy), u1 (copy)
    if typeof(p45) ~= "Vector3" then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "BonkSplatBonk";
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = p45;
    local v46 = ParticleEmitter:Clone();
    v46.Parent = Attachment;
    v46:Emit(1);
    task.delay(u1.BonkSeconds + 0.15, function() -- Line: 369
        -- upvalues: Attachment (copy)
        Attachment:Destroy();
    end);
end;

function u1.play(p47, p48) -- Line: 375
    -- upvalues: u3 (copy), u1 (copy), copyOf (copy), u4 (ref), RunService (copy), step (copy)
    if typeof(p47) ~= "Instance" or (not p47:IsDescendantOf(workspace) or u3[p47]) then
        return;
    end;

    local Head = p47:FindFirstChild("Head");
    local bonk = u1.bonk;

    if Head and Head:IsA("BasePart") then
        p48 = Head.Position;
    end;

    bonk(p48);
    local v49 = p47:FindFirstChild("Torso") or p47:FindFirstChild("UpperTorso");
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (v49 and (v49:IsA("BasePart") and (workspace_CurrentCamera and (v49.Position - workspace_CurrentCamera.CFrame.Position).Magnitude <= u1.Range))) then
        return;
    end;

    local v50 = copyOf(p47);

    if not v50 then
        return;
    end;

    v50.torso = v49;
    v50.started = os.clock();
    v50.phase = "Fall";
    v50.ragdolled = p47:GetAttribute("Ragdolled") == true;
    u3[p47] = v50;

    if not u4 then
        u4 = RunService.RenderStepped:Connect(step);
    end;
end;

function u1.clear() -- Line: 406
    -- upvalues: u3 (copy), finish (copy)
    for i in u3 do
        finish(i);
    end;
end;

return u1;