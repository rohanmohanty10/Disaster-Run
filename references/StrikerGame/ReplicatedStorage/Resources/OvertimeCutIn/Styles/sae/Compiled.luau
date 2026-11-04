 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.ScreenEffect);
        end },
    { 8, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4.Head.redeye);
        end },
    { 101, function(p5, p6) -- Line: 13
            shared.vfx.emit(p6.HumanoidRootPart.Step2);
        end }
};