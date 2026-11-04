 
 

return {
    { 6, function(p1) -- Line: 3
            shared.vfx.emit(p1.ScreenEffect);
        end },
    { 78, function(p2) -- Line: 8
            shared.vfx.emit(p2.Borderline.ShootEmit, p2.Borderline.GroundVFX);
        end }
};