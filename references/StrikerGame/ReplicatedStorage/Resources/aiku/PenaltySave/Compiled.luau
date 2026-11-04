 

 

return {
    { 10, function(p1) -- Line: 3
            shared.vfx.emit(p1.HumanoidRootPart.Grass1);
        end },
    { 79, function(p2) -- Line: 8
            shared.vfx.emit(p2.HumanoidRootPart.Headbutt);
            shared.vfx.emit(p2.Ball);
        end },
    { 138, function(p3) -- Line: 14
            shared.vfx.emit(p3.Head.blueeye, p3.Head.greeneye);
        end }
};