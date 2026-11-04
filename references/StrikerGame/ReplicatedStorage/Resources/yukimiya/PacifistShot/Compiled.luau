 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.startsmoke);
            shared.vfx.emit(p1.TemplateR6.Torso, p1.TemplateR6["Right Leg"], p1.TemplateR6["Right Arm"], p1.TemplateR6["Left Leg"], p1.TemplateR6.Head);
        end },
    { 60, function(p2) -- Line: 9
            shared.vfx.emit(p2.bachirabeeshotdomain);
        end },
    { 184, function(p3, p4) -- Line: 14
            shared.vfx.emit(p4.Ball.BallSpeed1.yes);
        end },
    { 198, function(p5, p6) -- Line: 19
            shared.vfx.emit(p6.Ball.Attachment);
        end },
    { 213, function(p7, p8) -- Line: 24
            shared.vfx.emit(p8.Ball.Attachment);
            shared.vfx.emit(p7.TemplateR6.HumanoidRootPart.Attachment);
        end },
    { 393, function(p9, p10) -- Line: 30
            shared.vfx.emit(p10.Ball.lines1, p10.Ball.lines2);
        end },
    { 490, function(p11, p12) -- Line: 35
            for _, descendant in p12:GetDescendants() do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};