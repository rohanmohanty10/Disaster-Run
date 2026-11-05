  

 

return function(p1, p2) -- Line: 1
    local TargetHighlight = p1:FindFirstChild("TargetHighlight");

    if not p2 then
        if TargetHighlight then
            TargetHighlight:Destroy();
        end;

        return;
    end;

    if p2 and not TargetHighlight then
        TargetHighlight = Instance.new("Highlight");
        TargetHighlight.Name = "TargetHighlight";
        TargetHighlight.Parent = p1;
    end;

    TargetHighlight:SetAttribute("Count", (TargetHighlight:GetAttribute("Count") or 0) + 1);
    local v3 = TargetHighlight:GetAttribute("Count");

    if p2.Properties then
        for i, v in pairs(p2.Properties) do
            TargetHighlight[i] = v;
        end;
    end;

    if p2.TweenProperties then
        local v4 = game:GetService("TweenService"):Create(TargetHighlight, p2.TweenInfo and TweenInfo.new(unpack(p2.TweenInfo)) or TweenInfo.new(1), p2.TweenProperties);
        v4:Play();

        if p2.DestroyAfterTween then
            v4.Completed:Wait();

            if v4.PlaybackState == Enum.PlaybackState.Completed and TargetHighlight:GetAttribute("Count") == v3 then
                TargetHighlight:Destroy();
            end;
        end;
    end;
end;