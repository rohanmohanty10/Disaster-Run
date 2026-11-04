 

 

local function xoeye(p1) -- Line: 1
    for _, child in p1.Head.XOEYE:GetChildren() do
        child:Emit(child:GetAttribute("EmitCount") or 10);
    end;
end;

return {
    { 0, function(p2) -- Line: 9
            for _, child in p2.HumanoidRootPart.CameraFlashes:GetChildren() do
                child.Enabled = true;
                child:Emit(child:GetAttribute("EmitCount") or 1);
            end;
        end },
    { 24, xoeye },
    { 100, xoeye },
    { 172, xoeye },
    { 238, xoeye }
};