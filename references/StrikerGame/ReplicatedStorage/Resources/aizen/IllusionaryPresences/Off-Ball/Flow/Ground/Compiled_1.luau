 
 

return {
    { 0, function(p1, p2) -- Line: 4
            shared.vfx.emit(p2.CamPart);
        end },
    { 60, function(p3) -- Line: 10
            shared.vfx.emit(p3.mina);
        end },
    { 135, function(p4) -- Line: 16
            shared.vfx.emit(p4.mina2);
        end },
    { 341, function(p5) -- Line: 22
            shared.vfx.emit(p5.mina3);
        end },
    { 490, function(p6, p7, p8) -- Line: 28
            shared.vfx.emit(p8.Handle.uchigatana.blade);
        end },
    { 711, function(p9, p10, p11, p12) -- Line: 34
            shared.vfx.emit(p9.alan);
            shared.vfx.emit(p9.free);
            shared.vfx.emit(p9.new);
            shared.vfx.emit(p12.Torso.DIEE);
            local DIEE = p12.Torso.DIEE;
            local RunService = game:GetService("RunService");
            local u13 = {};

            for _, descendant in pairs(DIEE:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    table.insert(u13, {
                        emitter = descendant,
                        original = descendant.TimeScale
                    });
                end;
            end;

            local function tweenTimeScale(p14, p15, p16) -- Line: 63
                -- upvalues: RunService (copy), u13 (copy)
                local v17 = 0;

                while v17 < p16 do
                    v17 = v17 + RunService.Heartbeat:Wait();
                    local math_clamp_ret = math.clamp(v17 / p16, 0, 1);
                    local v18 = p14 + (p15 - p14) * math_clamp_ret;

                    for _, v in pairs(u13) do
                        if v.emitter and v.emitter.Parent then
                            v.emitter.TimeScale = v18;
                        end;
                    end;
                end;

                for _, v in pairs(u13) do
                    if v.emitter and v.emitter.Parent then
                        v.emitter.TimeScale = p15;
                    end;
                end;
            end;

            for _, v in pairs(u13) do
                v.startValue = v.original;
            end;

            tweenTimeScale(u13[1].original, 0.025, 0.15);
            task.wait(1.4);
            tweenTimeScale(0.025, u13[1].original, 0.15);
        end },
    { 711, function(p19) -- Line: 103
            local Attachment = p19.alan.Attachment;
            local RunService = game:GetService("RunService");
            local u20 = {};

            for _, descendant in pairs(Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    table.insert(u20, {
                        emitter = descendant,
                        original = descendant.TimeScale
                    });
                end;
            end;

            local function v26(p21, p22, p23) -- Line: 126
                -- upvalues: RunService (copy), u20 (copy)
                local v24 = 0;

                while v24 < p23 do
                    v24 = v24 + RunService.Heartbeat:Wait();
                    local math_clamp_ret = math.clamp(v24 / p23, 0, 1);
                    local v25 = p21 + (p22 - p21) * math_clamp_ret;

                    for _, v in pairs(u20) do
                        if v.emitter and v.emitter.Parent then
                            v.emitter.TimeScale = v25;
                        end;
                    end;
                end;

                for _, v in pairs(u20) do
                    if v.emitter and v.emitter.Parent then
                        v.emitter.TimeScale = p22;
                    end;
                end;
            end;

            for _, v in pairs(u20) do
                v.startValue = v.original;
            end;

            v26(u20[1].original, 0.025, 0.2);
            task.wait(1.35);
            v26(0.025, u20[1].original, 0.2);
        end },
    { 750, function(p27) -- Line: 166
            shared.vfx.emit(p27.okay.three.uni0033);
        end }
};