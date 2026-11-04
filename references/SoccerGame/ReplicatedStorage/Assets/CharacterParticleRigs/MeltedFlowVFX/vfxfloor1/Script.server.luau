  

if not script:IsDescendantOf(workspace) then
    return;
end;

game:GetService("RunService").RenderStepped:Connect(function() -- Line: 6
    script.Parent.Transparency = 1;
end);