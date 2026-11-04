 

 

return {
    { 20, function(p1, p2) -- Line: 3
            for _, v in { p2.RightHandle, p2.LeftHandle } do
                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("MeshPart") then
                        descendant.Transparency = 0;
                    end;
                end;
            end;

            shared.vfx.emit(p2.RightHandle, p2.LeftHandle);
        end }
};