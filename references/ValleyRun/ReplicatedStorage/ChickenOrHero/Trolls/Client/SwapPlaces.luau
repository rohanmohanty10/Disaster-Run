 

 

return {
    start = function(u1) -- Line: 4, Name: start
        u1.on("Poof", function(p2) -- Line: 5
            -- upvalues: u1 (copy)
            if type(p2) ~= "table" then
                return;
            end;

            local v3 = 0;

            for _, v in p2 do
                v3 = v3 + 1;

                if v3 > 60 or typeof(v) ~= "Vector3" then
                    break;
                end;

                local Part = Instance.new("Part");
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanQuery = false;
                Part.CanTouch = false;
                Part.Transparency = 1;
                Part.Size = Vector3.new(1, 1, 1);
                Part.Position = v;
                Part.Parent = workspace;
                local ParticleEmitter = Instance.new("ParticleEmitter");
                ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
                ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(220, 200, 255));
                ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1) });
                ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 6) });
                ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.9);
                ParticleEmitter.Speed = NumberRange.new(5, 10);
                ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
                ParticleEmitter.Rate = 0;
                ParticleEmitter.Parent = Part;
                local v4 = ParticleEmitter:Clone();
                v4.Texture = "rbxasset://textures/particles/sparkles_main.dds";
                v4.LightEmission = 1;
                v4.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) });
                v4.Parent = Part;
                ParticleEmitter:Emit(14);
                v4:Emit(10);
                task.delay(1.2, function() -- Line: 41
                    -- upvalues: Part (copy)
                    Part:Destroy();
                end);
            end;

            u1.sound("02_Movement/BoostStart", nil, 0.6);
        end);
    end
};