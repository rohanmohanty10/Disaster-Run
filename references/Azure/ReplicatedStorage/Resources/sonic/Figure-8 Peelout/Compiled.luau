 
 

return {
    { 21, function(p1) -- Line: 6
            shared.vfx.emit(p1.HumanoidRootPart.RunStart);
        end },
    { 64, function(p2) -- Line: 13
            shared.vfx.emit(p2.RunMeshes, p2.HumanoidRootPart.Run);
        end },
    { 128, function(p3) -- Line: 20
            shared.vfx.emit(p3.Torso.End);
        end }
};