 
 

return {
    { 9, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.Ball);
            shared.vfx.emit(p2.HumanoidRootPart.Attachment);
            shared.vfx.emit(p3.Part.Attachment3);
        end }
};