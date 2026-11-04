 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.Model.Model.BACKGROUND);
            shared.vfx.emit(p1.SelectionBOX);
        end },
    { 101, function(p2) -- Line: 9
            shared.vfx.emit(p2.Impact["Spawn Arm"]);
        end },
    { 231, function(p3) -- Line: 14
            shared.vfx.emit(p3.Impact.Hit);
        end },
    { 275, function(p4) -- Line: 19
            shared.vfx.emit(p4["Transição"]);
        end },
    { 547, function(p5) -- Line: 24
            shared.vfx.emit(p5.Eyes);
        end },
    { 655, function(p6) -- Line: 29
            shared.vfx.emit(p6["Transição"]);
        end }
};