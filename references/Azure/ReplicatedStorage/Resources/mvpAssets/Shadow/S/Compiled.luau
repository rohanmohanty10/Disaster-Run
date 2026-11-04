 
 

return {
    { 110, function(p1, p2, p3) -- Line: 3
            p1.emit(p2.fall);
        end },
    { 242, function(p4, p5, p6) -- Line: 8
            p4.emit(p5.smokeboom);
        end },
    { 292, function(p7, p8, p9) -- Line: 13
            p7.emit(p8["smoke happening"]);
        end },
    { 317, function(p10, p11, p12) -- Line: 18
            p10.emit(p12.Head.Attachment);
        end },
    { 375, function(p13, p14, p15) -- Line: 23
            p13.emit(p15.HumanoidRootPart.SRank);
        end }
};