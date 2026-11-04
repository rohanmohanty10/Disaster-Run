  

local u3 = {
    { 8, function() -- Line: 1
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFXCutscene.StartupSimple);
            shared.vfx.emit(workspace.VFX.VFXCutscene.PaintScreen1);
            shared.vfx.emit(workspace.VFX.VFXCutscene.CamZoom);
            shared.vfx.emit(v1.Highlight:FindFirstChild("OutlineTransparency"));
            shared.vfx.emit(workspace.VFX.VFXCutscene.Constant);
        end },
    { 92, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.VFXCutscene.Startup2);
        end },
    { 268, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.VFXCutscene.WingsDash);
        end },
    { 361, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.VFXCutscene.BallControl);
        end },
    { 452, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.VFXCutscene.Background);
        end },
    { 589, function() -- Line: 31
            shared.vfx.emit(workspace.VFX.VFXCutscene.WingsTest);
        end },
    { 597, function() -- Line: 34
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v2.Highlight);
            shared.vfx.emit(workspace.VFX.VFXCutscene.PaintScreen2);
            shared.vfx.emit(workspace.VFX.VFXCutscene.CamZoom2);
            shared.vfx.emit(workspace.VFX.VFXCutscene.Shot);
        end }
};

return function(u4) -- Line: 51
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 52
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