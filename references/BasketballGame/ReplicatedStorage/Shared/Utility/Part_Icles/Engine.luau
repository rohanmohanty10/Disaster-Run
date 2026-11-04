 
 

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
require(script.Parent.Particles);
local AxisLinks = require(script.Parent.AxisLinks);
local Events = require(script.Parent.Events);
local EventsCollision = require(script.Parent.EventsCollision);
local Pool = require(script.Parent.Pool);
local PartConstants = require(script.Parent.PartConstants);

return function(p1) -- Line: 21
    -- upvalues: RunService (copy), UserInputService (copy), Events (copy), Pool (copy), EventsCollision (copy), Graph (copy), PartConstants (copy), Range (copy), AxisLinks (copy)
    function p1.Activate(u2) -- Line: 24
        -- upvalues: RunService (ref), UserInputService (ref), Events (ref), Pool (ref), EventsCollision (ref), Graph (ref), PartConstants (ref), Range (ref), AxisLinks (ref)
        if u2.Connection then
            return;
        end;

        u2._engineGen = (u2._engineGen or 0) + 1;
        u2._notActivatedWarned = false;

        if RunService:IsClient() then
            if not u2._focusConn then
                u2._focusConn = UserInputService.WindowFocused:Connect(function() -- Line: 37
                    -- upvalues: u2 (copy)
                    u2._focused = true;
                    u2._unfocusedAt = 0;
                end);
            end;

            if not u2._blurConn then
                u2._blurConn = UserInputService.WindowFocusReleased:Connect(function() -- Line: 43
                    -- upvalues: u2 (copy)
                    u2._focused = false;
                    u2._unfocusedAt = os.clock();
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
            pcall(function() -- Line: 59
                -- upvalues: u2 (copy), v (copy)
                u2:Preload(v, false);
            end);
        end;

        u2.Connection = RunService.Heartbeat:Connect(function(p3) -- Line: 62
            -- upvalues: Events (ref), Pool (ref), u2 (copy), EventsCollision (ref), Graph (ref), PartConstants (ref), Range (ref), AxisLinks (ref)
            Events.tickFrame();
            local os_clock_ret = os.clock();
            Pool.tick(os_clock_ret);
            local ActiveEmits = u2.ActiveEmits;

            if #ActiveEmits == 0 then
                return;
            end;

            local workspace_CurrentCamera = workspace.CurrentCamera;
            local v4;

            if workspace_CurrentCamera then
                v4 = workspace_CurrentCamera.CFrame.Position;
            else
                v4 = nil;
            end;

            local v5 = 1;

            while v5 <= #ActiveEmits do
                local u6 = ActiveEmits[v5];
                local v7 = u6._forceDead == true;
                local CurrentStep = u6.CurrentStep;

                if not v7 then
                    if u6.Type == "Part" then
                        v7 = u2:UpdatePart(u6, p3, os_clock_ret);
                    elseif u6.Type == "Beam" then
                        v7 = u2:UpdateBeam(u6, p3, os_clock_ret);
                    elseif u6.Type == "PointLight" then
                        v7 = u2:UpdatePointLight(u6, p3, os_clock_ret);
                    elseif u6.Type == "Highlight" then
                        v7 = u2:UpdateHighlight(u6, p3, os_clock_ret);
                    elseif u6.Type == "TrailEmitter" then
                        v7 = u2:UpdateTrail(u6, p3, os_clock_ret);
                    elseif u6.Type == "Attachment" then
                        v7 = u2:UpdateAttachment(u6, p3, os_clock_ret);
                    elseif u6.Type == "Model" then
                        v7 = u2:UpdateModel(u6, p3, os_clock_ret);
                    elseif u6.Type == "Screen" then
                        v7 = u2:UpdateScreen(u6, p3, os_clock_ret);
                    elseif u6.Type == "ImageLabel" then
                        v7 = u2:UpdateImageLabel(u6, p3, os_clock_ret);
                    end;
                end;

                if not v7 then
                    if u6.Link then
                        u2:ReapplyLink(u6);
                    end;

                    local Type = u6.Type;

                    if u6._settleEngaged and not (u6._collisionStopped or Type ~= "Part" and (Type ~= "Model" and Type ~= "Attachment")) then
                        EventsCollision.applySettle(u6, p3);
                    end;

                    if (Type == "Part" or (Type == "Model" or Type == "Attachment")) and (u6.Link or u6.CurrentStep ~= CurrentStep) then
                        u6._postUpdateCF = Type == "Model" and u6.VisualPart:GetPivot() or u6.VisualPart.CFrame;
                    end;

                    if u6.Orientation and u6.Orientation ~= "None" then
                        u2:ApplyOrientation(u6, p3, v4);
                    end;

                    if u6.ZOffset and u6.ZOffset ~= 0 then
                        u2:ApplyZOffset(u6, v4);
                    end;
                end;

                Events.afterUpdate(u2, u6, v7, os_clock_ret);

                if v7 then
                    u2:_fireOnDeath(u6);

                    if u6.IsAnimate then
                        if u6.AnimateItem and (u6.AnimateItem.Parent and u6.AnimateItem:GetAttribute("AnimateLoop")) then
                            u6.StartTime = os_clock_ret;
                            u6.CurrentStep = 0;

                            if u6.AccumulatedDT then
                                u6.AccumulatedDT = 0;
                            end;

                            if u6.InitialLocalCF then
                                u6.LocalCF = u6.InitialLocalCF;
                            end;

                            if u6.AccRotX then
                                u6.AccRotX = 0;
                                u6.AccRotY = 0;
                                u6.AccRotZ = 0;
                            end;

                            if u6.TargetVel then
                                u6.TargetVel = Vector3.new(0, 0, 0);
                            end;

                            u6._collisionStopped = false;
                            u6._spinRate = Vector3.new(0, 0, 0);
                            u6._spinAccumX = 0;
                            u6._spinAccumY = 0;
                            u6._spinAccumZ = 0;
                            u6.SpeedMultiplier = 1;

                            if u6._accelVel then
                                u6._accelVel = Vector3.new(0, 0, 0);
                            end;

                            if u6._prevWorldOff then
                                u6._prevWorldOff = Vector3.new(0, 0, 0);
                                u6._displacementMirrorX = nil;
                                u6._displacementMirrorY = nil;
                                u6._displacementMirrorZ = nil;

                                if u6.HasPosOffsetGraphs and (u6.Graphs and u6.SpawnRotation) then
                                    local v8 = u6.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, u6.Graphs.PosOffsetX, u6.Seeds.PosOffsetX) or 0) or 0;
                                    local v9 = u6.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, u6.Graphs.PosOffsetY, u6.Seeds.PosOffsetY) or 0) or 0;
                                    local v10 = u6.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, u6.Graphs.PosOffsetZ, u6.Seeds.PosOffsetZ) or 0) or 0;

                                    if v8 ~= 0 or (v9 ~= 0 or v10 ~= 0) then
                                        local u11 = PartConstants.resolveDisplacement(Vector3.new(v8, v9, v10), u6.DisplacementMode or "Global", u6.SpawnRotation, u6.SpawnEmitterRotation);
                                        u6._prevWorldOff = u11;
                                        u6.LocalCF = u6.LocalCF + u11;

                                        if u6.VisualPart and u6.VisualPart.Parent then
                                            if u6.Type == "Model" then
                                                pcall(function() -- Line: 178
                                                    -- upvalues: u6 (copy), u11 (copy)
                                                    u6.VisualPart:PivotTo(u6.VisualPart:GetPivot() + u11);
                                                end);
                                            else
                                                u6.VisualPart.CFrame = u6.VisualPart.CFrame + u11;
                                            end;
                                        end;
                                    end;
                                end;
                            end;

                            if u6._initialBaseDirection then
                                u6.BaseDirection = u6._initialBaseDirection;
                            end;

                            u6._lastOrientPos = nil;
                            local InitialLocalCF = u6.InitialLocalCF;
                            u6._localWorldCF = u6.InitialLocalCF;
                            u6._postUpdateCF = InitialLocalCF;
                            u6._lastTransIdx = nil;
                            u6._lastColorIdx = nil;
                            u6._effectiveElapsed = Graph.InitialEffectiveElapsed(u6.Graphs and u6.Graphs.Timescale, u6.Seeds and u6.Seeds.Timescale, u6.LifeTime);
                            u6._hitHistory = nil;

                            if u6.Type == "ImageLabel" then
                                u6.PosX = 0;
                                u6.PosY = 0;
                                u6.EnvVelX = 0;
                                u6.EnvVelY = 0;
                                u6.AccRot = 0;
                            end;

                            local Data = u2:GetData(u6.AnimateItem);

                            if Data then
                                u6.Events = Data.Events;
                                u6._killedManually = false;
                                u6._fireOnDeathOverride = false;
                                u6._hitFired = false;
                                u6.LifeTime = Range.RandomValueFromRange(Data.Lifetime);

                                if u6.LifeTime <= 0 then
                                    u6.LifeTime = 0.001;
                                end;

                                u6.TotalKeyFrames = math.max(1, Data.TotalKeyFrames);

                                if Data.ParticleData then
                                    u6.Acceleration = Data.ParticleData.Acceleration;
                                    u6.Drag = Data.ParticleData.Drag;
                                    u6.HasDrag = Data.ParticleData.Drag ~= 0;
                                    u6.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
                                end;

                                u6.InvertMotion = Data.InvertMotion or false;
                                u6.AccelTarget = Data.AccelTarget;
                                local v12;

                                if Data.AccelerationTowardsInstance == true and (Data.AccelTarget ~= nil and Data.AccelStrength ~= nil) then
                                    v12 = not u6.InvertMotion;
                                else
                                    v12 = false;
                                end;

                                u6.HasTargetAccel = v12;
                                u6.TargetVel = Vector3.new(0, 0, 0);

                                if Data.VelocityVectored ~= nil then
                                    u6.VelocityVectored = Data.VelocityVectored;
                                end;

                                u6.NeedsFullIteration = u6.VelocityVectored or false;

                                if Data.RotMode then
                                    u6.RotMode = Data.RotMode;
                                    local v13;

                                    if Data.RotMode == "Speed" then
                                        v13 = not u6.VelocityVectored and true or false;
                                    else
                                        v13 = false;
                                    end;

                                    u6.NeedsRotAccum = v13;
                                end;

                                u6.Link = Data.Link;
                                u6.LinkMode = Data.LinkMode;

                                if u6.Type == "ImageLabel" then
                                    u2:_refreshImageLabelAnimateNonSpatial(u6, Data);
                                else
                                    u2:_refreshAnimateNonSpatial(u6, Data);
                                end;

                                AxisLinks.refreshLoopGraphsAndSeeds(u6, Data, Graph);
                                u6._effectiveElapsed = Graph.InitialEffectiveElapsed(u6.Graphs and u6.Graphs.Timescale, u6.Seeds and u6.Seeds.Timescale, u6.LifeTime);

                                if u6.Type == "ImageLabel" then
                                    u6.InvertMotion = Data.ImgInvertMotion or false;

                                    if u6.InvertMotion then
                                        local v14, v15, v16, v17 = u2:_computeImageLabelEndState(Data, u6.DirX or 0, u6.DirY or 0, u6.LifeTime, u6.Seeds);
                                        u6.PosX = v14;
                                        u6.PosY = v15;
                                        u6.EnvVelX = v16;
                                        u6.EnvVelY = v17;
                                        u6._effectiveElapsed = u6.LifeTime;
                                        u6._invertDtSign = -1;
                                    else
                                        u6._invertDtSign = nil;
                                    end;
                                end;

                                if u6.InvertMotion and (u6.AnimateItem and u6.AnimateItem.Parent) then
                                    local v18 = nil;
                                    local u19 = u6.Type == "Attachment";
                                    local u20;

                                    if u6.Type == "Model" then
                                        local v21;
                                        v21, u20 = pcall(function() -- Line: 269
                                            -- upvalues: u6 (copy)
                                            return u6.AnimateItem:GetPivot();
                                        end);

                                        if not v21 then
                                            u20 = v18;
                                        end;
                                    elseif u19 then
                                        u20 = u6.AnimateItem.CFrame;
                                    elseif u6.AnimateItem:IsA("BasePart") then
                                        u20 = u6.AnimateItem.CFrame;
                                    else
                                        u20 = v18;
                                    end;

                                    if u20 then
                                        local v22, v23, v24 = pcall(function() -- Line: 278
                                            -- upvalues: u19 (copy), u2 (ref), Data (copy), u6 (copy), u20 (ref)
                                            if u19 then
                                                return u2:PreSimulateAttachmentForward(Data, u6.Seeds, u20, u6.BaseDirection, u6.SpreadRotation, u6.LifeTime, nil, u6.SpawnEmitterRotation);
                                            end;

                                            return u2:PreSimulateForward(Data, u6.Seeds, u20, u6.BaseDirection, u6.SpreadRotation, u6.Link, u6.LifeTime, nil, u6.SpawnEmitterRotation);
                                        end);

                                        if v22 then
                                            u6.SimLocalCFrames = v23;

                                            if v24 then
                                                u6.TotalKeyFrames = v24;
                                            end;
                                        end;
                                    end;
                                elseif not u6.InvertMotion then
                                    u6.SimLocalCFrames = nil;
                                end;

                                if u6.Type == "Beam" and Data.BeamProps then
                                    local VisualPart = u6.VisualPart;
                                    local v25 = {};

                                    for i, v in pairs(Data.BeamProps) do
                                        if v then
                                            if Graph.IsStatic(v) then
                                                if VisualPart then
                                                    VisualPart[i] = Graph.GetStaticValue(v, VisualPart[i]);
                                                end;
                                            else
                                                v25[i] = {
                                                    Sequence = v,
                                                    Seed = Graph.GenerateSeed(v)
                                                };
                                            end;
                                        end;
                                    end;

                                    u6.AnimatedProps = v25;

                                    if VisualPart then
                                        u6._baseWidth0 = VisualPart.Width0;
                                        u6._baseWidth1 = VisualPart.Width1;
                                        u6._baseCurveSize0 = VisualPart.CurveSize0;
                                        u6._baseCurveSize1 = VisualPart.CurveSize1;
                                        u6._baseTextureLength = VisualPart.TextureLength;
                                        u6._baseSegments = VisualPart.Segments;
                                    end;

                                    if v25.TextureSpeed and VisualPart then
                                        VisualPart.TextureSpeed = 0;
                                    end;

                                    if Data.GraphBlender then
                                        local v26, v27 = Graph.CollectGraphStates(Data.GraphBlender);
                                        u6.TransStates = v26;
                                        u6.ColorStates = v27;
                                        local v28 = {};

                                        for i = 1, #v26 - 1 do
                                            v28[i] = Graph.PrecomputeMergedTimes(v26[i].Graph, v26[i + 1].Graph);
                                            local _ = i;
                                        end;

                                        local v29 = {};

                                        for i = 1, #v27 - 1 do
                                            v29[i] = Graph.PrecomputeMergedColorTimes(v27[i].Graph, v27[i + 1].Graph);
                                            local _ = i;
                                        end;

                                        u6.TransMergedTimes = v28;
                                        u6.ColorMergedTimes = v29;

                                        if #v26 > 0 and VisualPart then
                                            VisualPart.Transparency = v26[1].Graph;
                                        end;

                                        if #v27 > 0 and VisualPart then
                                            VisualPart.Color = v27[1].Graph;
                                        end;
                                    end;
                                end;

                                if Data.PLRange then
                                    u6.PLRange = Data.PLRange;
                                end;

                                if Data.PLBrightness then
                                    u6.PLBrightness = Data.PLBrightness;
                                end;

                                if Data.PLColor then
                                    u6.PLColor = Data.PLColor;
                                end;
                            end;

                            if u6.AnimateItem and (u6.AnimateItem.Parent and (u6.VisualPart and u6.VisualPart.Parent)) then
                                if u6.Type == "Model" then
                                    local success, result = pcall(function() -- Line: 335
                                        -- upvalues: u6 (copy)
                                        return u6.AnimateItem:GetPivot();
                                    end);

                                    if success and result then
                                        u6.VisualPart:PivotTo(result);
                                    end;
                                elseif u6.AnimateItem:IsA("BasePart") then
                                    u6.VisualPart.CFrame = u6.AnimateItem.CFrame;
                                elseif u6.AnimateItem:IsA("Attachment") then
                                    u6.VisualPart.CFrame = CFrame.new();
                                end;
                            end;

                            u2:_fireAnimateCycleRestartEvents(u6);
                            v5 = v5 + 1;
                        else
                            local VisualPart = u6.VisualPart;
                            local Type = u6.Type;
                            local InitialAnchorCF = u6.InitialAnchorCF;
                            local InitialScale = u6.InitialScale;
                            local HasDecal = u6.HasDecal;
                            local AnimateItem = u6.AnimateItem;
                            local v30 = u6.PartLife or 0;
                            local u31 = (Type == "Part" or (Type == "Attachment" or Type == "Model")) and true or Type == "Beam";
                            local u32;

                            if AnimateItem then
                                u32 = (AnimateItem:GetAttribute("_animateFinishGen") or 0) + 1;
                                pcall(function() -- Line: 365
                                    -- upvalues: AnimateItem (copy), u32 (ref)
                                    AnimateItem:SetAttribute("_animateFinishGen", u32);
                                end);
                            else
                                u32 = nil;
                            end;

                            local function finishAnimate() -- Line: 367
                                -- upvalues: VisualPart (copy), u31 (copy), AnimateItem (copy), u2 (ref), u32 (ref), u6 (copy), InitialAnchorCF (copy), Type (copy), InitialScale (copy), HasDecal (copy)
                                if not (VisualPart and VisualPart.Parent) then
                                    return;
                                end;

                                if u31 and (AnimateItem and u2.ActiveAnimates[AnimateItem]) then
                                    return;
                                end;

                                if AnimateItem and (AnimateItem.Parent and (u32 and AnimateItem:GetAttribute("_animateFinishGen") ~= u32)) then
                                    return;
                                end;

                                u2:_fireOnDestruction(u6, VisualPart);

                                if InitialAnchorCF then
                                    if Type == "Model" then
                                        pcall(function() -- Line: 377
                                            -- upvalues: VisualPart (ref), InitialAnchorCF (ref)
                                            VisualPart:PivotTo(InitialAnchorCF);
                                        end);

                                        if InitialScale then
                                            pcall(function() -- Line: 378
                                                -- upvalues: VisualPart (ref), InitialScale (ref)
                                                VisualPart:ScaleTo(InitialScale);
                                            end);
                                        end;
                                    else
                                        pcall(function() -- Line: 379
                                            -- upvalues: VisualPart (ref), InitialAnchorCF (ref)
                                            VisualPart.CFrame = InitialAnchorCF;
                                        end);
                                    end;
                                end;

                                if Type == "Screen" or Type == "ImageLabel" then
                                    pcall(function() -- Line: 382
                                        -- upvalues: VisualPart (ref)
                                        VisualPart:Destroy();
                                    end);

                                    return;
                                end;

                                if Type ~= "Beam" and (Type ~= "Highlight" and Type ~= "TrailEmitter") then
                                    pcall(function() -- Line: 390
                                        -- upvalues: VisualPart (ref), HasDecal (ref), u6 (ref)
                                        VisualPart.Transparency = 1;
                                        local v33 = HasDecal and VisualPart:FindFirstChildOfClass("Decal");

                                        if v33 then
                                            v33.Transparency = 1;
                                        end;

                                        local v34 = u6._initialSAColor and VisualPart:FindFirstChildOfClass("SurfaceAppearance");

                                        if v34 then
                                            v34.Color = u6._initialSAColor;
                                        end;

                                        if u6._initialPartColor and VisualPart:IsA("BasePart") then
                                            VisualPart.Color = u6._initialPartColor;
                                        end;
                                    end);

                                    return;
                                end;

                                local u35 = u6.BeamSnapshot or (u6.HighlightSnapshot or u6.TrailEmitterSnapshot);

                                if u35 then
                                    pcall(function() -- Line: 386
                                        -- upvalues: u35 (copy), VisualPart (ref)
                                        for i, v in pairs(u35) do
                                            VisualPart[i] = v;
                                        end;
                                    end);
                                end;

                                pcall(function() -- Line: 388
                                    -- upvalues: VisualPart (ref)
                                    VisualPart.Enabled = false;
                                end);
                            end;

                            u2.ActiveAnimates[AnimateItem] = nil;

                            if v30 > 0 then
                                task.delay(v30, finishAnimate);
                            else
                                finishAnimate();
                            end;

                            if u6._scaleMapKeys and u2._parentScaleMap then
                                for _, v in ipairs(u6._scaleMapKeys) do
                                    u2._parentScaleMap[v] = nil;
                                end;
                            end;

                            if u6._nestedAlive then
                                u6._nestedAlive[1] = false;
                            end;

                            local v36 = #ActiveEmits;

                            if v5 < v36 then
                                ActiveEmits[v5] = ActiveEmits[v36];
                            end;

                            ActiveEmits[v36] = nil;
                        end;
                    else
                        local VisualPart = u6.VisualPart;

                        if u6.PartLife and u6.PartLife > 0 then
                            local _sourceItem = u6._sourceItem;

                            if _sourceItem and VisualPart then
                                u2._lingerByItem = u2._lingerByItem or {};
                                local v37 = u2._lingerByItem[_sourceItem] or {};
                                table.insert(v37, VisualPart);
                                u2._lingerByItem[_sourceItem] = v37;
                                pcall(function() -- Line: 429
                                    -- upvalues: VisualPart (copy)
                                    VisualPart:SetAttribute("_lingerCounted", true);
                                end);
                                local v38 = u2;
                                v38._lingerVisualCount = v38._lingerVisualCount + 1;
                            end;

                            u6._lingerStartTime = os.clock();
                            task.delay(u6.PartLife, function() -- Line: 436
                                -- upvalues: u2 (ref), u6 (copy), VisualPart (copy), _sourceItem (copy)
                                u2:_fireOnDestruction(u6, VisualPart);

                                if VisualPart then
                                    local u39 = false;
                                    pcall(function() -- Line: 440
                                        -- upvalues: u39 (ref), VisualPart (ref)
                                        u39 = VisualPart:GetAttribute("_lingerCounted") == true;
                                    end);

                                    if u39 then
                                        u2._lingerVisualCount = math.max(0, (u2._lingerVisualCount or 0) - 1);
                                        pcall(function() -- Line: 443
                                            -- upvalues: VisualPart (ref)
                                            VisualPart:SetAttribute("_lingerCounted", nil);
                                        end);
                                    end;

                                    u2:_releaseOrDestroy(u6, VisualPart);
                                end;

                                if _sourceItem and (u2._lingerByItem and u2._lingerByItem[_sourceItem]) then
                                    local v40 = u2._lingerByItem[_sourceItem];

                                    for i = #v40, 1, -1 do
                                        local v41;

                                        if v40[i] == VisualPart then
                                            local v42 = #v40;

                                            if i < v42 then
                                                v40[i] = v40[v42];
                                            end;

                                            v40[v42] = nil;
                                            v41 = i;
                                        else
                                            v41 = i;
                                        end;
                                    end;

                                    if #v40 == 0 then
                                        u2._lingerByItem[_sourceItem] = nil;
                                    end;
                                end;
                            end);
                        else
                            u2:_fireOnDestruction(u6, VisualPart);
                            u2:_releaseOrDestroy(u6, VisualPart);
                        end;

                        if u6._scaleMapKeys and u2._parentScaleMap then
                            for _, v in ipairs(u6._scaleMapKeys) do
                                u2._parentScaleMap[v] = nil;
                            end;
                        end;

                        if u6._nestedAlive then
                            u6._nestedAlive[1] = false;
                        end;

                        local v43 = #ActiveEmits;

                        if v5 < v43 then
                            ActiveEmits[v5] = ActiveEmits[v43];
                        end;

                        ActiveEmits[v43] = nil;
                    end;
                else
                    v5 = v5 + 1;
                end;
            end;
        end);
    end;

    function p1.Deactivate(u44) -- Line: 485
        -- upvalues: Pool (ref), Events (ref)
        u44._engineGen = (u44._engineGen or 0) + 1;

        if u44.Connection then
            u44.Connection:Disconnect();
            u44.Connection = nil;
        end;

        if u44._focusConn then
            u44._focusConn:Disconnect();
            u44._focusConn = nil;
        end;

        if u44._blurConn then
            u44._blurConn:Disconnect();
            u44._blurConn = nil;
        end;

        if u44._parentScaleMap then
            table.clear(u44._parentScaleMap);
        end;

        if u44._lingerByItem then
            table.clear(u44._lingerByItem);
        end;

        u44._lingerVisualCount = 0;
        Pool.flushAll();

        for i = #u44.ActiveEmits, 1, -1 do
            local u45 = u44.ActiveEmits[i];

            if not (u45.IsAnimate and ((u45.Type == "Part" or (u45.Type == "Attachment" or u45.Type == "Beam")) and true or u45.Type == "Model")) and u45.VisualPart then
                pcall(function() -- Line: 518
                    -- upvalues: u45 (copy)
                    u45.VisualPart:Destroy();
                end);
            end;

            if u45._nestedAlive then
                u45._nestedAlive[1] = false;
            end;

            u44.ActiveEmits[i] = nil;
            local _ = i;
        end;

        local v46 = {};

        for i in pairs(u44.ActiveAnimates) do
            table.insert(v46, i);
        end;

        for _, v in ipairs(v46) do
            pcall(function() -- Line: 527
                -- upvalues: u44 (copy), v (copy)
                u44:_cancelAnimation(v);
            end);
        end;

        table.clear(u44.ActiveAnimates);

        for i, v in pairs(u44.ActiveLoops) do
            pcall(function() -- Line: 531
                -- upvalues: v (copy)
                task.cancel(v);
            end);
            u44.ActiveLoops[i] = nil;
        end;

        if u44.ActiveChainLoops then
            for _, v in pairs(u44.ActiveChainLoops) do
                for _, v2 in ipairs(v) do
                    pcall(task.cancel, v2);
                end;
            end;

            table.clear(u44.ActiveChainLoops);
        end;

        if u44._CachedFolder and u44._CachedFolder.Parent then
            u44._CachedFolder:Destroy();
        end;

        u44._CachedFolder = nil;

        if u44._CachedPoolFolder and u44._CachedPoolFolder.Parent then
            u44._CachedPoolFolder:Destroy();
        end;

        u44._CachedPoolFolder = nil;

        local function sweep(p47) -- Line: 549
            for _, descendant in p47:GetDescendants() do
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

        if u44.LinkService and u44.LinkService.Deactivate then
            pcall(function() -- Line: 563
                -- upvalues: u44 (copy)
                u44.LinkService:Deactivate();
            end);
        end;
    end;

    function p1.GetFolder(p48) -- Line: 572
        if p48._CachedFolder and p48._CachedFolder.Parent then
            return p48._CachedFolder;
        end;

        local EmittedPartsUsingPart_icle = workspace.Terrain:FindFirstChild("EmittedPartsUsingPart_icle");

        if not EmittedPartsUsingPart_icle then
            EmittedPartsUsingPart_icle = Instance.new("Folder");
            EmittedPartsUsingPart_icle.Name = "EmittedPartsUsingPart_icle";
            EmittedPartsUsingPart_icle.Archivable = false;
            EmittedPartsUsingPart_icle.Parent = workspace.Terrain;
        end;

        p48._CachedFolder = EmittedPartsUsingPart_icle;

        return EmittedPartsUsingPart_icle;
    end;

    function p1.GetPoolFolder(p49) -- Line: 589
        if p49._CachedPoolFolder and p49._CachedPoolFolder.Parent then
            return p49._CachedPoolFolder;
        end;

        local Part_IclesPooled = workspace.Terrain:FindFirstChild("Part_IclesPooled");

        if not Part_IclesPooled then
            Part_IclesPooled = Instance.new("Folder");
            Part_IclesPooled.Name = "Part_IclesPooled";
            Part_IclesPooled.Archivable = false;
            Part_IclesPooled.Parent = workspace.Terrain;
        end;

        p49._CachedPoolFolder = Part_IclesPooled;

        return Part_IclesPooled;
    end;
end;