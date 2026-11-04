  

local u2 = {
    { 1, function() -- Line: 3
            shared.vfx.emit(workspace.VFX.VFXCutscene.BlackBox);
        end },
    { 1, function() -- Line: 6
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and (child:GetAttribute("CutsceneChar") and child:FindFirstChild("HumanoidRootPart")) then
                    v1 = child;
                    break;
                end;
            end;

            assert(v1, "ZantetsuLocalExpressBulletTrain: replacement character missing");
            shared.vfx.emit(workspace.VFX.VFXCutscene.CamZoom);
            shared.vfx.emit(v1.Torso.Lightning, v1.Torso.FlowAuraTorso);
        end },
    { 424, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.VFXCutscene.Shot);
        end }
};

return function(u3) -- Line: 24
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 25
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                if v[1] <= CurrentFrame and v4 < v[1] then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;