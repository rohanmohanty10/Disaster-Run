 
 

local ContentProvider = game:GetService("ContentProvider");
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local ScreenHost = require(script.Parent.ScreenHost);

return function(u1) -- Line: 10
    -- upvalues: ScreenHost (copy), ContentProvider (copy), Graph (copy), Range (copy)
    local u2 = {};

    local function resolveImageParent(p3, p4) -- Line: 16
        -- upvalues: ScreenHost (ref)
        if p3.EmitParent then
            return p3.EmitParent;
        end;

        if p4 then
            local Parent = p4.Parent;

            while Parent and Parent ~= game do
                if Parent:GetAttribute("_PartIcleEmit") then
                    return p4.Parent;
                end;

                Parent = Parent.Parent;
            end;
        end;

        return ScreenHost.get();
    end;

    local function gatherFlipbookDecals(p5) -- Line: 29
        if not p5 then
            return nil;
        end;

        local v6 = {};

        for _, child in ipairs(p5:GetChildren()) do
            if child:IsA("Decal") then
                table.insert(v6, child);
            end;
        end;

        table.sort(v6, function(p7, p8) -- Line: 35
            local v9 = tonumber(p7.Name);
            local v10 = tonumber(p8.Name);

            if v9 and v10 then
                return v9 < v10;
            end;

            return p7.Name < p8.Name;
        end);

        return #v6 > 0 and v6 and v6 or nil;
    end;

    local function preloadEmitAssets(p11, p12) -- Line: 44
        -- upvalues: ContentProvider (ref)
        local u13 = {};

        if p12 then
            for _, v in ipairs(p12) do
                table.insert(u13, v);
            end;
        end;

        if p11.Image and p11.Image ~= "" then
            table.insert(u13, p11.Image);
        end;

        if #u13 == 0 then
            return;
        end;

        task.spawn(function() -- Line: 49
            -- upvalues: ContentProvider (ref), u13 (copy)
            pcall(ContentProvider.PreloadAsync, ContentProvider, u13);
        end);
    end;

    local function resolveFrame(p14, p15, p16) -- Line: 54
        if p15 <= 0 then
            return 0;
        end;

        local FlipbookMode = p14.FlipbookMode;
        local v17;

        if FlipbookMode == Enum.ParticleFlipbookMode.OneShot then
            local v18 = p14.LifeTime > 0 and (math.min(1, p16 / p14.LifeTime) or 1) or 1;
            local math_floor_ret = math.floor(v18 * p15);
            v17 = math.min(math_floor_ret, p15 - 1);
        elseif FlipbookMode == Enum.ParticleFlipbookMode.PingPong then
            local v19 = (p14.LifeTime > 0 and (math.min(1, p16 / p14.LifeTime) or 1) or 1) * 2;
            local v20;

            if v19 <= 1 then
                v20 = math.floor(v19 * p15);
            else
                v20 = math.floor((2 - v19) * p15);
            end;

            local math_min_ret = math.min(v20, p15 - 1);
            v17 = math.max(0, math_min_ret);
        elseif FlipbookMode == Enum.ParticleFlipbookMode.Random then
            local v21 = p14.FlipbookFramerate or 24;
            local math_floor_ret = math.floor(p16 / (v21 > 0 and 1 / v21 or 1));

            if p14._lastRandomInterval ~= math_floor_ret then
                p14._lastRandomInterval = math_floor_ret;
                p14._currentRandomFrame = math.random(0, p15 - 1);
            end;

            v17 = p14._currentRandomFrame or math.random(0, p15 - 1);
        else
            v17 = math.floor(p16 * p14.FlipbookFramerate + (p14.FlipbookStartOffset or 0) * p15) % p15;
        end;

        if p14.FlipbookReverse then
            v17 = p15 - 1 - v17;
        end;

        return v17;
    end;

    local function applyFlipbookFrame(p22, p23) -- Line: 84
        -- upvalues: resolveFrame (copy)
        if not p22.FlipbookFramerate or p22.FlipbookFramerate <= 0 then
            return;
        end;

        if p22.FlipbookSource == "Decals" and p22.FlipbookDecals then
            local v24 = #p22.FlipbookDecals;

            if v24 == 0 then
                return;
            end;

            local v25 = p22.FlipbookDecals[resolveFrame(p22, v24, p23) + 1];

            if v25 and v25.Texture then
                p22.VisualPart.Image = v25.Texture;
            end;
        elseif p22.FlipbookSource == "Spritesheet" then
            local math_max_ret = math.max(1, p22.GridCols or 1);
            local math_max_ret2 = math.max(1, p22.GridRows or 1);
            local v26 = resolveFrame(p22, math_max_ret * math_max_ret2, p23);
            local SheetSize = p22.SheetSize;

            if not SheetSize then
                return;
            end;

            local v27 = SheetSize.X / math_max_ret;
            local v28 = SheetSize.Y / math_max_ret2;
            p22.VisualPart.ImageRectSize = Vector2.new(v27, v28);
            p22.VisualPart.ImageRectOffset = Vector2.new(v26 % math_max_ret * v27, math.floor(v26 / math_max_ret) * v28);
        end;
    end;

    local function _simulateForward2D(p29, p30, p31, p32, p33) -- Line: 110
        -- upvalues: Graph (ref)
        local v34 = p32 / 60;
        local X = (p29.ImgAcceleration or Vector2.new()).X;
        local Y = (p29.ImgAcceleration or Vector2.new()).Y;
        local v35 = p29.ImgDrag or 0;
        local v36 = 0;
        local v37 = 0;
        local v38 = 0;
        local v39 = 0;

        for i = 1, 60 do
            local v40 = not p29.ImgSpeed and 0 or Graph.QueryPointsWithTime(i / 60, p29.ImgSpeed, p33.ImgSpeed) * 100;
            v37 = v37 + X * 100 * v34;
            v36 = v36 + Y * 100 * v34;

            if v35 > 0 then
                local math_max_ret = math.max(0, 1 - v35 * v34);
                v37 = v37 * math_max_ret;
                v36 = v36 * math_max_ret;
            end;

            v38 = v38 + (v40 * p30 + v37) * v34;
            v39 = v39 + (v40 * p31 + v36) * v34;
            local _ = i;
        end;

        return v38, v39, v37, v36;
    end;

    function u1._computeImageLabelEndState(p41, p42, p43, p44, p45, p46) -- Line: 137
        -- upvalues: _simulateForward2D (copy)
        return _simulateForward2D(p42, p43, p44, p45, p46);
    end;

    local function buildImageLabelPData(p47, p48, p49, p50) -- Line: 142
        -- upvalues: Range (ref), Graph (ref), u2 (copy), gatherFlipbookDecals (copy), _simulateForward2D (copy)
        local v51 = p47.ImgSpreadAngle or 0;
        local v52 = (p47.ImgEmissionAngle or 90) + (math.random() * 2 - 1) * v51;
        local math_rad_ret = math.rad(v52);
        local math_cos_ret = math.cos(math_rad_ret);
        local v53 = -math.sin(math_rad_ret);
        local v54 = Range.RandomValueFromRange(p47.Lifetime);
        local v55 = v54 <= 0 and 0.001 or v54;
        local v56 = {
            ImageTransparency = p47.ImageTransparency and (Graph.GenerateSeed(p47.ImageTransparency) or {}) or {},
            BackgroundTransparency = p47.BackgroundTransparency and (Graph.GenerateSeed(p47.BackgroundTransparency) or {}) or {},
            ImgSpeed = p47.ImgSpeed and (Graph.GenerateSeed(p47.ImgSpeed) or {}) or {},
            ImgRotSpeed = p47.ImgRotSpeed and (Graph.GenerateSeed(p47.ImgRotSpeed) or {}) or {},
            SizeScaleX = p47.SizeScaleX and (Graph.GenerateSeed(p47.SizeScaleX) or {}) or {},
            SizeScaleY = p47.SizeScaleY and (Graph.GenerateSeed(p47.SizeScaleY) or {}) or {},
            Timescale = p47.ImgTimescale and (Graph.GenerateSeed(p47.ImgTimescale) or {}) or {}
        };
        local v57 = Range.RandomValueFromRange(p47.ImgRotRange or NumberRange.new(0));
        local v58 = p47.ImgSizeUDim or UDim2.fromOffset(100, 100);

        if p47.ImageTransparency then
            p48.ImageTransparency = Graph.QueryPointsWithTime(0, p47.ImageTransparency, v56.ImageTransparency);
        end;

        if p47.BackgroundTransparency then
            p48.BackgroundTransparency = Graph.QueryPointsWithTime(0, p47.BackgroundTransparency, v56.BackgroundTransparency);
        end;

        if p47.ImageColor3 then
            p48.ImageColor3 = Graph.QueryColorPointWithTime(0, p47.ImageColor3);
        end;

        if p47.BackgroundColor3 then
            p48.BackgroundColor3 = Graph.QueryColorPointWithTime(0, p47.BackgroundColor3);
        end;

        p48.Image = p47.Image or "";
        p48.ScaleType = p47.ImgScaleType or Enum.ScaleType.Stretch;
        p48.ResampleMode = p47.ImgResampleMode or Enum.ResamplerMode.Default;
        p48.AnchorPoint = p47.ImgAnchorPoint or Vector2.new(0.5, 0.5);
        p48.ZIndex = p47.ImgZIndex or 1;
        p48.Rotation = v57;
        local v59 = p47.SizeScaleX and (Graph.QueryPointsWithTime(0, p47.SizeScaleX, v56.SizeScaleX) or 1) or 1;
        local v60 = p47.SizeScaleY and (Graph.QueryPointsWithTime(0, p47.SizeScaleY, v56.SizeScaleY) or 1) or 1;
        p48.Size = UDim2.new(v58.X.Scale * v59, v58.X.Offset * v59, v58.Y.Scale * v60, v58.Y.Offset * v60);
        p48.Position = p47.ImgPosition or UDim2.fromScale(0.5, 0.5);
        local v61 = not p47.ImgFlipbookFramerate and 10 or Range.RandomValueFromRange(p47.ImgFlipbookFramerate);
        local v62 = p47.ImgFlipbookStartRandom and (p47.ImgFlipbookMode or Enum.ParticleFlipbookMode.Loop) == Enum.ParticleFlipbookMode.Loop;
        local v63 = 0;
        local v64 = 0;
        local SheetSize = p47.SheetSize;
        local v65 = p47.ImgFlipbookSource or "Decals";

        if v65 == "Spritesheet" and (not SheetSize and (p47.Image and (p47.Image ~= "" and not u2[p47.Image]))) then
            u2[p47.Image] = true;
            warn(string.format("Part-Icles: Spritesheet flipbook  -  sheet dimensions unknown for %s. Emit will render full sheet until dimensions resolve.", p47.Image));
        end;

        if v65 == "Decals" then
            p48.ImageRectSize = Vector2.new(0, 0);
            p48.ImageRectOffset = Vector2.new(0, 0);
            local v66 = gatherFlipbookDecals(p47.ImageFlipbooks);

            if v66 and #v66 > 0 then
                local v67 = #v66;

                if v62 then
                    v63 = math.random(0, v67 - 1);
                    v64 = v63 / v67;
                end;

                local v68 = v66[v63 + 1];

                if v68 and (v68.Texture and v68.Texture ~= "") then
                    p48.Image = v68.Texture;
                end;
            end;
        elseif v65 == "Spritesheet" and SheetSize then
            local math_max_ret = math.max(1, p47.ImgGridCols or 1);
            local math_max_ret2 = math.max(1, p47.ImgGridRows or 1);
            local v69 = math_max_ret * math_max_ret2;

            if v62 and v69 > 0 then
                v63 = math.random(0, v69 - 1);
                v64 = v63 / v69;
            end;

            local v70 = SheetSize.X / math_max_ret;
            local v71 = SheetSize.Y / math_max_ret2;
            p48.ImageRectSize = Vector2.new(v70, v71);
            p48.ImageRectOffset = Vector2.new(v63 % math_max_ret * v70, math.floor(v63 / math_max_ret) * v71);
        end;

        local v72 = {
            Type = "ImageLabel",
            VisualPart = p48,
            StartTime = os.clock(),
            LifeTime = v55,
            TotalKeyFrames = math.max(1, p47.TotalKeyFrames or 100),
            CurrentStep = 0,
            PartLife = p47.PartLife or 0,
            BasePosition = p47.ImgPosition or UDim2.fromScale(0.5, 0.5),
            BaseSize = v58,
            DirX = math_cos_ret,
            DirY = v53,
            EnvVelX = 0,
            EnvVelY = 0,
            PosX = 0,
            PosY = 0,
            AccelX = (p47.ImgAcceleration or Vector2.new()).X,
            AccelY = (p47.ImgAcceleration or Vector2.new()).Y,
            Drag = p47.ImgDrag or 0,
            InitialRotation = v57,
            RotMode = p47.ImgRotMode or "OverLife",
            AccRot = 0,
            InvertMotion = p47.ImgInvertMotion or false,
            Graphs = {
                ImageTransparency = p47.ImageTransparency,
                BackgroundTransparency = p47.BackgroundTransparency,
                ImgSpeed = p47.ImgSpeed,
                ImgRotSpeed = p47.ImgRotSpeed,
                SizeScaleX = p47.SizeScaleX,
                SizeScaleY = p47.SizeScaleY,
                ImageColor3 = p47.ImageColor3,
                BackgroundColor3 = p47.BackgroundColor3,
                Timescale = p47.ImgTimescale
            },
            Seeds = v56,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(p47.ImgTimescale, v56.Timescale, v55),
            FlipbookSource = p47.ImgFlipbookSource or "Decals",
            FlipbookMode = p47.ImgFlipbookMode or Enum.ParticleFlipbookMode.Loop,
            FlipbookFramerate = v61,
            FlipbookStartOffset = v64,
            FlipbookReverse = p47.ImgFlipbookReverse or false,
            FlipbookDecals = gatherFlipbookDecals(p47.ImageFlipbooks),
            SheetSize = SheetSize,
            GridCols = p47.ImgGridCols or 8,
            GridRows = p47.ImgGridRows or 1,
            IsAnimate = p50 or nil,
            AnimateItem = p50 and p49 and p49 or nil
        };

        if p47.ImgInvertMotion then
            local v73, v74, v75, v76 = _simulateForward2D(p47, math_cos_ret, v53, v55, v56);
            v72.PosX = v73;
            v72.PosY = v74;
            v72.EnvVelX = v75;
            v72.EnvVelY = v76;
            v72._effectiveElapsed = v55;
            v72._invertDtSign = -1;
        end;

        return v72;
    end;

    function u1.EmitImageLabel(p77, p78, p79, p80) -- Line: 301
        -- upvalues: buildImageLabelPData (copy), u1 (copy), preloadEmitAssets (copy), resolveImageParent (copy)
        local Data = p77:GetData(p78);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v81 = Data.RenderTemplate:Clone();
        v81.Archivable = false;
        v81.Visible = true;
        v81:SetAttribute("_PartIcleEmit", true);
        local ImageFlipbooks = v81:FindFirstChild("ImageFlipbooks");

        if ImageFlipbooks then
            ImageFlipbooks:Destroy();
        end;

        local v82 = buildImageLabelPData(Data, v81, p78, false);
        v82.Link = p79;
        v82._sourceItem = p78;
        u1._seedTsOverride(v82, p78);
        v82.Events = Data.Events;
        preloadEmitAssets(Data, v82.FlipbookDecals);
        v81.Parent = resolveImageParent(Data, p78);
        p77:_registerEmit(v82, p80);

        for _, descendant in v81:GetDescendants() do
            if descendant:GetAttribute("Transformed") and descendant:IsA("ImageLabel") then
                p77:EnableEmit(descendant, nil, p80);
            end;
        end;
    end;

    function u1.EmitImageLabelAnimate(p83, p84, p85, p86) -- Line: 331
        -- upvalues: buildImageLabelPData (copy), u1 (copy), preloadEmitAssets (copy), resolveImageParent (copy)
        if p83.ActiveAnimates[p84] then
            return;
        end;

        local Data = p83:GetData(p84);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v87 = Data.RenderTemplate:Clone();
        v87.Archivable = false;
        v87.Visible = true;
        v87:SetAttribute("_PartIcleEmit", true);
        local ImageFlipbooks = v87:FindFirstChild("ImageFlipbooks");

        if ImageFlipbooks then
            ImageFlipbooks:Destroy();
        end;

        local v88 = buildImageLabelPData(Data, v87, p84, true);
        v88.Link = p85;
        v88._sourceItem = p84;
        u1._seedTsOverride(v88, p84);
        v88.Events = Data.Events;
        preloadEmitAssets(Data, v88.FlipbookDecals);
        v87.Parent = resolveImageParent(Data, p84);
        p83.ActiveAnimates[p84] = v88;
        p83:_registerEmit(v88, p86);

        for _, descendant in v87:GetDescendants() do
            if descendant:GetAttribute("Transformed") and descendant:IsA("ImageLabel") then
                p83:EnableEmit(descendant, nil, p86);
            end;
        end;
    end;

    function u1.UpdateImageLabel(p89, p90, p91, p92) -- Line: 360
        -- upvalues: Graph (ref), applyFlipbookFrame (copy)
        local VisualPart = p90.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p90.TotalKeyFrames <= 0 then
            return true;
        end;

        local math_max_ret = math.max((p92 - p90.StartTime) / p90.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v93;

        if p90._tsOverride == nil or p92 >= (p90._tsOverrideUntil or 0) then
            v93 = p90.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p90.Graphs.Timescale, p90.Seeds.Timescale) or 1) or 1;
        else
            v93 = p90._tsOverride;
        end;

        local v94 = p91 * v93;

        if p90._invertDtSign then
            v94 = v94 * p90._invertDtSign;
        end;

        local LifeTime = p90.LifeTime;
        local v95 = p90._effectiveElapsed or 0;
        local v96 = v95 + (p90._timeFrozen and 0 or v94);
        local v97 = v96 < 0 and 0 or v96;

        if LifeTime < v97 then
            v97 = LifeTime;
        end;

        p90._effectiveElapsed = v97;
        local v98 = v97 - v95;
        local v99 = v97 / LifeTime;
        local v100 = v99 > 1 and 1 or v99;
        local v101 = v100 < 0 and 0 or v100;
        local Graphs = p90.Graphs;
        local Seeds = p90.Seeds;
        local v102;

        if Graphs.ImgSpeed then
            v102 = Graph.QueryPointsWithTime(v101, Graphs.ImgSpeed, Seeds.ImgSpeed) * 100;

            if p90.Drag > 0 then
                v102 = v102 * math.exp(-p90.Drag * v97);
            end;
        else
            v102 = 0;
        end;

        p90.EnvVelX = p90.EnvVelX + p90.AccelX * 100 * v98;
        p90.EnvVelY = p90.EnvVelY + p90.AccelY * 100 * v98;

        if p90.Drag > 0 then
            local math_max_ret2 = math.max(0, 1 - p90.Drag * v98);
            p90.EnvVelX = p90.EnvVelX * math_max_ret2;
            p90.EnvVelY = p90.EnvVelY * math_max_ret2;
        end;

        local v103 = v102 * p90.DirY + p90.EnvVelY;
        p90.PosX = p90.PosX + (v102 * p90.DirX + p90.EnvVelX) * v98;
        p90.PosY = p90.PosY + v103 * v98;
        local BasePosition = p90.BasePosition;
        VisualPart.Position = UDim2.new(BasePosition.X.Scale, BasePosition.X.Offset + p90.PosX, BasePosition.Y.Scale, BasePosition.Y.Offset + p90.PosY);

        if Graphs.ImgRotSpeed then
            local v104 = Graph.QueryPointsWithTime(v101, Graphs.ImgRotSpeed, Seeds.ImgRotSpeed);

            if p90.RotMode == "Speed" then
                p90.AccRot = p90.AccRot + v104 * v98;
                VisualPart.Rotation = p90.InitialRotation + p90.AccRot;
            else
                VisualPart.Rotation = p90.InitialRotation + v104;
            end;
        end;

        if (Graphs.SizeScaleX or Graphs.SizeScaleY) and not p90.SkipSize then
            local v105 = Graphs.SizeScaleX and (Graph.QueryPointsWithTime(v101, Graphs.SizeScaleX, Seeds.SizeScaleX) or 1) or 1;
            local v106 = Graphs.SizeScaleY and (Graph.QueryPointsWithTime(v101, Graphs.SizeScaleY, Seeds.SizeScaleY) or 1) or 1;
            local BaseSize = p90.BaseSize;
            VisualPart.Size = UDim2.new(BaseSize.X.Scale * v105, BaseSize.X.Offset * v105, BaseSize.Y.Scale * v106, BaseSize.Y.Offset * v106);
        end;

        local math_floor_ret = math.floor(v101 * p90.TotalKeyFrames);

        if math_floor_ret ~= p90.CurrentStep then
            p90.CurrentStep = math_floor_ret;
            local v107 = p90.CurrentStep / p90.TotalKeyFrames;

            if Graphs.ImageTransparency and not p90.SkipTransparency then
                VisualPart.ImageTransparency = Graph.QueryPointsWithTime(v107, Graphs.ImageTransparency, Seeds.ImageTransparency);
            end;

            if Graphs.BackgroundTransparency and not p90.SkipTransparency then
                VisualPart.BackgroundTransparency = Graph.QueryPointsWithTime(v107, Graphs.BackgroundTransparency, Seeds.BackgroundTransparency);
            end;

            if Graphs.ImageColor3 and not p90.SkipColor then
                VisualPart.ImageColor3 = Graph.QueryColorPointWithTime(v107, Graphs.ImageColor3);
            end;

            if Graphs.BackgroundColor3 and not p90.SkipColor then
                VisualPart.BackgroundColor3 = Graph.QueryColorPointWithTime(v107, Graphs.BackgroundColor3);
            end;
        end;

        applyFlipbookFrame(p90, v97);

        return math_min_ret >= 1 and (LifeTime <= v97 or v97 <= 0);
    end;

    function u1._refreshImageLabelAnimateNonSpatial(p108, p109, p110) -- Line: 456
        -- upvalues: Range (ref), gatherFlipbookDecals (copy), Graph (ref)
        if not p110 then
            return;
        end;

        local v111 = p110.ImgSpreadAngle or 0;
        local v112 = (p110.ImgEmissionAngle or 90) + (math.random() * 2 - 1) * v111;
        local math_rad_ret = math.rad(v112);
        local math_cos_ret = math.cos(math_rad_ret);
        local v113 = -math.sin(math_rad_ret);
        p109.DirX = math_cos_ret;
        p109.DirY = v113;

        if p110.ImgAcceleration then
            p109.AccelX = p110.ImgAcceleration.X;
            p109.AccelY = p110.ImgAcceleration.Y;
        end;

        if p110.ImgDrag ~= nil then
            p109.Drag = p110.ImgDrag;
        end;

        if p110.ImgPosition then
            p109.BasePosition = p110.ImgPosition;
        end;

        if p110.ImgSizeUDim then
            p109.BaseSize = p110.ImgSizeUDim;
        end;

        if p110.ImgRotMode then
            p109.RotMode = p110.ImgRotMode;
        end;

        if p110.ImgRotRange then
            p109.InitialRotation = Range.RandomValueFromRange(p110.ImgRotRange);
        end;

        if p110.ImgFlipbookSource then
            p109.FlipbookSource = p110.ImgFlipbookSource;
        end;

        if p110.ImgFlipbookMode then
            p109.FlipbookMode = p110.ImgFlipbookMode;
        end;

        if p110.ImgFlipbookFramerate then
            p109.FlipbookFramerate = Range.RandomValueFromRange(p110.ImgFlipbookFramerate);
        end;

        if p110.ImgFlipbookReverse ~= nil then
            p109.FlipbookReverse = p110.ImgFlipbookReverse;
        end;

        if p110.ImgGridCols then
            p109.GridCols = p110.ImgGridCols;
        end;

        if p110.ImgGridRows then
            p109.GridRows = p110.ImgGridRows;
        end;

        if p110.SheetSize ~= nil then
            p109.SheetSize = p110.SheetSize;
        end;

        if p110.ImageFlipbooks then
            p109.FlipbookDecals = gatherFlipbookDecals(p110.ImageFlipbooks);
        end;

        if p110.ImgTimescale and p109.Graphs then
            p109.Graphs.Timescale = p110.ImgTimescale;
            p109.Seeds.Timescale = Graph.GenerateSeed(p110.ImgTimescale);
        end;
    end;
end;