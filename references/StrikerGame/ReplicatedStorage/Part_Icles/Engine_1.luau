 
 

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Events = require(script.Parent.Events);
local EventsCollision = require(script.Parent.EventsCollision);
local Pool = require(script.Parent.Pool);
local Apply = require(script.Parent.CameraShake.Apply);
local VisualHost = require(script.Parent.VisualHost);
local EngineAttr = require(script.Parent.EngineAttr);
local Canvas = require(script.Parent.Distortion.Canvas);
local Log = require(script.Parent.Log);
local DecalLayers = require(script.Parent.DecalLayers);
local MeshFrames = require(script.Parent.MeshFrames);
local AtRest = require(script.Parent.AtRest);
local u1 = 0;
local u2 = tostring({}):match("0x(%x+)") or tostring(math.random(1000000000));

return function(p3) -- Line: 36
    -- upvalues: RunService (copy), UserInputService (copy), Events (copy), Pool (copy), VisualHost (copy), Apply (copy), Canvas (copy), EventsCollision (copy), EngineAttr (copy), DecalLayers (copy), MeshFrames (copy), AtRest (copy), Log (copy), u1 (ref), u2 (copy)
    function p3.Activate(u4) -- Line: 39
        -- upvalues: RunService (ref), UserInputService (ref), Events (ref), Pool (ref), VisualHost (ref), Apply (ref), Canvas (ref), EventsCollision (ref), EngineAttr (ref), DecalLayers (ref), MeshFrames (ref), AtRest (ref), Log (ref), u1 (ref), u2 (ref)
        if u4.Connection then
            return;
        end;

        u4._engineGen = (u4._engineGen or 0) + 1;
        u4._notActivatedWarned = false;

        if RunService:IsClient() then
            if not u4._focusConn then
                u4._focusConn = UserInputService.WindowFocused:Connect(function() -- Line: 52
                    -- upvalues: u4 (copy)
                    u4._focused = true;
                    u4._unfocusedAt = 0;
                end);
            end;

            if not u4._blurConn then
                u4._blurConn = UserInputService.WindowFocusReleased:Connect(function() -- Line: 58
                    -- upvalues: u4 (copy)
                    u4._focused = false;
                    u4._unfocusedAt = os.clock();
                end);
            end;
        end;

        for _, v in ipairs({
            workspace,
            game:GetService("Lighting"),
            game:GetService("ReplicatedStorage"),
            game:GetService("StarterGui"),
            game:GetService("StarterPack"),
            game:GetService("ReplicatedFirst")
        }) do
            pcall(function() -- Line: 74
                -- upvalues: u4 (copy), v (copy)
                u4:Preload(v, false);
            end);
        end;

        local function u25(p5) -- Line: 77
            -- upvalues: Events (ref), Pool (ref), VisualHost (ref), u4 (copy), Apply (ref), Canvas (ref), EventsCollision (ref), EngineAttr (ref), DecalLayers (ref), MeshFrames (ref), AtRest (ref), Log (ref)
            Events.tickFrame();
            local os_clock_ret = os.clock();
            Pool.tick(os_clock_ret);
            VisualHost.tick();
            local ActiveEmits = u4.ActiveEmits;

            if #ActiveEmits == 0 then
                Apply.applyFrame();
                Canvas.applyFrame();

                return;
            end;

            local workspace_CurrentCamera = workspace.CurrentCamera;
            local v6;

            if workspace_CurrentCamera then
                v6 = workspace_CurrentCamera.CFrame.Position;
            else
                v6 = nil;
            end;

            u4:_handOverReached(os_clock_ret);
            u4._inStep = true;
            local v7 = 1;

            while v7 <= #ActiveEmits do
                local u8 = ActiveEmits[v7];
                local v9 = u8._forceDead == true;
                local CurrentStep = u8.CurrentStep;

                if not v9 then
                    if u8.Type == "Part" then
                        v9 = u4:UpdatePart(u8, p5, os_clock_ret);
                    elseif u8.Type == "Beam" then
                        v9 = u4:UpdateBeam(u8, p5, os_clock_ret);
                    elseif u8.Type == "PointLight" then
                        v9 = u4:UpdatePointLight(u8, p5, os_clock_ret);
                    elseif u8.Type == "Highlight" then
                        v9 = u4:UpdateHighlight(u8, p5, os_clock_ret);
                    elseif u8.Type == "TrailEmitter" then
                        v9 = u4:UpdateTrail(u8, p5, os_clock_ret);
                    elseif u8.Type == "Attachment" then
                        v9 = u4:UpdateAttachment(u8, p5, os_clock_ret);
                    elseif u8.Type == "Model" then
                        v9 = u4:UpdateModel(u8, p5, os_clock_ret);
                    elseif u8.Type == "Screen" then
                        v9 = u4:UpdateScreen(u8, p5, os_clock_ret);
                    elseif u8.Type == "ImageLabel" then
                        v9 = u4:UpdateImageLabel(u8, p5, os_clock_ret);
                    elseif u8.Type == "Lightning" then
                        v9 = u4:UpdateLightning(u8, p5, os_clock_ret);
                    elseif u8.Type == "CameraShake" then
                        v9 = u4:UpdateCameraShake(u8, p5, os_clock_ret);
                    elseif u8.Type == "Sound" then
                        v9 = u4:UpdateSound(u8, p5, os_clock_ret);
                    elseif u8.Type == "Rocks" then
                        v9 = u4:UpdateRocks(u8, p5, os_clock_ret);
                    elseif u8.Type == "Rope" then
                        v9 = u4:UpdateRope(u8, p5, os_clock_ret);
                    elseif u8.Type == "Distortion" then
                        v9 = u4:UpdateDistortion(u8, p5, os_clock_ret);
                    elseif u8.Type == "Container" then
                        v9 = u4:UpdateContainer(u8, p5, os_clock_ret);
                    elseif u8.Type == "Force" then
                        v9 = u4:UpdateForce(u8, p5, os_clock_ret);
                    elseif u8.Type == "Matte" then
                        v9 = u4:UpdateMatte(u8, p5, os_clock_ret);
                    elseif u8.Type == "Reactor" then
                        v9 = u4:UpdateReactor(u8, p5, os_clock_ret);
                    end;
                end;

                if not v9 then
                    if u8.Link then
                        u4:ReapplyLink(u8);
                    end;

                    local Type = u8.Type;

                    if u8._settleEngaged and not (u8._collisionStopped or Type ~= "Part" and (Type ~= "Model" and Type ~= "Attachment")) then
                        EventsCollision.applySettle(u8, p5);
                    end;

                    if (Type == "Part" or (Type == "Model" or Type == "Attachment")) and (u8.Link or u8.CurrentStep ~= CurrentStep) then
                        u8._postUpdateCF = Type == "Model" and u8.VisualPart:GetPivot() or u8.VisualPart.CFrame;
                    end;

                    if u8.Orientation and u8.Orientation ~= "None" then
                        u4:ApplyOrientation(u8, p5, v6);
                    end;

                    if u8.ZOffset and u8.ZOffset ~= 0 then
                        u4:ApplyZOffset(u8, v6);
                    end;
                end;

                Events.afterUpdate(u4, u8, v9, os_clock_ret);

                if v9 then
                    u4:_fireOnDeath(u8);

                    if u8.IsAnimate then
                        local v10;

                        if u8._playToken == nil then
                            v10 = false;
                        else
                            v10 = u8._playToken.Alive == false;
                        end;

                        if v10 or not (u8.AnimateItem and (u8.AnimateItem.Parent and u8.AnimateItem:GetAttribute("AnimateLoop"))) then
                            local VisualPart = u8.VisualPart;
                            local Type = u8.Type;
                            local InitialAnchorCF = u8.InitialAnchorCF;
                            local InitialScale = u8.InitialScale;
                            local HasDecal = u8.HasDecal;
                            local AnimateItem = u8.AnimateItem;
                            local v11 = u8.PartLife or 0;
                            local u12 = u4:_isLiveRTAnimate(u8);
                            local u13;

                            if AnimateItem then
                                u13 = (AnimateItem:GetAttribute("_animateFinishGen") or 0) + 1;
                                EngineAttr.write(AnimateItem, "_animateFinishGen", u13);
                            else
                                u13 = nil;
                            end;

                            local function finishAnimate() -- Line: 210
                                -- upvalues: VisualPart (copy), u12 (copy), AnimateItem (copy), u4 (ref), u13 (ref), u8 (copy), InitialAnchorCF (copy), Type (copy), InitialScale (copy), DecalLayers (ref), MeshFrames (ref), AtRest (ref), HasDecal (copy)
                                if not (VisualPart and VisualPart.Parent) then
                                    return;
                                end;

                                if u12 and (AnimateItem and u4.ActiveAnimates[AnimateItem]) then
                                    return;
                                end;

                                if AnimateItem and (AnimateItem.Parent and (u13 and AnimateItem:GetAttribute("_animateFinishGen") ~= u13)) then
                                    return;
                                end;

                                u4:_fireOnDestruction(u8, VisualPart);

                                if InitialAnchorCF then
                                    if Type == "Model" then
                                        pcall(function() -- Line: 220
                                            -- upvalues: VisualPart (ref), InitialAnchorCF (ref)
                                            VisualPart:PivotTo(InitialAnchorCF);
                                        end);

                                        if InitialScale then
                                            pcall(function() -- Line: 221
                                                -- upvalues: VisualPart (ref), InitialScale (ref)
                                                VisualPart:ScaleTo(InitialScale);
                                            end);
                                        end;
                                    else
                                        pcall(function() -- Line: 222
                                            -- upvalues: VisualPart (ref), InitialAnchorCF (ref)
                                            VisualPart.CFrame = InitialAnchorCF;
                                        end);
                                    end;
                                end;

                                if Type == "Screen" or (Type == "ImageLabel" or (Type == "Lightning" or (Type == "Rocks" or Type == "Rope"))) then
                                    pcall(function() -- Line: 225
                                        -- upvalues: VisualPart (ref)
                                        VisualPart:Destroy();
                                    end);

                                    return;
                                end;

                                if Type == "Beam" or (Type == "Highlight" or Type == "TrailEmitter") then
                                    local u14 = u8.BeamSnapshot or (u8.HighlightSnapshot or u8.TrailEmitterSnapshot);

                                    if u14 then
                                        pcall(function() -- Line: 229
                                            -- upvalues: u14 (copy), VisualPart (ref)
                                            for i, v in pairs(u14) do
                                                VisualPart[i] = v;
                                            end;
                                        end);
                                    end;

                                    pcall(function() -- Line: 231
                                        -- upvalues: VisualPart (ref)
                                        VisualPart.Enabled = false;
                                    end);

                                    return;
                                end;

                                DecalLayers.restore(u8);
                                MeshFrames.restore(u8);
                                AtRest.rest(VisualPart);
                                pcall(function() -- Line: 236
                                    -- upvalues: VisualPart (ref), HasDecal (ref), u8 (ref)
                                    VisualPart.Transparency = 1;
                                    local v15 = HasDecal and VisualPart:FindFirstChildOfClass("Decal");

                                    if v15 then
                                        v15.Transparency = 1;
                                    end;

                                    local v16 = u8._initialSAColor and VisualPart:FindFirstChildOfClass("SurfaceAppearance");

                                    if v16 then
                                        v16.Color = u8._initialSAColor;
                                    end;

                                    if u8._initialPartColor and VisualPart:IsA("BasePart") then
                                        VisualPart.Color = u8._initialPartColor;
                                    end;
                                end);
                            end;

                            u4.ActiveAnimates[AnimateItem] = nil;

                            if v11 > 0 then
                                task.delay(v11, finishAnimate);
                            else
                                finishAnimate();
                            end;

                            u4:_reclaimPData(u8);

                            if ActiveEmits[v7] == u8 then
                                local v17 = #ActiveEmits;

                                if v7 < v17 then
                                    ActiveEmits[v7] = ActiveEmits[v17];
                                end;

                                ActiveEmits[v17] = nil;
                            end;
                        else
                            u4:_replayAnimateCycle(u8, os_clock_ret);
                            v7 = v7 + 1;
                        end;
                    else
                        local VisualPart = u8.VisualPart;

                        if u8.PartLife and u8.PartLife > 0 then
                            local _sourceItem = u8._sourceItem;

                            if _sourceItem and VisualPart then
                                u4._lingerByItem = u4._lingerByItem or {};
                                local v18 = u4._lingerByItem[_sourceItem] or {};
                                table.insert(v18, VisualPart);
                                u4._lingerByItem[_sourceItem] = v18;
                                pcall(function() -- Line: 273
                                    -- upvalues: VisualPart (copy)
                                    VisualPart:SetAttribute("_lingerCounted", true);
                                end);
                                local v19 = u4;
                                v19._lingerVisualCount = v19._lingerVisualCount + 1;
                            end;

                            u8._lingerStartTime = os.clock();
                            task.delay(u8.PartLife, function() -- Line: 280
                                -- upvalues: u4 (ref), u8 (copy), VisualPart (copy), _sourceItem (copy)
                                u4:_fireOnDestruction(u8, VisualPart);

                                if VisualPart then
                                    local u20 = false;
                                    pcall(function() -- Line: 284
                                        -- upvalues: u20 (ref), VisualPart (ref)
                                        u20 = VisualPart:GetAttribute("_lingerCounted") == true;
                                    end);

                                    if u20 then
                                        u4._lingerVisualCount = math.max(0, (u4._lingerVisualCount or 0) - 1);
                                        pcall(function() -- Line: 287
                                            -- upvalues: VisualPart (ref)
                                            VisualPart:SetAttribute("_lingerCounted", nil);
                                        end);
                                    end;

                                    u4:_releaseOrDestroy(u8, VisualPart);
                                end;

                                if _sourceItem and (u4._lingerByItem and u4._lingerByItem[_sourceItem]) then
                                    local v21 = u4._lingerByItem[_sourceItem];

                                    for i = #v21, 1, -1 do
                                        local v22;

                                        if v21[i] == VisualPart then
                                            local v23 = #v21;

                                            if i < v23 then
                                                v21[i] = v21[v23];
                                            end;

                                            v21[v23] = nil;
                                            v22 = i;
                                        else
                                            v22 = i;
                                        end;
                                    end;

                                    if #v21 == 0 then
                                        u4._lingerByItem[_sourceItem] = nil;
                                    end;
                                end;
                            end);
                        else
                            u4:_fireOnDestruction(u8, VisualPart);
                            u4:_releaseOrDestroy(u8, VisualPart);
                        end;

                        u4:_reclaimPData(u8);

                        if ActiveEmits[v7] == u8 then
                            local v24 = #ActiveEmits;

                            if v7 < v24 then
                                ActiveEmits[v7] = ActiveEmits[v24];
                            end;

                            ActiveEmits[v24] = nil;
                        end;
                    end;
                else
                    v7 = v7 + 1;
                end;
            end;

            u4._inStep = false;
            local _afterStep = u4._afterStep;

            if _afterStep then
                u4._afterStep = nil;

                for _, v in ipairs(_afterStep) do
                    local success, result = pcall(v);

                    if not success then
                        Log.warn("[Part-Icles] deferred Disable failed: " .. tostring(result));
                    end;
                end;
            end;

            Apply.applyFrame();
            Canvas.applyFrame();
            u4:_placeMattes();
        end;

        if RunService:IsClient() then
            u1 = u1 + 1;
            u4._renderStepName = "PartIclesEngine_" .. u2 .. "_" .. u1;

            if pcall(function() -- Line: 347
                -- upvalues: RunService (ref), u4 (copy), u25 (copy)
                RunService:BindToRenderStep(u4._renderStepName, Enum.RenderPriority.Last.Value + 1, u25);
            end) then
                u4.Connection = "RenderStep";
            else
                u4._renderStepName = nil;
                u4.Connection = RunService.RenderStepped:Connect(u25);
            end;
        else
            u4.Connection = RunService.Heartbeat:Connect(u25);
        end;

        u4:ShowStrandedReactors();

        if RunService:IsRunning() then
            u4:PrepareReactors();
        end;
    end;

    function p3.Deactivate(u26) -- Line: 371
        -- upvalues: RunService (ref), Apply (ref), Canvas (ref), Pool (ref), VisualHost (ref), Events (ref)
        u26._engineGen = (u26._engineGen or 0) + 1;

        if u26.Connection then
            if u26._renderStepName then
                pcall(function() -- Line: 379
                    -- upvalues: RunService (ref), u26 (copy)
                    RunService:UnbindFromRenderStep(u26._renderStepName);
                end);
                u26._renderStepName = nil;
            elseif typeof(u26.Connection) == "RBXScriptConnection" then
                u26.Connection:Disconnect();
            end;

            u26.Connection = nil;
        end;

        if u26._focusConn then
            u26._focusConn:Disconnect();
            u26._focusConn = nil;
        end;

        u26:RestoreAllReactors();

        if u26._blurConn then
            u26._blurConn:Disconnect();
            u26._blurConn = nil;
        end;

        Apply.reset();
        Canvas.reset();

        if u26._lingerByItem then
            table.clear(u26._lingerByItem);
        end;

        if u26._evenCycleStore then
            table.clear(u26._evenCycleStore);
        end;

        u26._lingerVisualCount = 0;
        Pool.flushAll();

        for i = #u26.ActiveEmits, 1, -1 do
            local u27 = u26.ActiveEmits[i];

            if not u26:_isLiveRTAnimate(u27) and u27.VisualPart then
                Pool.dropCloneMap(u27.VisualPart);
                pcall(function() -- Line: 415
                    -- upvalues: u27 (copy)
                    u27.VisualPart:Destroy();
                end);
            end;

            u26:_reclaimPData(u27);
            u26.ActiveEmits[i] = nil;
            local _ = i;
        end;

        u26:_dropMatteLayers();
        local v28 = {};

        for i in pairs(u26.ActiveAnimates) do
            table.insert(v28, i);
        end;

        for _, v in ipairs(v28) do
            pcall(function() -- Line: 426
                -- upvalues: u26 (copy), v (copy)
                u26:_cancelAnimation(v);
            end);
        end;

        table.clear(u26.ActiveAnimates);

        for i, v in pairs(u26.ActiveLoops) do
            pcall(function() -- Line: 430
                -- upvalues: v (copy)
                task.cancel(v);
            end);
            u26.ActiveLoops[i] = nil;
        end;

        if u26.ActiveChainLoops then
            for _, v in pairs(u26.ActiveChainLoops) do
                for _, v2 in ipairs(v) do
                    pcall(task.cancel, v2);
                end;
            end;

            table.clear(u26.ActiveChainLoops);
        end;

        VisualHost.reset();

        local function sweep(p29) -- Line: 441
            for _, descendant in p29:GetDescendants() do
                if descendant:GetAttribute("_PartIcleEmit") then
                    pcall(descendant.Destroy, descendant);
                end;
            end;
        end;

        sweep(workspace);
        sweep(game:GetService("Lighting"));
        local ScreenHost = require(script.Parent.ScreenHost);

        if ScreenHost.exists() then
            sweep(ScreenHost.get());
            ScreenHost.destroy();
        end;

        require(script.Parent.TexturePin).clear();
        Events.cleanup();

        if u26.LinkService and u26.LinkService.Deactivate then
            pcall(function() -- Line: 455
                -- upvalues: u26 (copy)
                u26.LinkService:Deactivate();
            end);
        end;
    end;

    function p3.GetFolder(p30) -- Line: 461
        -- upvalues: VisualHost (ref)
        return VisualHost.getFolder();
    end;

    function p3.GetPoolFolder(p31) -- Line: 467
        -- upvalues: VisualHost (ref)
        return VisualHost.getPoolFolder();
    end;
end;