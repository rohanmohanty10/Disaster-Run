 
 

return {
    { 80, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1["Right Arm"].Attachment);
        end },
    { 128, function(p4, p5, p6) -- Line: 10
            shared.vfx.emit(p5.MVP2Particles.Step.Attachment);
        end },
    { 198, function(p7, p8, p9) -- Line: 15
            shared.vfx.emit(p8.MVP2Particles.End);
            shared.vfx.emit(p7.Head.BRankEnd);
            shared.vfx.emit(p8.MVP2Particles.Background);
            shared.vfx.emit(p7.HumanoidRootPart.BRank);
            shared.vfx.emit(p8.MVP2Particles.Beams);
            local TweenService = game:GetService("TweenService");
            local EndLight = p7.Torso.WaistFrontAttachment.EndLight;
            EndLight.Brightness = 12;
            TweenService:Create(EndLight, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end }
};