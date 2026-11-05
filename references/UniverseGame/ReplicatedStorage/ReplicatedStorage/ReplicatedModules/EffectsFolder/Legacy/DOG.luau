  

 

return function(u1) -- Line: 1
    local u2 = nil;
    u2 = game:GetService("RunService").RenderStepped:Connect(function(p3) -- Line: 3
        -- upvalues: u1 (copy), u2 (ref), u1 (copy)
        if u1 == nil or not u1:IsDescendantOf(workspace) then
            u2:Disconnect();

            return;
        end;

        for i, child in pairs(u1:GetChildren()) do
            if i > 1 and (child:IsA("BasePart") and not child.p1.Anchored) then
                local v4 = (CFrame.new((u1:GetChildren()[i - 1].CFrame * CFrame.new(0, 0, 1)).p, child.CFrame.p) * CFrame.new(0, 0, -1) * CFrame.Angles(0, 3.141592653589793, 0)):Lerp(u1:GetChildren()[i - 1].CFrame * CFrame.new(0, 0, 2), (math.clamp(p3 * 5, 0, 1)));

                if v4.p.Magnitude < 9999999 then
                    child.CFrame = v4;
                end;
            end;
        end;
    end);
end;