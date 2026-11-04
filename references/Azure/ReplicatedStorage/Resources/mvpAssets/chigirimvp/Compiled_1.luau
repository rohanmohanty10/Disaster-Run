 
 

return {
    { 0, function(p1, p2, p3) -- Line: 5
            shared.vfx.emit(p1.Part);
        end },
    { 1, function(p4, p5, p6) -- Line: 11
            shared.vfx.emit(p5.CamPart);
        end },
    { 48, function(p7, p8, p9) -- Line: 17
            shared.vfx.emit(p7.chigiriskrrrt);
        end },
    { 130, function(p10, p11, p12) -- Line: 23
            shared.vfx.emit(p12.Head.Attachment["LE Multiple Spec 9"], p12.Head.Attachment["Multiple Specs 5"]);
        end }
};