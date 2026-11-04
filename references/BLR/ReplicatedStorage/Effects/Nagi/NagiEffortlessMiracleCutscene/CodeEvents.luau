  

local u4 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.Cam2, workspace.VFX.camvfx);
        end },
    { 252, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.Trap);
        end },
    { 302, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.Jump);
        end },
    { 346, function() -- Line: 10
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1["Left Leg"]);
        end },
    { 557, function() -- Line: 20
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v2["Left Leg"].FX);
        end },
    { 612, function() -- Line: 30
            local v3 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v3 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v3["Left Leg"].FX);
        end }
};

return function(u5) -- Line: 41
    -- upvalues: u4 (copy)
    task.spawn(function() -- Line: 42
        -- upvalues: u5 (copy), u4 (ref)
        local v6 = 0;

        while u5:IsPlaying() do
            local CurrentFrame = u5.CurrentFrame;

            for _, v in u4 do
                local v7 = v[1];
                local v8 = v[2];

                if v7 <= CurrentFrame and v6 < v7 then
                    task.spawn(v8);
                end;
            end;

            task.wait();
            v6 = CurrentFrame;
        end;
    end);
end;