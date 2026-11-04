 
 

return {
    { 0, function(p1, p2) -- Line: 3
            p2.CamPart.Attachment.shockwave.Enabled = true;
        end },
    { 46, function(p3, p4) -- Line: 8
            for _, v in p3.HumanoidRootPart.hit:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 127, function(p5, p6) -- Line: 13
            for _, v in p5.HumanoidRootPart.tp:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 130, function(p7, p8) -- Line: 18
            for _, v in p7.HumanoidRootPart.tp:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 134, function(p9, p10) -- Line: 23
            for _, v in p9.HumanoidRootPart.tp:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 169, function(p11, p12) -- Line: 28
            for _, v in p11.HumanoidRootPart.tp2:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;

            local HighlightEmit = require(script.modules.hit.HighlightEmit);
            HighlightEmit(p11, Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 255, 0), 0.5, Enum.HighlightDepthMode.Occluded, 0.5);

            return HighlightEmit();
        end },
    { 179, function(p13, p14) -- Line: 48
            for _, v in p13.HumanoidRootPart.tp2:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 187, function(p15, p16) -- Line: 53
            require(script.modules.hit.mhhighlight)(p15);

            for _, v in p15.HumanoidRootPart.secondhit:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 209, function(p17, p18) -- Line: 62
            for _, v in p17.HumanoidRootPart.lastoneipromise:QueryDescendants("ParticleEmitter") do
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end },
    { 213, function(p19, p20) -- Line: 69
            local beampart = p19:WaitForChild("HumanoidRootPart"):WaitForChild("beampart");

            for _, descendant in beampart:GetDescendants() do
                if descendant:IsA("Beam") then
                    descendant.Width1 = 2;
                    descendant.Enabled = true;
                end;
            end;

            task.wait(1.4);

            for _, descendant in beampart:GetDescendants() do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 214, function(p21, p22) -- Line: 94
            local TweenService = game:GetService("TweenService");
            local beampart = p21.HumanoidRootPart.beampart;
            local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            local v23 = {
                Width0 = 0,
                Width1 = 0
            };

            for _, descendant in beampart:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo_new_ret, v23):Play();
                end;
            end;
        end }
};