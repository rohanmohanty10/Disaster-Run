 
 

return {
    { 72, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.HumanoidRootPart.Push);

            if p2 then
                shared.vfx.emit(p2.camera.zoom2);
            end;
        end },
    { 202, function(p4, p5, p6, p7) -- Line: 11
            shared.vfx.emit(p7);
        end },
    { 238, function(p8, p9, p10) -- Line: 16
            if p9 then
                shared.vfx.emit(p9.camera.yukipaintsplatter);
                shared.vfx.emit(p9.camera.zoom3);
            end;
        end },
    { 244, function(p11, p12, p13) -- Line: 24
            shared.vfx.emit(p11.HumanoidRootPart.Attachment);
            shared.vfx.emit(p11.HumanoidRootPart["3"]);
        end },
    { 343, function(p14, p15, p16) -- Line: 30
            shared.vfx.emit(p14.Head.EyeFX.Left);
        end }
};