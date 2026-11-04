 

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return {
    play = function(p1) -- Line: 5, Name: play
        -- upvalues: Debris (copy), TweenService (copy)
        if typeof(p1) ~= "Vector3" then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera or (workspace_CurrentCamera.CFrame.Position - p1).Magnitude > 140 then
            return;
        end;

        local Part = Instance.new("Part");
        Part.Name = "CloneSplitBurst";
        Part.Size = Vector3.new(1, 1, 1);
        Part.CFrame = CFrame.new(p1);
        Part.Transparency = 1;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Name = "SharedSplitMist";
        ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
        ParticleEmitter.Rate = 0;
        ParticleEmitter.Lifetime = NumberRange.new(0.24, 0.42);
        ParticleEmitter.Speed = NumberRange.new(6, 13);
        ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
        ParticleEmitter.Rotation = NumberRange.new(0, 360);
        ParticleEmitter.RotSpeed = NumberRange.new(-75, 75);
        ParticleEmitter.Drag = 12;
        ParticleEmitter.LightEmission = 0.4;
        ParticleEmitter.LightInfluence = 0;
        ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(110, 145, 255), Color3.fromRGB(143, 106, 215));
        ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5), NumberSequenceKeypoint.new(0.4, 8), NumberSequenceKeypoint.new(1, 10) });
        ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(0.35, 0.45), NumberSequenceKeypoint.new(1, 1) });
        ParticleEmitter.Parent = Part;
        Part.Parent = workspace;
        ParticleEmitter:Emit(16);
        Debris:AddItem(Part, 0.5);
        local Part2 = Instance.new("Part");
        Part2.Name = "CloneSplitFlash";
        Part2.Shape = Enum.PartType.Ball;
        Part2.Size = Vector3.new(4, 6, 4);
        Part2.CFrame = CFrame.new(p1);
        Part2.Material = Enum.Material.Neon;
        Part2.Color = Color3.fromRGB(147, 177, 255);
        Part2.Transparency = 0.7;
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanTouch = false;
        Part2.CanQuery = false;
        Part2.CastShadow = false;
        Part2.Parent = workspace;
        TweenService:Create(Part2, TweenInfo.new(0.26, Enum.EasingStyle.Quad), {
            Size = Vector3.new(13, 8, 13),
            Transparency = 1
        }):Play();
        Debris:AddItem(Part2, 0.3);
    end
};