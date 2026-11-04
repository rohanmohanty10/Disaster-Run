 
 

return {
    { 1196, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.Head.Part);
            shared.vfx.emit(p2.Head.woahh);
        end },
    { 1554, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4["Left Arm"].RightAttachment, p4.Mask.Attachment);
        end },
    { 1783, function(p5, p6) -- Line: 13
            shared.vfx.emit(p6.Beeper.aaa);
        end },
    { 1891, function(p7, p8) -- Line: 18
            shared.vfx.emit(p8.Beeper.Attachment, p8.Head.Attachment);
        end },
    { 2247, function(p9, p10) -- Line: 23
            shared.vfx.emit(p9.hit);
        end },
    { 2251, function(p11, p12) -- Line: 28
            shared.vfx.emit(p12.Oracle["oracle handle"].Attachment);
        end },
    { 2257, function(p13, p14) -- Line: 33
            shared.vfx.emit(p14.Torso);
        end },
    { 2335, function(p15, p16) -- Line: 38
            shared.vfx.emit(p15.Meshfx);
        end }
};