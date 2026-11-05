  

 

return {
    SnowstormExpand = function(p1) -- Line: 2
        local Particle = p1.Particle;
        local TweenParticleScaleInfo = p1.TweenParticleScaleInfo;
        local Time = TweenParticleScaleInfo.Time;
        local v2 = TweenParticleScaleInfo.Scale - 1;
        local v3 = os.clock() + Time;
        local v4 = {
            [Particle] = Particle
        };
        local v5 = 0;

        local function ScaleParticle(p6, p7, p8) -- Line: 9
            local Size = p8.Size;
            local Speed = p8.Speed;
            local Acceleration = p8.Acceleration;

            if typeof(Size) == "NumberSequence" then
                local v9 = {};

                for i = 1, #Size.Keypoints do
                    local v10 = Size.Keypoints[i];
                    table.insert(v9, NumberSequenceKeypoint.new(v10.Time, v10.Value * p7, v10.Envelope * p7));
                end;

                p6.Size = NumberSequence.new(v9);
            end;

            p6.Speed = NumberRange.new(Speed.Min * p7, Speed.Max * p7);
            p6.Acceleration = Acceleration * p7;
        end;

        for _, descendant in Particle:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                v4[descendant] = {
                    Size = descendant.Size,
                    Speed = descendant.Speed,
                    Acceleration = descendant.Acceleration
                };
            end;
        end;

        while os.clock() <= v3 do
            local v11 = v5 / Time;
            local v12 = v11 > 1 and 1 or v11;

            for _, descendant in Particle:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    ScaleParticle(descendant, 1 + v12 * v2, v4[descendant]);
                end;
            end;

            if Particle:IsA("ParticleEmitter") then
                ScaleParticle(Particle, 1 + v12 * v2, v4[Particle]);
            end;

            v5 = v5 + task.wait();
        end;

        table.clear(v4);
    end
};