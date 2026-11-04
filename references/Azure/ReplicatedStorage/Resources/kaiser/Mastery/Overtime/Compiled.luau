 
 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            if p3 then
                shared.vfx.emit(p3.camera.Cut1);
            end;
        end },
    { 11, function(p4, p5) -- Line: 10
            shared.vfx.emit(p5.HumanoidRootPart.Stomp);
        end },
    { 103, function(p6, p7, p8) -- Line: 15
            if p8 then
                shared.vfx.emit(p8.camera.Cut2.Running);
            end;
        end },
    { 105, function(p9, p10) -- Line: 22
            shared.vfx.emit(p10.HumanoidRootPart.Steps);
        end },
    { 163, function(p11, p12, p13) -- Line: 27
            if p13 then
                shared.vfx.emit(p13.camera.Cut2.RTZ);
            end;
        end },
    { 250, function(p14, p15, p16) -- Line: 34
            if p16 then
                shared.vfx.emit(p16.camera.Cut3);
            end;
        end },
    { 306, function(p17, p18, p19, p20) -- Line: 41
            shared.vfx.emit(p20.Head, p20["Left Arm"], p20["Left Leg"], p20["Right Arm"], p20["Right Leg"], p20.Torso);
            shared.vfx.emit(p20.HumanoidRootPart.Pulse);
        end },
    { 473, function(p21, p22, p23) -- Line: 47
            shared.vfx.emit(p22.Head.Eyes);

            if p23 then
                shared.vfx.emit(p23.camera.Cut4);
            end;

            shared.vfx.emit(p22.HumanoidRootPart.Pulse);
            shared.vfx.emit(p21.Flower1, p21["stara test"]);
        end }
};