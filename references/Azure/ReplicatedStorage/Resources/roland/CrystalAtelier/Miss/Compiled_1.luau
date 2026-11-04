 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.Slash);
        end },
    { 36, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4.LeftHandle, p4.RightHandle);
        end },
    { 37, function(p5, p6) -- Line: 13
            for _, v in { p6.RightHandle, p6.LeftHandle } do
                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("MeshPart") then
                        descendant.Transparency = 1;
                    end;
                end;
            end;
        end }
};