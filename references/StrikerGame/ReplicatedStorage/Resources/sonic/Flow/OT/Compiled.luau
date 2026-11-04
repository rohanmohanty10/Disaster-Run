 
 

local TweenService = game:GetService("TweenService");

return {
    { 0, function(p1, p2, p3) -- Line: 4
            for _, descendant in pairs(p1.WindLast:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p1.WindFirst:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 21, function(p4, p5, p6) -- Line: 18
            for _, descendant in pairs(p5.HumanoidRootPart.CutsceneVFX.Step1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 70, function(p7, p8, p9) -- Line: 28
            for _, descendant in pairs(p7.WindFirst:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 75, function(p10, p11, p12) -- Line: 36
            for _, descendant in pairs(p11.HumanoidRootPart.CutsceneVFX.Step2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 111, function(p13, p14, p15) -- Line: 46
            for _, descendant in pairs(p15.Torso.ZoomStuff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 126, function(p16, p17, p18) -- Line: 54
            for _, descendant in pairs(p18.Torso.ZoomStuff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 192, function(p19, p20, p21) -- Line: 62
            for _, descendant in pairs(p20.HumanoidRootPart.CutsceneVFX.Smear:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 252, function(p22, p23, p24) -- Line: 72
            for _, descendant in pairs(p24.Torso.ZoomStuff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 267, function(p25, p26, p27) -- Line: 80
            for _, descendant in pairs(p27.Torso.ZoomStuff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 656, function(p28, p29, p30) -- Line: 88
            for _, descendant in pairs(p29["Chaos Emeralds"]:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 750, function(p31, p32, p33) -- Line: 96
            for _, descendant in pairs(p31.Transforming:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 783, function(p34, p35, p36) -- Line: 104
            -- upvalues: TweenService (copy)
            local Transformed = p35.Transformed;

            for _, descendant in pairs(p35["Chaos Emeralds"]:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(Transformed:GetDescendants()) do
                if descendant:IsA("Part") or descendant:IsA("MeshPart") then
                    TweenService:Create(descendant, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Transparency = 0
                    }):Play();
                end;
            end;
        end },
    { 789, function(p37, p38, p39) -- Line: 120
            -- upvalues: TweenService (copy)
            for _, descendant in pairs(p37.Transforming:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p37.WindLast:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p37.WindFirst:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p38.HumanoidRootPart.CutsceneVFX.TransformedBeams:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    TweenService:Create(descendant, TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Width0 = 0
                    }):Play();
                    TweenService:Create(descendant, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Width1 = 0
                    }):Play();
                end;
            end;
        end },
    { 792, function(p40, p41, p42) -- Line: 152
            -- upvalues: TweenService (copy)
            local Transformed = p41.Transformed;

            for _, descendant in pairs(Transformed:GetDescendants()) do
                if descendant:IsA("Part") or descendant:IsA("MeshPart") then
                    TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            for _, descendant in pairs(Transformed:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 870, function(p43, p44, p45) -- Line: 169
            -- upvalues: TweenService (copy)
            for _, descendant in pairs(p44.HumanoidRootPart.CutsceneVFX.TransformedBeams:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                    TweenService:Create(descendant, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Width0 = 1
                    }):Play();
                    TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Width1 = 18
                    }):Play();
                end;
            end;

            for _, descendant in pairs(p44.Transformed:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};