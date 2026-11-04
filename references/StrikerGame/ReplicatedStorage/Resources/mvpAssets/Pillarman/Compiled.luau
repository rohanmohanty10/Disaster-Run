 

 

return {
    { 311, function(p1) -- Line: 3
            shared.vfx.emit(p1.purplescreenstuff);
        end },
    { 758, function(p2) -- Line: 8
            shared.vfx.emit(p2.Dustupwards);
        end },
    { 859, function(p3) -- Line: 13
            shared.vfx.emit(p3.D2);
        end },
    { 952, function(p4, p5) -- Line: 18
            shared.vfx.emit(p4.RedScreemEff);
            p5.CFrame = p5.CFrame * CFrame.new(0, 30, 0);
        end }
};