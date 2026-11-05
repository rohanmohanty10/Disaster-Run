  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = _G.Petal("New");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;

local function RaycastMap(p3, p4, p5) -- Line: 20
    -- upvalues: u2 (copy)
    u2.FilterDescendantsInstances = { workspace.Map };
    local v6 = workspace:Raycast(p3, p4, u2);

    if p5 then
        return v6;
    end;

    if v6 then
        return v6.Position;
    end;
end;

return function(p7) -- Line: 31
    -- upvalues: u2 (copy), LocalPlayer (copy), u1 (copy), TweenService (copy), ParticleHandler (copy), EffectsHandler (copy), AssetHandler (copy), RunService (copy)
    local TargetCharacter = p7.TargetCharacter;
    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and TargetCharacter) then
        return;
    end;

    local u8 = HumanoidRootPart:GetPivot();
    local Position = u8.Position;
    u2.FilterDescendantsInstances = { workspace.Map };
    local v9 = workspace:Raycast(Position, Vector3.new(0, -5, 0), u2);

    if v9 then
        u8 = u8 * CFrame.new(0, 5 - (u8.Position - v9.Position).Magnitude + 0.15, 0);
    end;

    local v10 = LocalPlayer and (LocalPlayer.Character and LocalPlayer:DistanceFromCharacter(u8.Position) > 100) and 1 or 2;
    local u11 = u1("Model")({
        Name = "Menger Sponge",
        Parent = workspace.Effects
    });
    local u12 = u1("Part")({
        Name = "MengerCube",
        Size = Vector3.new(0, 0, 0),
        Anchored = true,
        CanCollide = false,
        Material = Enum.Material.SmoothPlastic,
        Position = u8.Position
    });
    local v13 = {};

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") and child.Name ~= HumanoidRootPart then
            table.insert(v13, child.Color);
        end;
    end;

    for _, descendant in TargetCharacter:GetDescendants() do
        if descendant:IsA("Decal") or (descendant:IsA("Texture") or descendant:IsA("BasePart")) then
            TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            ParticleHandler.EnableAllParticles(TargetCharacter, false);
        end;
    end;

    local u19 = (function(p14) -- Line: 87, Name: AvgColor
        local v15 = #p14;
        local v16 = 0;
        local v17 = 0;
        local v18 = 0;

        for _, v in ipairs(p14) do
            v16 = v16 + v.R;
            v17 = v17 + v.G;
            v18 = v18 + v.B;
        end;

        return Color3.new(v16 / v15, v17 / v15, v18 / v15);
    end)(v13);
    table.clear(v13);

    local function CreateCube(p20, p21) -- Line: 104
        -- upvalues: u12 (copy), u8 (ref), u19 (copy), u11 (ref), TweenService (ref)
        local v22 = Instance.fromExisting(u12);
        local v23 = (p20.Position - u8.Position).Magnitude / 10;
        local v24, v25, v26 = u19:ToHSV();
        v22.Color = u19:Lerp(Color3.fromHSV(v24, v25, (math.max(0.1, v26 / 3))), v23);
        v22.Parent = u11;
        TweenService:Create(v22, TweenInfo.new((p20.Position - u8.Position).Magnitude / 6.666666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            CFrame = p20,
            Size = p21
        }):Play();
    end;

    local function CreateMengerSponge(p27, p28, p29) -- Line: 121
        -- upvalues: CreateCube (copy), CreateMengerSponge (copy)
        if p29 == 0 then
            CreateCube(p27, Vector3.new(1, 1, 1) * p28);

            return;
        end;

        local v30 = p28 / 3;

        for i = -1, 1 do
            for i2 = -1, 1 do
                for i3 = -1, 1 do
                    if math.abs(i) + math.abs(i2) + math.abs(i3) > 1 then
                        local v31 = Vector3.new(i * v30, i2 * v30, i3 * v30);
                        CreateMengerSponge(p27 * CFrame.new(v31), v30, p29 - 1);
                    end;
                end;
            end;
        end;
    end;

    debug.setmemorycategory("Menger Sponge");
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset("Menger Sponge/MengerSponge", {
            AbilityName = "KillEffects"
        }),
        Origin = u8
    });
    CreateMengerSponge(u8, 10, v10);
    task.wait(1.1547005383792515);
    local v32 = 1;
    local v33 = 0;
    local v34 = false;

    while v32 > 0.001 do
        local v35 = RunService.Heartbeat:Wait();
        v32 = v32 - v35 / 2;
        v33 = v33 + v35 / 25;
        u11:PivotTo(u11:GetPivot() * CFrame.Angles(0.7853981633974483 * v33, 0.5235987755982988 * v33, 0.7853981633974483 * v33));
        u11:ScaleTo((math.max(0.001, v32)));

        if v32 < 0.07 and not v34 then
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Menger Sponge/SpongeBlink",
                AbilityName = "KillEffects",
                AutoSerialize = true,
                Origin = u8
            });
            v34 = true;
        end;
    end;

    u11:Destroy();
    u11 = nil;
end;