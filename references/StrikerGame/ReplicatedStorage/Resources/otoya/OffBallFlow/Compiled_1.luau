 
 

return {
    { 60, function(p1) -- Line: 3
            shared.vfx.emit(p1.Folder.DashPart);
        end },
    { 222, function(p2) -- Line: 8
            shared.vfx.emit(p2.Folder.DashPart2);
        end }
};