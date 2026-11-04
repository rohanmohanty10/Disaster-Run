 

 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.VFX.StartBeams);
        end },
    { 166, function(p3, p4, p5, p6) -- Line: 8
            shared.vfx.emit(p6.HumanoidRootPart.VFXHandler.CE);
        end },
    { 236, function(p7, p8) -- Line: 13
            shared.vfx.emit(p7.VFX.Transition);
        end },
    { 328, function(p9, p10, p11, p12) -- Line: 18
            shared.vfx.emit(p12.Torso.KC);
            require(script.DiavoloUtils).hideMap(p9["Diavolo MVP"]);
            shared.vfx.emit(p10.CamPart.GalaxyCam);
            shared.vfx.emit(p9["ROCKS!"]);
            shared.vfx.emit(p9.VFX.Space);
            shared.vfx.emit(p9["SPECS SSSS"]);
        end },
    { 505, function(p13, p14) -- Line: 28
            shared.vfx.emit(p13.VFX.Upstairs);
        end },
    { 858, function(p15, p16, p17) -- Line: 33
            shared.vfx.emit(p17.Head.AURA, p17["Left Arm"].AURA, p17["Left Leg"].AURA, p17["Right Arm"].AURA, p17["Right Leg"].AURA, p17.Torso.AURA, p17.Highlight);
        end },
    { 1060, function(p18, p19) -- Line: 38
            require(script.DiavoloUtils).showMap(p18["Diavolo MVP"]);
        end },
    { 1119, function(p20, p21) -- Line: 43
            shared.vfx.emit(p20.VFX.Upstairs);
        end },
    { 1402, function(p22, p23) -- Line: 48
            shared.vfx.emit(p22.VFX.Closeup);
        end }
};