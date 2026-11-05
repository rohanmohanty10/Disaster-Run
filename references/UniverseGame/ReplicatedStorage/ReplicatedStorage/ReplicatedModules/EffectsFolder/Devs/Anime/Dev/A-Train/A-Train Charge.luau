  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 18
    -- upvalues: u1 (copy), u2 (copy), ParticleHandler (copy), EffectsHandler (copy), TweenService (copy)
    local Character = p3.Character;
    local Attribute = p3.Attribute;
    local Color = p3.Color;
    local WaitTime = p3.WaitTime;
    local Size = p3.Size;
    local u4 = p3.DestroyTime or 1;
    local HumanoidRootPart = Character.HumanoidRootPart;
    os.clock();
    local v5 = os.clock() + 0.3;
    task.spawn(function() -- Line: 31
        -- upvalues: HumanoidRootPart (copy), u1 (ref), u2 (ref), ParticleHandler (ref), Character (copy), EffectsHandler (ref), Color (copy), Size (copy), u4 (copy), WaitTime (copy), Attribute (copy)
        while true do
            local Position = HumanoidRootPart.Position;
            local v6 = u1:NextNumber(-13, 13);
            local v7 = Position + Vector3.new(v6, 0, u1:NextNumber(-13, 13));
            local v8 = workspace:Raycast(v7 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u2);

            if v8 then
                local _ = v8.Instance;
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = workspace.Terrain;
                Attachment.WorldPosition = v8.Position;
                local Attachment2 = Instance.new("Attachment");
                Attachment2.Parent = workspace.Terrain;
                local Position2 = v8.Position;
                local v9 = u1:NextNumber(5, 20);
                Attachment2.WorldPosition = Position2 + Vector3.new(0, v9, 0);
                local v10 = u1:NextNumber(4, 5);
                local v11 = ParticleHandler.GetUnusualHSVData({
                    Character = Character
                });
                local v12 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                    Color = Color or ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(105, 141, 192)), v11),
                    Curves = { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) },
                    Speed = v10,
                    Length = u1:NextNumber(0.66, 0.85),
                    A1 = Attachment,
                    A2 = Attachment2,
                    Size = Size or u1:NextNumber(0.65, 0.84),
                    PartCount = math.random(10, 14)
                });
                v12.MinThicknessMultiplier = 0.8;
                v12.AnimationSpeed = u1:NextNumber(0, 1);
                v12.MinRadius = 1.3;
                v12.MaxRadius = 1.85;
                task.delay(u4 / v10, function() -- Line: 68
                    -- upvalues: Attachment (copy), Attachment2 (copy)
                    Attachment:Destroy();
                    Attachment2:Destroy();
                end);
            end;

            EffectsHandler.Wait(WaitTime or 0.04);

            if not (Character:IsDescendantOf(game) and Character:GetAttribute(Attribute)) then
                return;
            end;
        end;
    end);

    while true do
        local Position = HumanoidRootPart.Position;
        local v13 = u1:NextNumber(-12, 12);
        local v14 = Position + Vector3.new(v13, 0, u1:NextNumber(-12, 12));
        local v15 = workspace:Raycast(v14 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u2);

        if v15 then
            local Instance2 = v15.Instance;
            local v16 = math.random(0, 360);
            local v17 = math.rad(v16);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.Material = v15.Material;
            Part.Color = Instance2.Color;
            Part.CFrame = CFrame.new(v15.Position) * CFrame.Angles(v17, v17, v17);
            Part.Size = Vector3.new(1, 1, 1) * u1:NextNumber(1.85, 2.5);
            Part.BottomSurface = Enum.SurfaceType.Smooth;
            Part.TopSurface = Enum.SurfaceType.Smooth;
            Part.Parent = workspace.Effects;
            task.delay(1, Part.Destroy, Part);

            for _, child in pairs(Instance2:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child:Clone().Parent = Part;
                end;
            end;

            local v18 = math.random(0, 360);
            math.rad(v18);
            local v19 = {
                Size = Vector3.new(0, 0, 0)
            };
            local Position2 = Part.Position;
            local v20 = Part.Size.Magnitude * u1:NextNumber(3.35, 4.75);
            v19.Position = Position2 + Vector3.new(0, v20, 0);
            local v21 = math.random(150, 275);
            local v22 = math.random(150, 275);
            v19.Orientation = Vector3.new(v21, v22, math.random(150, 275));
            TweenService:Create(Part, TweenInfo.new(u1:NextNumber(0.65, 1), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v19):Play();
        end;

        if os.clock() - v5 > 0.25 then
            v5 = os.clock();
            local v23 = ParticleHandler.GetUnusualHSVData({
                Character = Character
            });
            local Part = Instance.new("Part");
            Part.Transparency = 1;
            Part.Shape = "Ball";
            Part.Material = Enum.Material.ForceField;
            Part.Color = ParticleHandler.TryHSVShift(Color3.new(0.113725, 0.305882, 0.752941), v23);
            Part.Size = Vector3.new(18, 18, 18);
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CastShadow = false;
            Part.Position = Character.Torso.Position;
            Part.Parent = workspace.Effects;
            task.delay(1.1, Part.Destroy, Part);
            TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Size = Vector3.new(0, 0, 0),
                Transparency = 0
            }):Play();
        end;

        task.wait(u1:NextNumber(0.025, 0.04));

        if not (Character:IsDescendantOf(game) and Character:GetAttribute(Attribute)) then
            return;
        end;
    end;
end;