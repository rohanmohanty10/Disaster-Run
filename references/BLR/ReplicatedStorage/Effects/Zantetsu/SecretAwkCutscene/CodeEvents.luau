  

local u3 = {
    { 1, function() -- Line: 3
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and (child:GetAttribute("CutsceneChar") and child:FindFirstChild("HumanoidRootPart")) then
                    v1 = child;
                    break;
                end;
            end;

            assert(v1, "ZantetsuSecretAwk: replacement character missing");
            shared.vfx.emit(workspace.VFX.VFXCutscene.BlackBox);
            shared.vfx.emit(v1.Torso.FlowAuraTorso, v1.Torso.Lightning);
        end },
    { 190, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.VFXCutscene.BlackBox);
        end },
    { 372, function() -- Line: 19
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and (child:GetAttribute("CutsceneChar") and child:FindFirstChild("HumanoidRootPart")) then
                    v2 = child;
                    break;
                end;
            end;

            assert(v2, "ZantetsuSecretAwk: replacement character missing");
            shared.vfx.emit(v2.Torso.Lightning2);
            shared.vfx.emit(v2.Torso.Lightning3);
        end }
};

return function(u4) -- Line: 34
    -- upvalues: u3 (copy)
    local u5 = {};

    local function restoreField() -- Line: 38
        -- upvalues: u5 (copy)
        for i, v in u5 do
            if i.Parent then
                i.Transparency = v;
            end;
        end;

        table.clear(u5);
    end;

    local function hideField() -- Line: 44
        -- upvalues: u5 (copy)
        local Field = workspace:FindFirstChild("Field");

        if not Field then
            return;
        end;

        for _, descendant in Field:GetDescendants() do
            if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant.Transparency < 1 then
                u5[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end;

    task.spawn(function() -- Line: 56
        -- upvalues: u4 (copy), hideField (copy), u3 (ref), u5 (copy)
        local v8, v9 = xpcall(function() -- Line: 57
            -- upvalues: u4 (ref), hideField (ref), u3 (ref)
            local v6 = false;
            local v7 = 0;

            while u4:IsPlaying() do
                local CurrentFrame = u4.CurrentFrame;

                if CurrentFrame >= 190 and not v6 then
                    hideField();
                    v6 = true;
                end;

                for _, v in u3 do
                    if v[1] <= CurrentFrame and v7 < v[1] then
                        task.spawn(v[2]);
                    end;
                end;

                task.wait();
                v7 = CurrentFrame;
            end;
        end, debug.traceback);

        for i, v in u5 do
            if i.Parent then
                i.Transparency = v;
            end;
        end;

        table.clear(u5);

        if not v8 then
            warn("[ZantetsuSecretAwk field] " .. tostring(v9));
        end;
    end);
end;