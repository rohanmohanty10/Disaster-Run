 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.work);
            shared.vfx.emit(p1.Flower2);
            shared.vfx.emit(p2.CamPart.Cut1);
        end },
    { 216, function(p3, p4, p5, p6) -- Line: 10
            shared.vfx.emit(p6.Head.scribbleeye1, p6.Head.scribbleeye15);
        end },
    { 354, function(p7, p8, p9) -- Line: 15
            shared.vfx.emit(p9.Head.Attachment);
            shared.vfx.emit(p9.Head.Eyes);
        end },
    { 506, function(p10, p11, p12) -- Line: 21
            shared.vfx.emit(p12["Left Arm"].huh);
        end },
    { 551, function(p13, p14, p15) -- Line: 26
            shared.vfx.emit(p14.CamPart.Cut4);
            shared.vfx.emit(p13.Flower1, p15.HumanoidRootPart.Pulse);
            shared.vfx.emit(p13["stara test"]);
            shared.vfx.emit(p14.CamPart["3"], p14.CamPart["1"]);
            shared.vfx.emit(p13.Flower1);
            shared.vfx.emit(p15.Torso.huh, p15.Torso.Attachment);
        end },
    { 749, function(p16, p17) -- Line: 38
            shared.vfx.emit(p17.CamPart.Cut5.Background);
        end }
};