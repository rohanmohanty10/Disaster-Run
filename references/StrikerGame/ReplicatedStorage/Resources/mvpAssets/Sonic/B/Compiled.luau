 
 

return {
    { 24, function(p1) -- Line: 3
            shared.vfx.emit(p1.QuestionMark);
        end },
    { 86, function(p2) -- Line: 8
            shared.vfx.emit(p2.Dstartup);
        end },
    { 288, function(p3) -- Line: 13
            shared.vfx.emit(p3.Ranks);
        end },
    { 368, function(p4) -- Line: 18
            shared.vfx.emit(p4.RankAppear);
        end },
    { 370, function(p5) -- Line: 23
            shared.vfx.emit(p5.CameraFlash.ParticleEmitter, p5.CameraFlash:FindFirstChild("ParticleEmitter"));
        end }
};