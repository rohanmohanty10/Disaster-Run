 

 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.CamVFX.Winds);
            shared.vfx.emit(p1.Beams3);
            shared.vfx.emit(p1.Ball.II);
        end },
    { 50, function(p2) -- Line: 10
            shared.vfx.emit(p2.Ball.Impact);
        end },
    { 107, function(p3) -- Line: 15
            shared.vfx.emit(p3.CamVFX.Lines4, p3.CamVFX.Lines3, p3.CamVFX.Lines2);
        end },
    { 112, function(p4) -- Line: 20
            shared.vfx.emit(p4.CamVFX.smth);
            shared.vfx.emit(p4.Fire);
            shared.vfx.emit(p4.PointLight.Front);
        end },
    { 263, function(p5) -- Line: 28
            shared.vfx.emit(p5.FakeHead.Eyes);
            shared.vfx.emit(p5.CamVFX.Flare);
            shared.vfx.emit(p5.PointLight.Back.PointLight);
        end }
};