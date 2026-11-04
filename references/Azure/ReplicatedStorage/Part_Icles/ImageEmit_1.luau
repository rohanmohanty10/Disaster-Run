 
 

local Preload = require(script.Parent.Preload);
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local ScreenHost = require(script.Parent.ScreenHost);
local Pool = require(script.Parent.Pool);
local StaticPass = require(script.Parent.StaticPass);
local Log = require(script.Parent.Log);

return function(u1) -- Line: 13
    -- upvalues: ScreenHost (copy), Preload (copy), Graph (copy), Range (copy), Log (copy), StaticPass (copy), Pool (copy)
    local u2 = {};

    local function resolveImageParent(p3, p4, p5) -- Line: 20
        -- upvalues: ScreenHost (ref)
        if p3.EmitParent then
            return p3.EmitParent;
        end;

        if p5 then
            p5 = p5._parentCloneMap;
        end;

        if p5 and (p4 and (p4.Parent and p5[p4.Parent])) then
            return p5[p4.Parent];
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

    local function gatherFlipbookDecals(p6) -- Line: 35
        if not p6 then
            return nil;
        end;

        local v7 = {};

        for _, child in ipairs(p6:GetChildren()) do
            if child:IsA("Decal") then
                table.insert(v7, child);
            end;
        end;

        table.sort(v7, function(p8, p9) -- Line: 41
            local v10 = tonumber(p8.Name);
            local v11 = tonumber(p9.Name);

            if v10 and v11 then
                return v10 < v11;
            end;

            return p8.Name < p9.Name;
        end);

        return #v7 > 0 and v7 and v7 or nil;
    end;

    local function preloadEmitAssets(p12, p13) -- Line: 50
        -- upvalues: Preload (ref)
        local v14 = {};

        if p13 then
            for _, v in ipairs(p13) do
                table.insert(v14, v);
            end;
        end;

        if p12.Image and p12.Image ~= "" then
            table.insert(v14, p12.Image);
        end;

        if #v14 == 0 then
            return;
        end;

        Preload.ask(v14);
    end;

    local function preloadAndWait(p15, p16, p17, p18) -- Line: 60
        -- upvalues: Preload (ref)
        if not (p15 and p16) then
            return;
        end;

        local _preloadedAssets = p15._preloadedAssets;

        if not _preloadedAssets then
            return;
        end;

        if _preloadedAssets[p16] then
            return;
        end;

        local v19 = {};

        if p18 then
            for _, v in ipairs(p18) do
                table.insert(v19, v);
            end;
        end;

        if p17.Image and p17.Image ~= "" then
            table.insert(v19, p17.Image);
        end;

        _preloadedAssets[p16] = true;

        if #v19 == 0 then
            return;
        end;

        Preload.wait(v19);
    end;

    local function resolveFrame(p20, p21, p22) -- Line: 75
        if p21 <= 0 then
            return 0;
        end;

        local FlipbookMode = p20.FlipbookMode;
        local v23;

        if FlipbookMode == Enum.ParticleFlipbookMode.OneShot then
            local v24 = p20.LifeTime > 0 and (math.min(1, p22 / p20.LifeTime) or 1) or 1;
            local math_floor_ret = math.floor(v24 * p21);
            v23 = math.min(math_floor_ret, p21 - 1);
        elseif FlipbookMode == Enum.ParticleFlipbookMode.PingPong then
            local v25 = (p20.LifeTime > 0 and (math.min(1, p22 / p20.LifeTime) or 1) or 1) * 2;
            local v26;

            if v25 <= 1 then
                v26 = math.floor(v25 * p21);
            else
                v26 = math.floor((2 - v25) * p21);
            end;

            local math_min_ret = math.min(v26, p21 - 1);
            v23 = math.max(0, math_min_ret);
        elseif FlipbookMode == Enum.ParticleFlipbookMode.Random then
            local v27 = p20.FlipbookFramerate or 24;
            local math_floor_ret = math.floor(p22 / (v27 > 0 and 1 / v27 or 1));

            if p20._lastRandomInterval ~= math_floor_ret then
                p20._lastRandomInterval = math_floor_ret;
                p20._currentRandomFrame = math.random(0, p21 - 1);
            end;

            v23 = p20._currentRandomFrame or math.random(0, p21 - 1);
        else
            v23 = math.floor(p22 * p20.FlipbookFramerate + (p20.FlipbookStartOffset or 0) * p21) % p21;
        end;

        if p20.FlipbookReverse then
            v23 = p21 - 1 - v23;
        end;

        return v23;
    end;

    local function applyFlipbookFrame(p28, p29) -- Line: 106
        -- upvalues: resolveFrame (copy)
        if not p28.FlipbookFramerate or p28.FlipbookFramerate <= 0 then
            return;
        end;

        if p28.FlipbookSource == "Decals" and p28.FlipbookDecals then
            local v30 = #p28.FlipbookDecals;

            if v30 == 0 then
                return;
            end;

            local v31 = resolveFrame(p28, v30, p29);

            if v31 == p28._lastFlipbookFrame then
                return;
            end;

            p28._lastFlipbookFrame = v31;
            local v32 = p28.FlipbookDecals[v31 + 1];

            if v32 and v32.Texture then
                p28.VisualPart.Image = v32.Texture;
            end;
        elseif p28.FlipbookSource == "Spritesheet" then
            local math_max_ret = math.max(1, p28.GridCols or 1);
            local math_max_ret2 = math.max(1, p28.GridRows or 1);
            local v33 = resolveFrame(p28, math_max_ret * math_max_ret2, p29);
            local SheetSize = p28.SheetSize;

            if not SheetSize then
                return;
            end;

            if v33 == p28._lastFlipbookFrame then
                return;
            end;

            p28._lastFlipbookFrame = v33;
            local v34 = SheetSize.X / math_max_ret;
            local v35 = SheetSize.Y / math_max_ret2;
            p28.VisualPart.ImageRectSize = Vector2.new(v34, v35);
            p28.VisualPart.ImageRectOffset = Vector2.new(v33 % math_max_ret * v34, math.floor(v33 / math_max_ret) * v35);
        end;
    end;

    local function _simulateForward2D(p36, p37, p38, p39, p40) -- Line: 137
        -- upvalues: Graph (ref)
        local v41 = p39 / 60;
        local X = (p36.ImgAcceleration or Vector2.new()).X;
        local Y = (p36.ImgAcceleration or Vector2.new()).Y;
        local v42 = p36.ImgDrag or 0;
        local v43 = 0;
        local v44 = 0;
        local v45 = 0;
        local v46 = 0;

        for i = 1, 60 do
            local v47 = not p36.ImgSpeed and 0 or Graph.QueryPointsWithTime(i / 60, p36.ImgSpeed, p40.ImgSpeed) * 100;
            v44 = v44 + X * 100 * v41;
            v43 = v43 + Y * 100 * v41;

            if v42 > 0 then
                local math_max_ret = math.max(0, 1 - v42 * v41);
                v44 = v44 * math_max_ret;
                v43 = v43 * math_max_ret;
            end;

            v45 = v45 + (v47 * p37 + v44) * v41;
            v46 = v46 + (v47 * p38 + v43) * v41;
            local _ = i;
        end;

        return v45, v46, v44, v43;
    end;

    function u1._computeImageLabelEndState(p48, p49, p50, p51, p52, p53) -- Line: 164
        -- upvalues: _simulateForward2D (copy)
        return _simulateForward2D(p49, p50, p51, p52, p53);
    end;

    local function buildImageLabelPData(p54, p55, p56, p57) -- Line: 169
        -- upvalues: gatherFlipbookDecals (copy), Range (ref), Graph (ref), u2 (copy), Log (ref), _simulateForward2D (copy), StaticPass (ref)
        local v58 = gatherFlipbookDecals(p54.ImageFlipbooks);
        local v59 = p54.ImgSpreadAngle or 0;
        local v60 = (p54.ImgEmissionAngle or 90) + (math.random() * 2 - 1) * v59;
        local math_rad_ret = math.rad(v60);
        local math_cos_ret = math.cos(math_rad_ret);
        local v61 = -math.sin(math_rad_ret);
        local v62 = Range.RandomValueFromRange(p54.Lifetime);
        local v63 = v62 <= 0 and 0.001 or v62;
        local v64 = {
            ImageTransparency = p54.ImageTransparency and (Graph.GenerateSeed(p54.ImageTransparency) or {}) or {},
            BackgroundTransparency = p54.BackgroundTransparency and (Graph.GenerateSeed(p54.BackgroundTransparency) or {}) or {},
            ImgSpeed = p54.ImgSpeed and (Graph.GenerateSeed(p54.ImgSpeed) or {}) or {},
            ImgRotSpeed = p54.ImgRotSpeed and (Graph.GenerateSeed(p54.ImgRotSpeed) or {}) or {},
            SizeScaleX = p54.SizeScaleX and (Graph.GenerateSeed(p54.SizeScaleX) or {}) or {},
            SizeScaleY = p54.SizeScaleY and (Graph.GenerateSeed(p54.SizeScaleY) or {}) or {},
            Timescale = p54.ImgTimescale and (Graph.GenerateSeed(p54.ImgTimescale) or {}) or {}
        };
        local v65 = Range.RandomValueFromRange(p54.ImgRotRange or NumberRange.new(0));
        local v66 = p54.ImgSizeUDim or UDim2.fromOffset(100, 100);

        if p54.ImageTransparency then
            p55.ImageTransparency = Graph.QueryPointsWithTime(0, p54.ImageTransparency, v64.ImageTransparency);
        end;

        if p54.BackgroundTransparency then
            p55.BackgroundTransparency = Graph.QueryPointsWithTime(0, p54.BackgroundTransparency, v64.BackgroundTransparency);
        end;

        if p54.ImageColor3 then
            p55.ImageColor3 = Graph.QueryColorPointWithTime(0, p54.ImageColor3);
        end;

        if p54.BackgroundColor3 then
            p55.BackgroundColor3 = Graph.QueryColorPointWithTime(0, p54.BackgroundColor3);
        end;

        p55.Image = p54.Image or "";
        p55.ScaleType = p54.ImgScaleType or Enum.ScaleType.Stretch;
        p55.ResampleMode = p54.ImgResampleMode or Enum.ResamplerMode.Default;
        p55.AnchorPoint = p54.ImgAnchorPoint or Vector2.new(0.5, 0.5);
        p55.ZIndex = p54.ImgZIndex or 1;
        p55.Rotation = v65;
        local v67 = p54.SizeScaleX and (Graph.QueryPointsWithTime(0, p54.SizeScaleX, v64.SizeScaleX) or 1) or 1;
        local v68 = p54.SizeScaleY and (Graph.QueryPointsWithTime(0, p54.SizeScaleY, v64.SizeScaleY) or 1) or 1;
        p55.Size = UDim2.new(v66.X.Scale * v67, v66.X.Offset * v67, v66.Y.Scale * v68, v66.Y.Offset * v68);
        p55.Position = p54.ImgPosition or UDim2.fromScale(0.5, 0.5);
        local v69 = not p54.ImgFlipbookFramerate and 10 or Range.RandomValueFromRange(p54.ImgFlipbookFramerate);
        local v70 = p54.ImgFlipbookStartRandom and (p54.ImgFlipbookMode or Enum.ParticleFlipbookMode.Loop) == Enum.ParticleFlipbookMode.Loop;
        local v71 = 0;
        local v72 = 0;
        local SheetSize = p54.SheetSize;
        local v73 = p54.ImgFlipbookSource or "Decals";

        if v73 == "Spritesheet" and (not SheetSize and (p54.Image and (p54.Image ~= "" and not u2[p54.Image]))) then
            u2[p54.Image] = true;
            Log.warn(string.format("Part-Icles: Spritesheet flipbook  -  sheet dimensions unknown for %s. Emit will render full sheet until dimensions resolve.", p54.Image));
        end;

        if v73 == "Decals" then
            p55.ImageRectSize = Vector2.new(0, 0);
            p55.ImageRectOffset = Vector2.new(0, 0);

            if v58 and #v58 > 0 then
                local v74 = #v58;

                if v70 then
                    v71 = math.random(0, v74 - 1);
                    v72 = v71 / v74;
                end;

                local v75 = v58[v71 + 1];

                if v75 and (v75.Texture and v75.Texture ~= "") then
                    p55.Image = v75.Texture;
                end;
            end;
        elseif v73 == "Spritesheet" and SheetSize then
            local math_max_ret = math.max(1, p54.ImgGridCols or 1);
            local math_max_ret2 = math.max(1, p54.ImgGridRows or 1);
            local v76 = math_max_ret * math_max_ret2;

            if v70 and v76 > 0 then
                v71 = math.random(0, v76 - 1);
                v72 = v71 / v76;
            end;

            local v77 = SheetSize.X / math_max_ret;
            local v78 = SheetSize.Y / math_max_ret2;
            p55.ImageRectSize = Vector2.new(v77, v78);
            p55.ImageRectOffset = Vector2.new(v71 % math_max_ret * v77, math.floor(v71 / math_max_ret) * v78);
        end;

        local v79 = {
            Type = "ImageLabel",
            VisualPart = p55,
            StartTime = os.clock(),
            LifeTime = v63,
            TotalKeyFrames = math.max(1, p54.TotalKeyFrames or 100),
            CurrentStep = 0,
            PartLife = p54.PartLife or 0,
            BasePosition = p54.ImgPosition or UDim2.fromScale(0.5, 0.5),
            BaseSize = v66,
            DirX = math_cos_ret,
            DirY = v61,
            EnvVelX = 0,
            EnvVelY = 0,
            PosX = 0,
            PosY = 0,
            AccelX = (p54.ImgAcceleration or Vector2.new()).X,
            AccelY = (p54.ImgAcceleration or Vector2.new()).Y,
            Drag = p54.ImgDrag or 0,
            InitialRotation = v65,
            RotMode = p54.ImgRotMode or "OverLife",
            AccRot = 0,
            InvertMotion = p54.ImgInvertMotion or false,
            Graphs = {
                ImageTransparency = p54.ImageTransparency,
                BackgroundTransparency = p54.BackgroundTransparency,
                ImgSpeed = p54.ImgSpeed,
                ImgRotSpeed = p54.ImgRotSpeed,
                SizeScaleX = p54.SizeScaleX,
                SizeScaleY = p54.SizeScaleY,
                ImageColor3 = p54.ImageColor3,
                BackgroundColor3 = p54.BackgroundColor3,
                Timescale = p54.ImgTimescale
            },
            Seeds = v64,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(p54.ImgTimescale, v64.Timescale, v63),
            FlipbookSource = p54.ImgFlipbookSource or "Decals",
            FlipbookMode = p54.ImgFlipbookMode or Enum.ParticleFlipbookMode.Loop,
            FlipbookFramerate = v69,
            FlipbookStartOffset = v72,
            FlipbookReverse = p54.ImgFlipbookReverse or false,
            FlipbookDecals = v58,
            SheetSize = SheetSize,
            GridCols = p54.ImgGridCols or 8,
            GridRows = p54.ImgGridRows or 1,
            IsAnimate = p57 or nil,
            AnimateItem = p57 and p56 and p56 or nil
        };

        if p54.ImgInvertMotion then
            local v80, v81, v82, v83 = _simulateForward2D(p54, math_cos_ret, v61, v63, v64);
            v79.PosX = v80;
            v79.PosY = v81;
            v79.EnvVelX = v82;
            v79.EnvVelY = v83;
            v79._effectiveElapsed = v63;
            v79._invertDtSign = -1;
        end;

        StaticPass.apply(v79);

        if v79._staticSizeScaleX and v79._staticSizeScaleY then
            v79._staticSizeScaleX = nil;
            v79._staticSizeScaleY = nil;
        end;

        return v79;
    end;

    function u1.EmitImageLabel(p84, p85, p86, p87) -- Line: 346
        -- upvalues: Preload (ref), Pool (ref), buildImageLabelPData (copy), u1 (copy), preloadEmitAssets (copy), resolveImageParent (copy)
        local EmitData = p84:GetEmitData(p85, p87);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local RenderTemplate = EmitData.RenderTemplate;

        if p84 and RenderTemplate then
            local _preloadedAssets = p84._preloadedAssets;

            if _preloadedAssets and not _preloadedAssets[RenderTemplate] then
                local v88 = {};

                if EmitData.Image and EmitData.Image ~= "" then
                    table.insert(v88, EmitData.Image);
                end;

                _preloadedAssets[RenderTemplate] = true;

                if #v88 ~= 0 then
                    Preload.wait(v88);
                end;
            end;
        end;

        local v89 = Pool.acquireOrClone(EmitData.RenderTemplate, "ImageLabel", EmitData.Pool);
        v89.Archivable = false;
        v89.Visible = true;
        local ImageFlipbooks = v89:FindFirstChild("ImageFlipbooks");

        if ImageFlipbooks then
            ImageFlipbooks:Destroy();
        end;

        local v90 = buildImageLabelPData(EmitData, v89, p85, false);
        v90.Link = p86;
        v90._sourceItem = p85;
        u1._seedTsOverride(v90, p85);
        v90.Events = EmitData.Events;

        if EmitData.Pool ~= false then
            v90._sourceRT = EmitData.RenderTemplate;
            v90._poolKind = "ImageLabel";
        end;

        preloadEmitAssets(EmitData, v90.FlipbookDecals);
        v89.Parent = resolveImageParent(EmitData, p85, p87);
        p84:_registerEmit(v90, p87);

        for _, descendant in v89:GetDescendants() do
            if descendant:GetAttribute("Transformed") and descendant:IsA("ImageLabel") then
                p84:EnableEmit(descendant, nil, p87);
            end;
        end;
    end;

    function u1.EmitImageLabelAnimate(p91, p92, p93, p94) -- Line: 380
        -- upvalues: Preload (ref), buildImageLabelPData (copy), u1 (copy), preloadEmitAssets (copy), resolveImageParent (copy)
        if p91.ActiveAnimates[p92] then
            return;
        end;

        local EmitData = p91:GetEmitData(p92, p94);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local RenderTemplate = EmitData.RenderTemplate;

        if p91 and RenderTemplate then
            local _preloadedAssets = p91._preloadedAssets;

            if _preloadedAssets and not _preloadedAssets[RenderTemplate] then
                local v95 = {};

                if EmitData.Image and EmitData.Image ~= "" then
                    table.insert(v95, EmitData.Image);
                end;

                _preloadedAssets[RenderTemplate] = true;

                if #v95 ~= 0 then
                    Preload.wait(v95);
                end;
            end;
        end;

        local v96 = EmitData.RenderTemplate:Clone();
        v96.Archivable = false;
        v96.Visible = true;
        v96:SetAttribute("_PartIcleEmit", true);
        local ImageFlipbooks = v96:FindFirstChild("ImageFlipbooks");

        if ImageFlipbooks then
            ImageFlipbooks:Destroy();
        end;

        local v97 = buildImageLabelPData(EmitData, v96, p92, true);
        v97.Link = p93;
        v97._sourceItem = p92;
        u1._seedTsOverride(v97, p92);
        v97.Events = EmitData.Events;
        preloadEmitAssets(EmitData, v97.FlipbookDecals);
        v96.Parent = resolveImageParent(EmitData, p92, p94);
        p91.ActiveAnimates[p92] = v97;
        p91:_registerEmit(v97, p94);

        for _, descendant in v96:GetDescendants() do
            if descendant:GetAttribute("Transformed") and descendant:IsA("ImageLabel") then
                p91:EnableEmit(descendant, nil, p94);
            end;
        end;
    end;

    function u1.UpdateImageLabel(p98, p99, p100, p101) -- Line: 412
        -- upvalues: Graph (ref), applyFlipbookFrame (copy)
        local VisualPart = p99.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p99.TotalKeyFrames <= 0 then
            return true;
        end;

        local math_max_ret = math.max((p101 - p99.StartTime) / p99.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v102;

        if p99._tsOverride == nil or p101 >= (p99._tsOverrideUntil or 0) then
            v102 = p99.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p99.Graphs.Timescale, p99.Seeds.Timescale) or 1) or 1;
        else
            v102 = p99._tsOverride;
        end;

        local v103 = p100 * v102;

        if p99._invertDtSign then
            v103 = v103 * p99._invertDtSign;
        end;

        local LifeTime = p99.LifeTime;
        local v104 = p99._effectiveElapsed or 0;
        local v105 = v104 + (p99._timeFrozen and 0 or v103);
        local v106 = v105 < 0 and 0 or v105;

        if LifeTime < v106 then
            v106 = LifeTime;
        end;

        p99._effectiveElapsed = v106;
        local v107 = v106 / LifeTime;
        local v108 = v107 > 1 and 1 or v107;
        local Graphs = p99.Graphs;
        local Seeds = p99.Seeds;
        p99.AccumulatedDT = (p99.AccumulatedDT or 0) + (v106 - v104);
        local math_floor_ret = math.floor((v108 < 0 and 0 or v108) * p99.TotalKeyFrames);

        if math_floor_ret ~= p99.CurrentStep then
            local AccumulatedDT = p99.AccumulatedDT;
            p99.AccumulatedDT = 0;
            p99.CurrentStep = math_floor_ret;
            local v109 = math_floor_ret / p99.TotalKeyFrames;
            local v110 = 0;

            if p99._staticImgSpeed then
                v110 = p99._staticImgSpeed * 100;
            elseif Graphs.ImgSpeed then
                v110 = Graph.QueryPointsWithTime(v109, Graphs.ImgSpeed, Seeds.ImgSpeed) * 100;
            end;

            if v110 ~= 0 and p99.Drag > 0 then
                v110 = v110 * math.exp(-p99.Drag * v106);
            end;

            p99.EnvVelX = p99.EnvVelX + p99.AccelX * 100 * AccumulatedDT;
            p99.EnvVelY = p99.EnvVelY + p99.AccelY * 100 * AccumulatedDT;

            if p99.Drag > 0 then
                local math_max_ret2 = math.max(0, 1 - p99.Drag * AccumulatedDT);
                p99.EnvVelX = p99.EnvVelX * math_max_ret2;
                p99.EnvVelY = p99.EnvVelY * math_max_ret2;
            end;

            local v111 = v110 * p99.DirY + p99.EnvVelY;
            p99.PosX = p99.PosX + (v110 * p99.DirX + p99.EnvVelX) * AccumulatedDT;
            p99.PosY = p99.PosY + v111 * AccumulatedDT;
            local BasePosition = p99.BasePosition;
            VisualPart.Position = UDim2.new(BasePosition.X.Scale, BasePosition.X.Offset + p99.PosX, BasePosition.Y.Scale, BasePosition.Y.Offset + p99.PosY);
            local v112 = nil;

            if p99._staticImgRotSpeed then
                v112 = p99._staticImgRotSpeed;
            elseif Graphs.ImgRotSpeed then
                v112 = Graph.QueryPointsWithTime(v109, Graphs.ImgRotSpeed, Seeds.ImgRotSpeed);
            end;

            if v112 then
                local v113;

                if p99.RotMode == "Speed" then
                    p99.AccRot = p99.AccRot + v112 * AccumulatedDT;
                    v113 = p99.InitialRotation + p99.AccRot;
                else
                    v113 = p99.InitialRotation + v112;
                end;

                if v113 ~= p99._lastRotation then
                    VisualPart.Rotation = v113;
                    p99._lastRotation = v113;
                end;
            end;

            if (p99._staticSizeScaleX or Graphs.SizeScaleX or (p99._staticSizeScaleY or Graphs.SizeScaleY)) and not p99.SkipSize then
                local v114 = p99._staticSizeScaleX or (Graphs.SizeScaleX and (Graph.QueryPointsWithTime(v109, Graphs.SizeScaleX, Seeds.SizeScaleX) or 1) or 1);
                local v115 = p99._staticSizeScaleY or (Graphs.SizeScaleY and (Graph.QueryPointsWithTime(v109, Graphs.SizeScaleY, Seeds.SizeScaleY) or 1) or 1);

                if v114 ~= p99._lastSizeX or v115 ~= p99._lastSizeY then
                    local BaseSize = p99.BaseSize;
                    VisualPart.Size = UDim2.new(BaseSize.X.Scale * v114, BaseSize.X.Offset * v114, BaseSize.Y.Scale * v115, BaseSize.Y.Offset * v115);
                    p99._lastSizeX = v114;
                    p99._lastSizeY = v115;
                end;
            end;

            if Graphs.ImageTransparency and not p99.SkipTransparency then
                VisualPart.ImageTransparency = Graph.QueryPointsWithTime(v109, Graphs.ImageTransparency, Seeds.ImageTransparency);
            end;

            if Graphs.BackgroundTransparency and not p99.SkipTransparency then
                VisualPart.BackgroundTransparency = Graph.QueryPointsWithTime(v109, Graphs.BackgroundTransparency, Seeds.BackgroundTransparency);
            end;

            if Graphs.ImageColor3 and not p99.SkipColor then
                VisualPart.ImageColor3 = Graph.QueryColorPointWithTime(v109, Graphs.ImageColor3);
            end;

            if Graphs.BackgroundColor3 and not p99.SkipColor then
                VisualPart.BackgroundColor3 = Graph.QueryColorPointWithTime(v109, Graphs.BackgroundColor3);
            end;
        end;

        applyFlipbookFrame(p99, v106);

        return math_min_ret >= 1 and (LifeTime <= v106 or v106 <= 0);
    end;

    function u1._refreshImageLabelAnimateNonSpatial(p116, p117, p118) -- Line: 543
        -- upvalues: Range (ref), gatherFlipbookDecals (copy), Graph (ref)
        if not p118 then
            return;
        end;

        local v119 = p118.ImgSpreadAngle or 0;
        local v120 = (p118.ImgEmissionAngle or 90) + (math.random() * 2 - 1) * v119;
        local math_rad_ret = math.rad(v120);
        local math_cos_ret = math.cos(math_rad_ret);
        local v121 = -math.sin(math_rad_ret);
        p117.DirX = math_cos_ret;
        p117.DirY = v121;

        if p118.ImgAcceleration then
            p117.AccelX = p118.ImgAcceleration.X;
            p117.AccelY = p118.ImgAcceleration.Y;
        end;

        if p118.ImgDrag ~= nil then
            p117.Drag = p118.ImgDrag;
        end;

        if p118.ImgPosition then
            p117.BasePosition = p118.ImgPosition;
        end;

        if p118.ImgSizeUDim then
            p117.BaseSize = p118.ImgSizeUDim;
        end;

        if p118.ImgRotMode then
            p117.RotMode = p118.ImgRotMode;
        end;

        if p118.ImgRotRange then
            p117.InitialRotation = Range.RandomValueFromRange(p118.ImgRotRange);
        end;

        if p118.ImgFlipbookSource then
            p117.FlipbookSource = p118.ImgFlipbookSource;
        end;

        if p118.ImgFlipbookMode then
            p117.FlipbookMode = p118.ImgFlipbookMode;
        end;

        if p118.ImgFlipbookFramerate then
            p117.FlipbookFramerate = Range.RandomValueFromRange(p118.ImgFlipbookFramerate);
        end;

        if p118.ImgFlipbookReverse ~= nil then
            p117.FlipbookReverse = p118.ImgFlipbookReverse;
        end;

        if p118.ImgGridCols then
            p117.GridCols = p118.ImgGridCols;
        end;

        if p118.ImgGridRows then
            p117.GridRows = p118.ImgGridRows;
        end;

        if p118.SheetSize ~= nil then
            p117.SheetSize = p118.SheetSize;
        end;

        if p118.ImageFlipbooks then
            p117.FlipbookDecals = gatherFlipbookDecals(p118.ImageFlipbooks);
        end;

        if p118.ImgTimescale and p117.Graphs then
            p117.Graphs.Timescale = p118.ImgTimescale;
            p117.Seeds.Timescale = Graph.GenerateSeed(p118.ImgTimescale);
        end;
    end;
end;