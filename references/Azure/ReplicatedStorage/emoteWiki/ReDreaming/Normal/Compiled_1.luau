 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.Midfx);
        end },
    { 200, function(p2, p3) -- Line: 8
            if p3 then
                p3(true);
            end;
        end },
    { 387, function(p4, p5) -- Line: 15
            if p5 then
                p5(false);
            end;
        end },
    { 530, function(p6) -- Line: 22
            shared.vfx.emit(p6.Heartfx);
        end },
    { 709, function(p7) -- Line: 27
            local v8 = p7:FindFirstChild("Left Arm");

            if v8 then
                v8 = v8:FindFirstChild("bang");
            end;

            if v8 then
                shared.vfx.emit(v8);
            end;
        end },
    { 1020, function(p9) -- Line: 36
            shared.vfx.emit(p9.Glitchfx);
        end },
    { 1310, function(p10) -- Line: 41
            shared.vfx.emit(p10.Lightfx);
        end }
};