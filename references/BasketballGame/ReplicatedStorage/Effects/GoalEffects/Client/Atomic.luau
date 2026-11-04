 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    local v4 = 0;

    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 24
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;

            local v5 = (v:GetAttribute("EmitDelay") or 0) + v.Lifetime.Max;
            v4 = math.max(v4, v5);
        end;
    end;

    return v4;
end;

local function Destroy_Effect(u6: userdata, p7: number) -- Line: 38
    task.delay(p7, function() -- Line: 39
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

return function(p8, p9) -- Line: 44
    -- upvalues: TweenService (copy)
    local u10 = script.AtomicGoalEffect:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(p9.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));

    if p9.Preview then
        u10.BeamParts:Destroy();
        u10.EmittingParts:Destroy();

        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v11 = descendant;
                local v12 = {};

                for _, v in descendant.Size.Keypoints do
                    local v13;

                    if v.Envelope then
                        v13 = v.Envelope / 10 or nil;
                    else
                        v13 = nil;
                    end;

                    if v13 ~= v13 then
                        v13 = nil;
                    end;

                    table.insert(v12, NumberSequenceKeypoint.new(v.Time, v.Value / 10, v13));
                end;

                v11.Size = NumberSequence.new(v12);
                v11.Speed = NumberRange.new(v11.Speed.Min / 10, v11.Speed.Max / 10);
            elseif descendant:IsA("Attachment") then
                descendant.Position = descendant.Position / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("BasePart") then
                descendant.Position = p9.CFrame.Position + (descendant.Position - p9.CFrame.Position) / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = p9.CFrame.Position;
                end;

                descendant.Size = descendant.Size / 10;

                if descendant.Size ~= descendant.Size then
                    descendant.Size = Vector3.new(0, 0, 0);
                end;
            end;
        end;

        EmitAll(u10.InitialHit:GetDescendants());
        task.delay(3.5, function() -- Line: 39
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);
        EnableVFX(u10.Enable, true);
        task.delay(0.455, function() -- Line: 97
            -- upvalues: u10 (copy)
            EmitAll(u10.Emit:GetDescendants());
        end);
        task.delay(0.488, function() -- Line: 101
            -- upvalues: u10 (copy)
            EnableVFX(u10.Enable, false);
        end);

        return;
    end;

    EmitAll(u10.InitialHit:GetDescendants());
    task.delay(6.5, function() -- Line: 39
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
    EnableVFX(u10.Enable, true);
    task.wait(0.455);
    EmitAll(u10.Emit:GetDescendants());
    local game_Lighting = game.Lighting;
    local u14 = game_Lighting.ColorCorrection:Clone();
    u14.Name = "OR";
    local ColorCorrection = game_Lighting.ColorCorrection;
    local v15 = TweenService:Create(ColorCorrection, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
        Brightness = 0.2
    });
    v15:Play();
    v15.Completed:Connect(function() -- Line: 125
        -- upvalues: TweenService (ref), ColorCorrection (copy), u14 (copy)
        TweenService:Create(ColorCorrection, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
            Brightness = -0.5,
            Saturation = -1,
            TintColor = Color3.fromRGB(195, 75, 255)
        }):Play();
        task.wait(0.055);
        TweenService:Create(ColorCorrection, TweenInfo.new(0.567, Enum.EasingStyle.Linear), {
            Brightness = u14.Brightness,
            Saturation = u14.Saturation,
            TintColor = u14.TintColor
        }):Play();
    end);
    local v16 = game_Lighting.Bloom:Clone();
    v16.Name = "ORB";
    local Bloom = game_Lighting.Bloom;
    Bloom.Intensity = 2;
    Bloom.Threshold = 0.5;
    TweenService:Create(Bloom, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
        Intensity = v16.Intensity,
        Threshold = v16.Threshold
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", game_Lighting);
    BlurEffect.Size = 12;
    TweenService:Create(BlurEffect, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    task.delay(0.855, function() -- Line: 39
        -- upvalues: BlurEffect (copy)
        BlurEffect:Destroy();
    end);
    task.wait(0.033);
    EmitAll(u10.EmittingParts:GetDescendants());
    EnableVFX(u10.BeamParts, true);
    EnableVFX(u10.AuraBG, true);
    EnableVFX(u10.Enable, false);

    for _, descendant in u10.BeamParts:GetDescendants() do
        if descendant.ClassName == "Attachment" and descendant.Name == "Stretch" then
            local WorldPosition = descendant.WorldPosition;
            descendant.WorldPosition = Vector3.new(WorldPosition.X, 0, WorldPosition.Z);
            TweenService:Create(descendant, TweenInfo.new(0.155, Enum.EasingStyle.Sine), {
                WorldPosition = WorldPosition
            }):Play();
        elseif descendant.ClassName == "Beam" then
            descendant.Enabled = true;
        end;
    end;

    task.wait(3.5);
    EmitAll(u10.EmittingParts:GetDescendants());
    EnableVFX(u10.BeamParts, false);
    EnableVFX(u10.AuraBG, false);

    for _, descendant in u10.BeamParts:GetDescendants() do
        if descendant:IsA("Attachment") and descendant.Name == "Stretch" then
            local WorldPosition = descendant.WorldPosition;
            TweenService:Create(descendant, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
                WorldPosition = Vector3.new(WorldPosition.X, 0, WorldPosition.Z)
            }):Play();
        end;
    end;

    u14:Destroy();
end;