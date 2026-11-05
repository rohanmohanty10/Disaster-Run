  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage:FindFirstChild("Client Assets");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Random.new();
local LocalPlayer = game.Players.LocalPlayer;
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 20
    -- upvalues: LocalPlayer (copy), TweenService (copy), ParticleHandler (copy), AssetHandler (copy), u1 (copy), u2 (copy), EffectsHandler (copy)
    local v4 = p3 or {};
    local Character = v4.Character;
    local Duration = v4.Duration;

    if table.find(v4.Clients, LocalPlayer) then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = game.Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.85, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Brightness = 0.1,
            Contrast = 0.1,
            Saturation = 0.4,
            TintColor = ParticleHandler.TryHSVShift(Color3.fromRGB(101, 155, 255), ParticleHandler.GetUnusualHSVData({
                Character = Character
            }))
        }):Play();
        task.delay(Duration, function() -- Line: 38
            -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Brightness = 0,
                Contrast = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
        end);
    end;

    local v5 = os.clock();
    local v6 = os.clock();
    local Position = Character.Torso.Position;
    Character:SetAttribute("Flashtime", true);
    local v7 = AssetHandler.CloneAsset("Particles/Beatdown/FlashtimeTrails", {
        AbilityName = "UGrain"
    });
    ParticleHandler.Unusualify(v7, {
        Character = Character
    });
    v7.Parent = workspace.Effects;

    for _, child in v7:GetChildren() do
        ParticleHandler.AttachTo(child, {
            Part = Character[child.Name]
        });
    end;

    local v8 = {};
    local v9 = workspace.Effects:FindFirstChild(Character.Name .. " A-Train Speed Trails");

    if v9 then
        for _, descendant in v9:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                v8[descendant] = descendant.TimeScale;
                descendant.TimeScale = descendant.TimeScale * 0.25;
            end;
        end;
    end;

    local AwakeningMusic = Character:FindFirstChild("AwakeningMusic", true);
    local AwakeningMusicGuitar = Character:FindFirstChild("AwakeningMusicGuitar", true);

    for i = 1, 2 do
        local v10 = i == 1 and AwakeningMusic and AwakeningMusic or AwakeningMusicGuitar;

        if v10 then
            TweenService:Create(v10, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                PlaybackSpeed = (v10:GetAttribute("GoalPitch") or v10.PlaybackSpeed) * 0.75
            }):Play();
        end;
    end;

    while Character and (Character:IsDescendantOf(game) and os.clock() - v5 < Duration) do
        local v11 = ParticleHandler.GetUnusualHSVData({
            Character = Character
        });

        if (Position - Character.Torso.Position).Magnitude > 2.5 and not Character:GetAttribute("NoAfterimages") then
            Position = Character.Torso.Position;
            local v12 = AssetHandler.CloneAsset("Particles/Beatdown/Afterimage", {
                AbilityName = "UGrain"
            });
            ParticleHandler.Unusualify(v12, {
                HSVData = v11
            });
            v12.Parent = workspace.Effects;
            task.delay(1.15, v12.Destroy, v12);

            for _, child in v12:GetChildren() do
                child.CFrame = Character[child.Name].CFrame;
                TweenService:Create(child, TweenInfo.new(1.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        if os.clock() - v6 > 0.39 then
            v6 = os.clock();
            local Position2 = Character.Torso.Position;
            local v13 = u1:NextNumber(-13, 13);
            local v14 = Position2 + Vector3.new(v13, 0, u1:NextNumber(-13, 13));
            local v15 = workspace:Raycast(v14 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u2);

            if v15 then
                local _ = v15.Instance;
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = workspace.Terrain;
                Attachment.WorldPosition = v15.Position;
                local Attachment2 = Instance.new("Attachment");
                Attachment2.Parent = workspace.Terrain;
                local Position3 = v15.Position;
                local v16 = u1:NextNumber(5, 20);
                Attachment2.WorldPosition = Position3 + Vector3.new(0, v16, 0);
                local v17 = u1:NextNumber(0.25, 0.48);
                local v18 = u1:NextNumber(4, 5) * v17;
                local v19 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                    Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(105, 141, 192)), v11),
                    Curves = { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) },
                    Speed = v18,
                    Length = u1:NextNumber(0.66, 0.85) / v17,
                    A1 = Attachment,
                    A2 = Attachment2,
                    Size = u1:NextNumber(0.35, 0.57),
                    PartCount = math.random(10, 14)
                });
                v19.MinThicknessMultiplier = 0.8;
                v19.AnimationSpeed = u1:NextNumber(0, 1);
                v19.MinRadius = 1.3;
                v19.MaxRadius = 1.85;
                task.delay(1 / v18, function() -- Line: 150
                    -- upvalues: Attachment (copy), Attachment2 (copy)
                    Attachment:Destroy();
                    Attachment2:Destroy();
                end);
            end;
        end;

        EffectsHandler.Wait();
    end;

    if Character and Character:IsDescendantOf(game) then
        Character:SetAttribute("Flashtime", nil);
        ParticleHandler.DestroyEmit(v7);
        ParticleHandler.EnableAllParticles(v7, false);

        for i, v in v8 do
            if i and i:IsDescendantOf(game) then
                i.TimeScale = v;
            end;
        end;

        for i = 1, 2 do
            local v20 = i == 1 and AwakeningMusic and AwakeningMusic or AwakeningMusicGuitar;

            if v20 then
                TweenService:Create(v20, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    PlaybackSpeed = v20:GetAttribute("GoalPitch") or v20.PlaybackSpeed * 1.333
                }):Play();
            end;
        end;
    end;
end;