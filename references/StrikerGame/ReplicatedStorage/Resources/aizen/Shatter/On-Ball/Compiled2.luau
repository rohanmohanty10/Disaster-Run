 

 

return {
    { 15, function(p1) -- Line: 3
            warn(p1);
            local shared_vfx = shared.vfx;
            warn(p1.dribble2);
            shared_vfx.emit(p1.dribble2.kick1, p1.KJ.Highlight, p1.KJ.Torso.SpeedLinesAtt);
        end },
    { 35, function(p2) -- Line: 15
            shared.vfx.emit(p2.dribble2.smoke);
        end },
    { 60, function(p3) -- Line: 25
            shared.vfx.emit(p3.dribble2.kick2, p3.KJ.Highlight);
        end },
    { 75, function(p4) -- Line: 36
            shared.vfx.emit(p4.dribble2.smoke);
        end },
    { 97, function(p5) -- Line: 46
            local Lighting = game:GetService("Lighting");
            shared.vfx.emit(p5.dribble2.kick3, p5.KJ.Highlight, Lighting.purple1);
        end },
    { 117, function(p6) -- Line: 59
            shared.vfx.emit(p6.dribble2.smoke1);
        end }
};