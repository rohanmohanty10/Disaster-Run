 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.HumanoidRootPart["1"]);
        end },
    { 22, function(p2) -- Line: 8
            shared.vfx.emit(p2.HumanoidRootPart.Dash);
            shared.vfx.emit(p2.HumanoidRootPart.Burst);
        end },
    { 63, function(p3) -- Line: 14
            shared.vfx.emit(p3.HumanoidRootPart.Dash);
            shared.vfx.emit(p3.HumanoidRootPart["3"], p3.HumanoidRootPart["2"]);
        end },
    { 110, function(p4) -- Line: 20
            shared.vfx.emit(p4.HumanoidRootPart.Spin);
        end },
    { 127, function(p5) -- Line: 25
            shared.vfx.emit(p5.HumanoidRootPart.Dash);
            shared.vfx.emit(p5.HumanoidRootPart.f30Enabled);
            shared.vfx.emit(p5.HumanoidRootPart.Burst);
        end }
};