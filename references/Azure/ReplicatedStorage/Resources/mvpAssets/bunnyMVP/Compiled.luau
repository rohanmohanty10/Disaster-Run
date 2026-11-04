 
 

return {
    { 9, function(p1, p2, p3, p4) -- Line: 5
            shared.vfx.emit(p1.landing);
        end },
    { 115, function(p5, p6, p7, p8) -- Line: 11
            shared.vfx.emit(p7.Head);
        end },
    { 205, function(p9, p10, p11, p12) -- Line: 17
            local CaptureService = game:GetService("CaptureService");
            local Screen = p9.House["Sae stuff"].Walls.Screen;
            CaptureService:CaptureScreenshot(function(p13) -- Line: 22
                -- upvalues: Screen (copy)
                if not (p13 and Screen.Parent) then
                    return;
                end;

                Screen.SurfaceGui.Frame.ImageLabel.Image = p13;
            end);
        end },
    { 638, function(p14, p15, p16, p17) -- Line: 35
            shared.vfx.emit(p17);
        end }
};