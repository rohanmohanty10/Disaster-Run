 
 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 5
            shared.vfx.emit(p4["Left Leg"].drag);
            shared.vfx.emit(p1.impact);
            shared.vfx.emit(p4.Head.Beam102, p4.Head.Beam106, p4.Head["BeamDrag again"], p4.Head.BeamSlash, p4.Head["BeamThick low glow"], p4["Left Arm"].Beam102, p4["Left Arm"].Beam106, p4["Left Arm"]["BeamDrag again"], p4["Left Arm"].BeamSlash, p4["Left Arm"]["BeamThick low glow"], p4["Left Leg"].Beam102, p4["Left Leg"].Beam106, p4["Left Leg"]["BeamDrag again"], p4["Left Leg"].BeamSlash, p4["Left Leg"]["BeamThick low glow"], p4["Right Arm"].Beam102, p4["Right Arm"].Beam106, p4["Right Arm"]["BeamDrag again"], p4["Right Arm"].BeamSlash, p4["Right Arm"]["BeamThick low glow"], p4["Right Leg"].Beam102, p4["Right Leg"].Beam106, p4["Right Leg"]["BeamDrag again"], p4["Right Leg"].BeamSlash, p4["Right Leg"]["BeamThick low glow"], p4.Torso.Beam102, p4.Torso.Beam106, p4.Torso["BeamDrag again"], p4.Torso.BeamSlash, p4.Torso["BeamThick low glow"]);
        end },
    { 18, function(p5, p6, p7, p8) -- Line: 13
            shared.vfx.emit(p5.shockwave1);
        end },
    { 87, function(p9, p10, p11, p12) -- Line: 19
            shared.vfx.emit(p12["Left Leg"].drag);
        end },
    { 102, function(p13, p14, p15, p16) -- Line: 25
            shared.vfx.emit(p13.steal);
        end },
    { 133, function(p17, p18, p19, p20) -- Line: 31
            shared.vfx.emit(p17.burst);
            shared.vfx.emit(p20["Left Leg"].drag);
        end },
    { 194, function(p21, p22, p23, p24) -- Line: 38
            shared.vfx.emit(p21.run);
        end },
    { 214, function(p25, p26, p27, p28) -- Line: 44
            shared.vfx.emit(p25.SPEEDBEAM);
            shared.vfx.emit(p25.meshrun);
            shared.vfx.emit(p25.burst2);
        end },
    { 343, function(p29, p30, p31, p32) -- Line: 52
            shared.vfx.emit(p29.kick);
            shared.vfx.emit(p32.Head.Beam102, p32.Head.Beam106, p32.Head["BeamDrag again"], p32.Head.BeamSlash, p32.Head["BeamThick low glow"], p32["Left Arm"].Beam102, p32["Left Arm"].Beam106, p32["Left Arm"]["BeamDrag again"], p32["Left Arm"].BeamSlash, p32["Left Arm"]["BeamThick low glow"], p32["Left Leg"].Beam102, p32["Left Leg"].Beam106, p32["Left Leg"]["BeamDrag again"], p32["Left Leg"].BeamSlash, p32["Left Leg"]["BeamThick low glow"], p32["Right Arm"].Beam102, p32["Right Arm"].Beam106, p32["Right Arm"]["BeamDrag again"], p32["Right Arm"].BeamSlash, p32["Right Arm"]["BeamThick low glow"], p32["Right Leg"].Beam102, p32["Right Leg"].Beam106, p32["Right Leg"]["BeamDrag again"], p32["Right Leg"].BeamSlash, p32["Right Leg"]["BeamThick low glow"], p32.Torso.Beam102, p32.Torso.Beam106, p32.Torso["BeamDrag again"], p32.Torso.BeamSlash, p32.Torso["BeamThick low glow"]);
        end },
    { 375, function(p33, p34, p35, p36) -- Line: 59
            shared.vfx.emit(p33.kick);
        end },
    { 402, function(p37, p38, p39, p40) -- Line: 65
            shared.vfx.emit(p37.kick2);
        end },
    { 430, function(p41, p42, p43, p44) -- Line: 71
            shared.vfx.emit(p41.kick3);
            shared.vfx.emit(p41.shine);
        end }
};