  

local u3 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.CamZoom1);
            shared.vfx.emit(workspace.VFX.VFX["24/7Wind"]);
        end },
    { 15, function() -- Line: 6
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFX.Step);
            shared.vfx.emit(v1.Highlight:FindFirstChild("OutlineTransparency"));
        end },
    { 50, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.VFX.Grab);
        end },
    { 170, function() -- Line: 21
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFX.Shove);
            shared.vfx.emit(workspace.VFX.VFX.WindGust2);
            shared.vfx.emit(v2.Highlight);
        end }
};

return function(u4) -- Line: 36
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 37
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                local v6 = v[1];
                local v7 = v[2];

                if v6 <= CurrentFrame and v5 < v6 then
                    task.spawn(v7);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;