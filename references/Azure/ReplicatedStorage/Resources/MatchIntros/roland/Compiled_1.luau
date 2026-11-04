 
 

local TweenService = game:GetService("TweenService");

return {
    { 0, function(p1, p2, p3, p4) -- Line: 5
            shared.vfx.emit(p1.Part4, p1.Part3, p1.Part2, p1.Part);
            p4.RolandEyeGlare.Main.ViewportFrame.ImageTransparency = 1;
            shared.vfx.emit(p3.vfx);
        end },
    { 430, function(p5, p6, p7, p8) -- Line: 12
            -- upvalues: TweenService (copy)
            local ViewportFrame = p8.RolandEyeGlare.Main.ViewportFrame;
            ViewportFrame.ImageTransparency = 1;
            TweenService:Create(ViewportFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0.5
            }):Play();
        end },
    { 706, function(p9, p10, p11, p12) -- Line: 19
            shared.vfx.emit(p11.Camera.take);
            shared.vfx.emit(p9.AngelaIntro.RootPart.Table1.CardDeck.Card);
            p12.RolandEyeGlare.Main.ViewportFrame.ImageTransparency = 1;
        end },
    { 826, function(p13) -- Line: 26
            shared.vfx.emit(p13.eheh);
        end },
    { 1048, function(p14) -- Line: 31
            shared.vfx.emit(p14.lighjtstuff);
        end },
    { 1154, function(p15, p16, p17, p18) -- Line: 36
            shared.vfx.emit(p17.Camera.todoku);
            shared.vfx.emit(p15.kaashi.Attachment3);
        end }
};