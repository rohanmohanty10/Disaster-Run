 
 

return {
    { 42, function(p1) -- Line: 4
            shared.vfx.emit(p1.Step1);
        end },
    { 70, function(p2) -- Line: 10
            shared.vfx.emit(p2.Step2);
        end },
    { 100, function(p3) -- Line: 16
            shared.vfx.emit(p3.Step3);
        end },
    { 130, function(p4) -- Line: 22
            shared.vfx.emit(p4.Step4);
        end },
    { 162, function(p5) -- Line: 28
            shared.vfx.emit(p5.Step5);
        end },
    { 714, function(p6) -- Line: 34
            shared.vfx.emit(p6.halftone);
        end }
};