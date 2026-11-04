 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            if p1 then
                shared.vfx.emit(p1.firstglow);
            end;
        end },
    { 208, function(p4, p5, p6, p7) -- Line: 10
            shared.vfx.emit(p7.Stomp1FX);
        end },
    { 225, function(p8, p9, p10) -- Line: 15
            if p8 then
                shared.vfx.emit(p8["TransitionFX1.1"], p8.TransitionFX1, p8["TransitionFX1.2"]);
            end;
        end },
    { 248, function(p11, p12, p13) -- Line: 22
            shared.vfx.emit(p12.FirstJump);
        end },
    { 332, function(p14, p15, p16) -- Line: 27
            if p14 then
                shared.vfx.emit(p14["TransitionFX2.1"], p14.TransitionFX2);
            end;
        end },
    { 341, function(p17, p18, p19) -- Line: 34
            if p17 then
                shared.vfx.emit(p17.sM1L);
                shared.vfx.emit(p17.Wind);
                shared.vfx.emit(p17.glow);
                shared.vfx.emit(p17.CamVFXonDimension);
            end;
        end },
    { 355, function(p20, p21, p22, p23) -- Line: 44
            shared.vfx.emit(p23.Stomp2);
        end },
    { 475, function(p24, p25, p26) -- Line: 49
            if p24 then
                shared.vfx.emit(p24.EndSuckInVFXforCamEye);
                shared.vfx.emit(p24.EndTranisiton1, p24.EndTransition2);
                shared.vfx.emit(p24.LastBeam);
                shared.vfx.emit(p24.glow3);
            end;

            shared.vfx.emit(p26.ChameleonEye);
        end }
};