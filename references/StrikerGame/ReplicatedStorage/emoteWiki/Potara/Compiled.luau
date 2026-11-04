 

 

return {
    { 41, function(p1) -- Line: 3
            shared.vfx.emit(p1["R6 L"]["Right Arm"].e1);
        end },
    { 49, function(p2) -- Line: 8
            shared.vfx.emit(p2["R6 R"].right["Cube.002"].Attachment);
        end },
    { 84, function(p3) -- Line: 13
            shared.vfx.emit(p3["R6 R"].Head.Attachment);
        end },
    { 133, function(p4) -- Line: 18
            shared.vfx.emit(p4["R6 R"]["Right Arm"].e1);
        end },
    { 240, function(p5) -- Line: 23
            shared.vfx.emit(p5["R6 R"].Torso.Attachment);
            shared.vfx.emit(p5["R6 L"].Torso.Attachment);
        end },
    { 258, function(p6) -- Line: 29
            shared.vfx.emit(p6["TemplateR6 Both"].HumanoidRootPart.Attachment);
        end },
    { 294, function(p7) -- Line: 34
            shared.vfx.emit(p7["TemplateR6 Both"].HumanoidRootPart.Aura);
        end }
};