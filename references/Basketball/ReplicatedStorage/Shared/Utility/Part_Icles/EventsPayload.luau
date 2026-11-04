 
 

local u23 = {
    build = function(p1, p2, p3, p4) -- Line: 40, Name: build
        local v5;

        if p4 then
            v5 = p4.Position or nil;
        else
            v5 = nil;
        end;

        local os_clock_ret = os.clock();
        local v6 = p1.StartTime and (math.max(0, os_clock_ret - p1.StartTime) or 0) or 0;
        local v7 = p1.LifeTime or 0;
        local v8 = v7 > 0 and (math.min(1, v6 / v7) or 0) or 0;
        local math_max_ret = math.max(0, v7 - v6);
        local v9 = {
            SourceItem = p1._sourceItem,
            Source = p1._sourceItem,
            Particle = p1.VisualPart,
            RenderTemplate = p1.VisualPart,
            WorldCFrame = p4,
            WorldPosition = v5,
            LifeProgress = v8,
            TimeRemaining = math_max_ret,
            StartTime = p1.StartTime,
            LifeTime = v7,
            SpeedMultiplier = p1.SpeedMultiplier or 1,
            ChainDepth = p1.EventChainCtx and (p1.EventChainCtx.Depth or 0) or 0
        };
        local v10;

        if p3 then
            v10 = p3.EmitCount;
        else
            v10 = p3;
        end;

        v9.EmitCount = v10;
        v9._eventName = p2;

        if p2 == "OnEmit" then
            v9.EmitPosition = v5;

            if p3 then
                p3 = p3.EmitIndex;
            end;

            v9.EmitIndex = p3;

            return v9;
        end;

        if p2 ~= "OnDeath" then
            if p2 == "OnDestruction" then
                v9.DeathPosition = v5;

                if p1._lingerStartTime then
                    v9.LingerElapsed = math.max(0, os_clock_ret - p1._lingerStartTime);

                    return v9;
                end;

                v9.LingerElapsed = 0;
            end;

            return v9;
        end;

        v9.DeathPosition = v5;

        if p1.StartTime then
            v9.Age = math.max(0, os_clock_ret - p1.StartTime);

            return v9;
        end;

        v9.Age = p1.LifeTime;

        return v9;
    end,

    applyColor = function(p11, u12) -- Line: 94, Name: applyColor
        if typeof(u12) ~= "Color3" then
            return;
        end;

        p11.SkipColor = true;
        local VisualPart = p11.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return;
        end;

        local Type = p11.Type;

        if Type == "Part" or Type == "Model" then
            if VisualPart:IsA("BasePart") then
                pcall(function() -- Line: 101
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.Color = u12;
                end);
            end;

            local u13 = VisualPart.FindFirstChildOfClass and VisualPart:FindFirstChildOfClass("SurfaceAppearance");

            if u13 then
                pcall(function() -- Line: 103
                    -- upvalues: u13 (copy), u12 (copy)
                    u13.Color = u12;
                end);
            end;
        else
            if Type == "Beam" or (Type == "TrailEmitter" or Type == "BeamNative") then
                pcall(function() -- Line: 105
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.Color = ColorSequence.new(u12);
                end);

                return;
            end;

            if Type == "PointLight" then
                pcall(function() -- Line: 107
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.Color = u12;
                end);

                return;
            end;

            if Type == "Highlight" then
                pcall(function() -- Line: 109
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.FillColor = u12;
                end);
                pcall(function() -- Line: 110
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.OutlineColor = u12;
                end);

                return;
            end;

            if Type == "ImageLabel" then
                pcall(function() -- Line: 112
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.ImageColor3 = u12;
                end);

                return;
            end;

            if Type == "Screen" then
                if p11.Kind == "ColorCorrection" then
                    pcall(function() -- Line: 115
                        -- upvalues: VisualPart (copy), u12 (copy)
                        VisualPart.TintColor = u12;
                    end);

                    return;
                end;

                if p11.Kind == "Atmosphere" then
                    pcall(function() -- Line: 117
                        -- upvalues: VisualPart (copy), u12 (copy)
                        VisualPart.Color = u12;
                    end);
                end;
            end;
        end;
    end,

    applyTransparency = function(p14, p15) -- Line: 129, Name: applyTransparency
        if type(p15) ~= "number" then
            return;
        end;

        local math_min_ret = math.min(1, p15);
        local math_max_ret = math.max(0, math_min_ret);
        p14.SkipTransparency = true;
        local VisualPart = p14.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return;
        end;

        local Type = p14.Type;

        if Type == "Part" or Type == "Model" then
            if VisualPart:IsA("BasePart") then
                pcall(function() -- Line: 137
                    -- upvalues: VisualPart (copy), math_max_ret (ref)
                    VisualPart.Transparency = math_max_ret;
                end);
            end;

            local u16 = VisualPart.FindFirstChildOfClass and VisualPart:FindFirstChildOfClass("Decal");

            if u16 then
                pcall(function() -- Line: 139
                    -- upvalues: u16 (copy), math_max_ret (ref)
                    u16.Transparency = math_max_ret;
                end);
            end;
        elseif Type == "Beam" or (Type == "TrailEmitter" or Type == "BeamNative") then
            pcall(function() -- Line: 141
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.Transparency = NumberSequence.new(math_max_ret);
            end);
        elseif Type == "PointLight" then
            local u17 = p14._baseBrightness or VisualPart.Brightness;
            p14._baseBrightness = u17;
            pcall(function() -- Line: 145
                -- upvalues: VisualPart (copy), u17 (copy), math_max_ret (ref)
                VisualPart.Brightness = u17 * (1 - math_max_ret);
            end);
        elseif Type == "Highlight" then
            pcall(function() -- Line: 147
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.FillTransparency = math_max_ret;
            end);
            pcall(function() -- Line: 148
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.OutlineTransparency = math_max_ret;
            end);
        elseif Type == "ImageLabel" then
            pcall(function() -- Line: 150
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.ImageTransparency = math_max_ret;
            end);
        end;
    end,

    attachSkipSetters = function(p18, u19) -- Line: 161, Name: attachSkipSetters
        function p18.SetSkipColor(p20) -- Line: 162
            -- upvalues: u19 (copy)
            u19.SkipColor = p20 == true;
        end;

        function p18.SetSkipTransparency(p21) -- Line: 163
            -- upvalues: u19 (copy)
            u19.SkipTransparency = p21 == true;
        end;

        function p18.SetSkipSize(p22) -- Line: 164
            -- upvalues: u19 (copy)
            u19.SkipSize = p22 == true;
        end;
    end
};

local function _clearSettleState(p24) -- Line: 178
    p24._settleEngaged = false;
    p24._restTimer = 0;
    p24._settleRotDamp = 1;
    p24._settleContactPos = nil;
    p24._settleSpawnHalf = nil;
    p24._lastHitNormal = nil;
    p24._collisionStopped = false;
    p24._displacementMirrorX = nil;
    p24._displacementMirrorY = nil;
    p24._displacementMirrorZ = nil;
end;

function u23.applyTeleport(p25, u26) -- Line: 191
    if typeof(u26) ~= "CFrame" then
        return;
    end;

    p25._settleEngaged = false;
    p25._restTimer = 0;
    p25._settleRotDamp = 1;
    p25._settleContactPos = nil;
    p25._settleSpawnHalf = nil;
    p25._lastHitNormal = nil;
    p25._collisionStopped = false;
    p25._displacementMirrorX = nil;
    p25._displacementMirrorY = nil;
    p25._displacementMirrorZ = nil;
    local VisualPart = p25.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    local Type = p25.Type;

    if Type == "Part" then
        pcall(function() -- Line: 198
            -- upvalues: VisualPart (copy), u26 (copy)
            VisualPart.CFrame = u26;
        end);
    elseif Type == "Attachment" then
        local Parent = VisualPart.Parent;

        if Parent and Parent:IsA("BasePart") then
            pcall(function() -- Line: 203
                -- upvalues: VisualPart (copy), Parent (copy), u26 (copy)
                VisualPart.CFrame = Parent.CFrame:ToObjectSpace(u26);
            end);
        else
            pcall(function() -- Line: 205
                -- upvalues: VisualPart (copy), u26 (copy)
                VisualPart.CFrame = u26;
            end);
        end;
    else
        if Type ~= "Model" then
            return;
        end;

        pcall(function() -- Line: 208
            -- upvalues: VisualPart (copy), u26 (copy)
            VisualPart:PivotTo(u26);
        end);
    end;

    if Type == "Attachment" then
        local Parent = VisualPart.Parent;

        if Parent and Parent:IsA("BasePart") then
            p25.LocalCF = Parent.CFrame:ToObjectSpace(u26);
        else
            p25.LocalCF = u26;
        end;
    else
        local Link = p25.Link;

        if Link and Link.Parent then
            local v27;

            if Link:IsA("Attachment") then
                v27 = Link.WorldCFrame;
            elseif Link:IsA("Model") then
                v27 = Link:GetPivot();
            else
                v27 = Link.CFrame;
            end;

            p25.LocalCF = v27:ToObjectSpace(u26);
        else
            p25.LocalCF = u26;
        end;
    end;

    p25._localWorldCF = p25.LocalCF;

    if Type == "Attachment" then
        p25._postUpdateCF = VisualPart.CFrame;
    elseif Type == "Model" then
        p25._postUpdateCF = VisualPart:GetPivot();
    else
        p25._postUpdateCF = u26;
    end;

    p25.CurrentPosition = u26.Position;
    p25.LastHitCheckPos = u26.Position;
    p25._lastOrientPos = nil;
end;

function u23.applyAddSpin(p28, p29) -- Line: 255
    if typeof(p29) ~= "Vector3" then
        return;
    end;

    p28._spinRate = (p28._spinRate or Vector3.new(0, 0, 0)) + p29;
end;

function u23.applyAddImpulse(p30, p31) -- Line: 262
    if typeof(p31) ~= "Vector3" then
        return;
    end;

    p30._settleEngaged = false;
    p30._restTimer = 0;
    p30._settleRotDamp = 1;
    p30._settleContactPos = nil;
    p30._settleSpawnHalf = nil;
    p30._lastHitNormal = nil;
    p30._collisionStopped = false;
    p30._displacementMirrorX = nil;
    p30._displacementMirrorY = nil;
    p30._displacementMirrorZ = nil;
    p30._accelVel = (p30._accelVel or Vector3.new(0, 0, 0)) + p31;
end;

function u23.applyFreezeTime(p32, p33) -- Line: 271
    p32._timeFrozen = p33 == true;
    p32._freezeTimeExplicit = p33 == true;
end;

function u23.applyPause(u34, p35) -- Line: 280
    if type(p35) ~= "number" or p35 <= 0 then
        return;
    end;

    u34._timeFrozen = true;
    local u36 = (u34._pauseGen or 0) + 1;
    u34._pauseGen = u36;
    task.delay(p35, function() -- Line: 285
        -- upvalues: u34 (copy), u36 (copy)
        if u34._pauseGen == u36 and not u34._freezeTimeExplicit then
            u34._timeFrozen = false;
        end;
    end);
end;

function u23.applySetSize(p37, u38) -- Line: 295
    p37.SkipSize = true;
    local VisualPart = p37.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    local Type = p37.Type;

    if Type == "Part" or Type == "Model" then
        if typeof(u38) == "Vector3" and VisualPart:IsA("BasePart") then
            pcall(function() -- Line: 302
                -- upvalues: VisualPart (copy), u38 (copy)
                VisualPart.Size = u38;
            end);

            return;
        end;

        if typeof(u38) == "Vector3" and Type == "Model" then
            pcall(function() -- Line: 305
                -- upvalues: VisualPart (copy), u38 (copy)
                VisualPart:ScaleTo((math.max(0.001, u38.X)));
            end);
        end;
    elseif Type == "ImageLabel" and typeof(u38) == "UDim2" then
        pcall(function() -- Line: 308
            -- upvalues: VisualPart (copy), u38 (copy)
            VisualPart.Size = u38;
        end);
    end;
end;

function u23.applySetVelocity(p39, p40) -- Line: 315
    if p40 == nil then
        p39._speedOverride = nil;

        return;
    end;

    if typeof(p40) ~= "Vector3" then
        return;
    end;

    p39._settleEngaged = false;
    p39._restTimer = 0;
    p39._settleRotDamp = 1;
    p39._settleContactPos = nil;
    p39._settleSpawnHalf = nil;
    p39._lastHitNormal = nil;
    p39._collisionStopped = false;
    p39._displacementMirrorX = nil;
    p39._displacementMirrorY = nil;
    p39._displacementMirrorZ = nil;
    local Magnitude = p40.Magnitude;

    if Magnitude < 0.0001 then
        p39.SpeedMultiplier = 0;
        p39._speedOverride = 0;

        return;
    end;

    p39.BaseDirection = p40 / Magnitude;
    p39._speedOverride = Magnitude;
end;

function u23.applyResurrect(p41) -- Line: 335
    p41._killedManually = false;
    p41._forceDead = false;
end;

function u23.attachAdvancedSetters(p42, u43) -- Line: 342
    -- upvalues: u23 (copy)
    function p42.AddSpin(p44) -- Line: 343
        -- upvalues: u23 (ref), u43 (copy)
        u23.applyAddSpin(u43, p44);
    end;

    function p42.AddImpulse(p45) -- Line: 344
        -- upvalues: u23 (ref), u43 (copy)
        u23.applyAddImpulse(u43, p45);
    end;

    function p42.FreezeTime(p46) -- Line: 345
        -- upvalues: u23 (ref), u43 (copy)
        u23.applyFreezeTime(u43, p46);
    end;

    function p42.Pause(p47) -- Line: 346
        -- upvalues: u23 (ref), u43 (copy)
        u23.applyPause(u43, p47);
    end;

    function p42.SetSize(p48) -- Line: 347
        -- upvalues: u23 (ref), u43 (copy)
        u23.applySetSize(u43, p48);
    end;

    function p42.SetVelocity(p49) -- Line: 348
        -- upvalues: u23 (ref), u43 (copy)
        u23.applySetVelocity(u43, p49);
    end;

    function p42.Resurrect() -- Line: 349
        -- upvalues: u23 (ref), u43 (copy)
        u23.applyResurrect(u43);
    end;
end;

return u23;