 
 

local function Enabler(p1: any, p2: boolean) -- Line: 1
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = p2;
        end;
    end;
end;

return {
    { 0, function(p3, p4, p5) -- Line: 13
            -- upvalues: Enabler (copy)
            shared.vfx.emit(p3["Right Leg"].RightFootAttachment.Attachment);
            Enabler(p3["Right Leg"].Attachment, true);
            Enabler(p3["Left Leg"].Attachment, true);
            Enabler(p3["Right Leg"].RightFootAttachment.Spark, true);
            Enabler(p4.MVP1Particles.Lower, true);

            if p5 then
                Enabler(p5.CamPart.Attachment, true);
            end;

            local TweenService = game:GetService("TweenService");
            local SlideLight = p3.Torso.WaistFrontAttachment.SlideLight;
            SlideLight.Brightness = 12;
            TweenService:Create(SlideLight, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end },
    { 7, function(p6, p7, p8) -- Line: 37
            -- upvalues: Enabler (copy)
            Enabler(p6["Right Leg"].RightFootAttachment.Spark, false);
        end },
    { 26, function(p9, p10, p11) -- Line: 46
            -- upvalues: Enabler (copy)
            shared.vfx.emit(p9["Left Leg"].LeftFootAttachment.Attachment);
            Enabler(p9["Left Leg"].LeftFootAttachment.Spark, true);
            local TweenService = game:GetService("TweenService");
            local SlideLight = p9.Torso.WaistFrontAttachment.SlideLight;
            SlideLight.Brightness = 24;
            TweenService:Create(SlideLight, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end },
    { 50, function(p12, p13, p14) -- Line: 61
            -- upvalues: Enabler (copy)
            shared.vfx.emit(p13.MVP1Particles.Meshes.Hop);
            shared.vfx.emit(p13.MVP1Particles.Jump.Attachment);
            Enabler(p12["Left Leg"].LeftFootAttachment.Spark, false);
        end },
    { 88, function(p15, p16, p17) -- Line: 72
            -- upvalues: Enabler (copy)
            shared.vfx.emit(p16.MVP1Particles.Meshes.Slam);
            shared.vfx.emit(p16.Land);
            Enabler(p15["Left Leg"].LeftFootAttachment.Spark, true);
            local TweenService = game:GetService("TweenService");
            local SlideLight = p15.Torso.WaistFrontAttachment.SlideLight;
            SlideLight.Brightness = 17;
            TweenService:Create(SlideLight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end },
    { 104, function(p18, p19, p20) -- Line: 89
            -- upvalues: Enabler (copy)
            Enabler(p18["Left Leg"].LeftFootAttachment.Spark, false);
        end },
    { 120, function(p21, p22, p23) -- Line: 97
            shared.vfx.emit(p22.MVP1Particles.Jump2);
        end },
    { 123, function(p24, p25, p26) -- Line: 102
            -- upvalues: Enabler (copy)
            Enabler(p24.Torso.Center, true);
        end },
    { 162, function(p27, p28, p29) -- Line: 110
            -- upvalues: Enabler (copy)
            Enabler(p27.Torso.Center, false);
        end },
    { 177, function(p30, p31, p32) -- Line: 118
            -- upvalues: Enabler (copy)
            shared.vfx.emit(p31.MVP1Particles.LandSoft);
            Enabler(p30["Right Leg"].RightFootAttachment.Spark, true);

            if p32 then
                Enabler(p32.Screen, true);
            end;

            local TweenService = game:GetService("TweenService");
            local SlideLight = p30.Torso.WaistFrontAttachment.SlideLight;
            SlideLight.Brightness = 35;
            TweenService:Create(SlideLight, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end },
    { 283, function(p33, p34, p35) -- Line: 137
            -- upvalues: Enabler (copy)
            Enabler(p33["Right Leg"].RightFootAttachment.Spark, false);
        end },
    { 306, function(p36, p37, p38) -- Line: 144
            -- upvalues: Enabler (copy)
            if p38 then
                Enabler(p38.Screen, false);
            end;

            Enabler(p36["Right Leg"].Attachment, false);
            Enabler(p36["Left Leg"].Attachment, false);
        end },
    { 343, function(p39, p40, p41) -- Line: 156
            shared.vfx.emit(p39["Right Arm"].RightGripAttachment);
            shared.vfx.emit(p40.MVP1Particles.LandSoft);
            shared.vfx.emit(p39.Head.Eye1);
            shared.vfx.emit(p39.HumanoidRootPart.ARank);
            local TweenService = game:GetService("TweenService");
            local EndLight = p39.Torso.WaistFrontAttachment.EndLight;
            EndLight.Brightness = 12;
            TweenService:Create(EndLight, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
            p39.Torso.WaistFrontAttachment.EndLight2.Enabled = true;
        end },
    { 600, function(p42, p43, p44) -- Line: 173
            -- upvalues: Enabler (copy)
            p42.Torso.WaistFrontAttachment.EndLight2.Enabled = false;
            Enabler(p43.Lower, false);

            if p44 then
                Enabler(p44.CamPart.Attachment, false);
            end;
        end }
};