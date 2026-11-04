  

local u3 = {
    { 1, function() -- Line: 3
            shared.vfx.emit(workspace.VFX.Blr.CamPart.start, workspace.VFX.Blr.CamPart.startt);
            shared.vfx.emit(workspace.VFX.VFX.Particles);
        end },
    { 25, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX.AuraBeamsEmit2);
        end },
    { 79, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.Blr.CamPart.midd, workspace.VFX.Blr.CamPart.mid);
        end },
    { 204, function() -- Line: 13
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and (child:GetAttribute("CutsceneChar") and child:FindFirstChild("HumanoidRootPart")) then
                    v1 = child;
                    break;
                end;
            end;

            assert(v1, "ZantetsuAwk: replacement character missing");
            shared.vfx.emit(v1.Head.FX);
        end },
    { 273, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.Blr.CamPart.ENDd, workspace.VFX.Blr.CamPart.END);
        end },
    { 283, function() -- Line: 27
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and (child:GetAttribute("CutsceneChar") and child:FindFirstChild("HumanoidRootPart")) then
                    v2 = child;
                    break;
                end;
            end;

            assert(v2, "ZantetsuAwk: replacement character missing");
            shared.vfx.emit(v2.Torso);
        end }
};

return function(u4) -- Line: 40
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 41
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                if v[1] <= CurrentFrame and v5 < v[1] then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;