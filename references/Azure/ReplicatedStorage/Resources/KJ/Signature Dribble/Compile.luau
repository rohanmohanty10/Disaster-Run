 
 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 3
            for _, descendant in p1.HumanoidRootPart.stepovers:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration") or 1.8, function(p5, p6, p7, p8) -- Line: 9
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 121, function(p9, p10, p11, p12) -- Line: 17
            require(p10.meshmodule)(p9.HumanoidRootPart.CFrame * CFrame.Angles(0, math.random(-360, 360), 0));

            for _, v in p9.HumanoidRootPart.lift:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 146, function(p13, p14, p15, p16) -- Line: 24
            for _, v in p13.HumanoidRootPart.taplift:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;

            require(p15.meshtwotwo.twotwo)(p13.HumanoidRootPart.CFrame * CFrame.new(0.551, -2.15, 1.132) * CFrame.Angles(0, math.random(-360, 360), 0));
            require(p15.meshtwoone.twoone)(p13.HumanoidRootPart.CFrame * CFrame.new(0.541, -2.541, 1.132));
        end },
    { 173, function(p17, p18, p19, p20) -- Line: 33
            for _, v in p17.HumanoidRootPart.secondlift:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 213, function(p21, p22, p23, p24) -- Line: 38
            for _, v in p21.HumanoidRootPart.trap.first:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;

            for _, descendant in p21.HumanoidRootPart.trap.second:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration") or 0.2, function() -- Line: 46
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            require(p24.newnew)(p21.HumanoidRootPart.CFrame * CFrame.new(-0.133, 1.959, -3.804) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)));
        end },
    { 232, function(p25, p26, p27, p28) -- Line: 56
            for _, descendant in p25.HumanoidRootPart.trap.third:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    shared.vfx.emit(descendant);
                end;
            end;
        end }
};