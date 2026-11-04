 

 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local Particles = require(script.Parent.Particles);
local Flipbook = require(script.Parent.Flipbook);
local Preload = require(script.Parent.Preload);
local GuiHost = require(script.Parent.GuiHost);
local Log = require(script.Parent.Log);
local script_Field = require(script.Field);
local script_Layer = require(script.Layer);
local script_LayerPool = require(script.LayerPool);
local script_Looks = require(script.Looks);
local script_Place = require(script.Place);
local script_Twins = require(script.Twins);
local script_View = require(script.View);
local success = pcall(function() -- Line: 84
    return game:GetService("Selection"):Get();
end);

return function(u1) -- Line: 88
    -- upvalues: script_Field (copy), script_LayerPool (copy), script_Looks (copy), script_Twins (copy), script_Place (copy), GuiHost (copy), Log (copy), success (copy), Pool (copy), PartConstants (copy), NestedEmit (copy), Range (copy), Graph (copy), script_View (copy), Flipbook (copy), Preload (copy), script_Layer (copy), Particles (copy)
    local u2 = false;
    local u3 = {};
    local u4 = setmetatable({}, {
        __mode = "k"
    });

    function u1._isMatte(p5) -- Line: 97
        local v6 = p5:IsA("BasePart") and p5:GetAttribute("IsMatte") == true;

        return v6;
    end;

    function u1.SyncMatteField(p7, p8) -- Line: 103
        -- upvalues: script_Field (ref), script_LayerPool (ref), script_Looks (ref)
        local PartIcleProperties = p8:FindFirstChild("PartIcleProperties");

        if not PartIcleProperties then
            return false;
        end;

        local v9 = PartIcleProperties:GetAttribute("Texture") or "";
        local v10, v11;

        if script_Field.inStep(p8, v9) then
            v10 = false;
            v11 = true;
        else
            v11 = script_Field.store(p8, v9);
            v10 = true;
        end;

        local v12 = script_Field.flipbookTextures(p8);

        if not script_Field.framesInStep(p8, v12) then
            v11 = script_Field.storeFrames(p8, v12) and v11;
            v10 = true;
        end;

        local v13 = PartIcleProperties:GetAttribute("MaskTexture") or "";

        if not script_Field.maskInStep(p8, v13) then
            v11 = script_Field.storeMask(p8, v13) and v11;
            v10 = true;
        end;

        local v14 = script_Field.flipbookTextures(p8, script_Field.MASK_FLIPBOOK);

        if not script_Field.maskFramesInStep(p8, v14) then
            v11 = script_Field.storeMaskFrames(p8, v14) and v11;
            v10 = true;
        end;

        if v10 then
            script_LayerPool.drop(p8);
            script_Looks.drop(p8);
        end;

        return v11;
    end;

    function u1._dropMatteLayers(p15) -- Line: 139
        -- upvalues: script_LayerPool (ref), script_Looks (ref)
        script_LayerPool.flush();
        script_Looks.flush();
    end;

    function u1._matteFor(p16, p17, p18) -- Line: 146
        if p17 then
            p17 = p17._matte;
        end;

        if not p17 or p17._released then
            return nil;
        end;

        for _, child in ipairs(p18:GetChildren()) do
            if child:IsA("Decal") or child:IsA("SurfaceAppearance") then
                child:Destroy();
            elseif child:IsA("SpecialMesh") then
                child.TextureId = "";
            end;
        end;

        if p18:IsA("MeshPart") then
            p18.TextureID = "";
        end;

        return p17;
    end;

    local function seat(p19, p20) -- Line: 165
        -- upvalues: script_LayerPool (ref), script_Twins (ref)
        p20.layer = p19._layer or (table.remove(p19._spare) or script_LayerPool.take(p19._sourceItem, p19._host, p19._folder));
        p20.sheet = p20.layer.sheet;
        script_Twins.settle(p20, p20.layer.viewport);
        table.insert(p19._shapes, p20);
    end;

    function u1._matteJoin(p21, p22, p23) -- Line: 175
        -- upvalues: script_Twins (ref), seat (copy)
        local VisualPart = p23.VisualPart;
        p23.SkipTransparency = true;
        p23.SkipColor = true;
        p23._noPool = true;
        script_Twins.hide(VisualPart);
        seat(p22, script_Twins.single(VisualPart, p22.BackFaces));
    end;

    function u1._matteCarry(p24, p25, p26, p27, p28, p29) -- Line: 190
        -- upvalues: script_Twins (ref), seat (copy)
        if p25 then
            p25 = p25._matte;
        end;

        if not p25 or p25._released then
            return false;
        end;

        local VisualPart = p26.VisualPart;
        local v30 = p27 or script_Twins.partsOf(VisualPart);
        p26._noPool = true;
        p26._matteCarried = true;

        for _, v in ipairs(v30) do
            script_Twins.hide(v);
        end;

        seat(p25, script_Twins.group(VisualPart, v30, p25.BackFaces, p28, p29));

        return true;
    end;

    function u1.UpdateMatte(p31, p32, p33, p34) -- Line: 206
        local VisualPart = p32.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p32._parentAlive and not p32._parentAlive[1] then
            return true;
        end;

        if p34 - p32.StartTime > 180 then
            return true;
        end;

        local v35 = (p32._tsOverride == nil or p34 >= (p32._tsOverrideUntil or 0)) and 1 or p32._tsOverride;
        local _effectiveElapsed = p32._effectiveElapsed;

        if not p32._timeFrozen then
            _effectiveElapsed = math.clamp(_effectiveElapsed + p33 * v35, 0, p32.LifeTime);
            p32._effectiveElapsed = _effectiveElapsed;
        end;

        local _followItem = p32._followItem;

        if _followItem and _followItem.Parent then
            VisualPart.CFrame = _followItem.CFrame;
        end;

        local v36;

        if p32.LifeTime <= _effectiveElapsed then
            v36 = #p32._shapes == 0;
        else
            v36 = false;
        end;

        return v36;
    end;

    function u1._placeMattes(p37) -- Line: 230
        -- upvalues: script_LayerPool (ref), script_Looks (ref), u3 (copy), script_Place (ref)
        script_LayerPool.sweep();
        script_Looks.sweep();

        if #u3 == 0 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera then
            return;
        end;

        script_Place.begin();

        for _, v in ipairs(u3) do
            script_Place.frame(v, workspace_CurrentCamera);
        end;

        script_Place.finish();
    end;

    function u1.EmitMatte(p38, u39, p40, p41) -- Line: 247
        -- upvalues: GuiHost (ref), u2 (ref), Log (ref), success (ref), Pool (ref), PartConstants (ref), NestedEmit (ref), Range (ref), Graph (ref), script_LayerPool (ref), script_Looks (ref), script_View (ref), script_Field (ref), Flipbook (ref), u4 (copy), Preload (ref), script_Place (ref), u3 (copy), script_Layer (ref), script_Twins (ref), u1 (copy), Particles (ref)
        if not (u39 and u39.Parent) then
            return;
        end;

        local EmitData = p38:GetEmitData(u39, p41);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v42 = GuiHost.resolveContainer();

        if not (v42 and workspace.CurrentCamera) then
            if not u2 then
                u2 = true;
                Log.warn("[Part-Icles] a Matte draws on a player\'s screen: emit it from a LocalScript. Nothing was emitted.");
            end;

            return;
        end;

        if success then
            p38:SyncMatteField(u39);
        end;

        local v43 = Pool.acquireOrCopyBare(EmitData.RenderTemplate, "Matte", false);
        v43.Archivable = false;

        for _, descendant in ipairs(v43:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local v44, v45 = PartConstants.playOrigin(u39.CFrame, p41);
        v43.CFrame = v44;
        v43.Parent = EmitData.EmitParent or (NestedEmit.resolveCloneParent(u39, p40, p41) or p38:GetFolder());
        local v46 = {
            Brightness = EmitData.Brightness,
            Transparency = EmitData.Transparency,
            Color = EmitData.Color,
            EdgeBrightness = EmitData.MaskEdgeBrightness,
            EdgeColor = EmitData.MaskEdgeColor,
            FlipbookTime = EmitData.FlipbookTime,
            MaskFlipbookTime = EmitData.MaskFlipbookTime
        };
        local u47 = {
            Type = "Matte",
            TotalKeyFrames = 1,
            CurrentStep = -1,
            PartLife = 0,
            _effectiveElapsed = 0,
            _layer = nil,
            _lead = nil,
            _picture = nil,
            _flip = nil,
            _mask = nil,
            _maskFlip = nil,
            VisualPart = v43,
            Events = EmitData.Events,
            StartTime = os.clock()
        };
        local v48 = Range.RandomValueFromRange(EmitData.Lifetime);
        u47.LifeTime = math.max(v48, 0.001);
        u47.Graphs = v46;
        local v49 = {
            Brightness = Graph.GenerateSeed(v46.Brightness),
            Transparency = Graph.GenerateSeed(v46.Transparency),
            EdgeBrightness = Graph.GenerateSeed(v46.EdgeBrightness)
        };
        local v50 = v46.FlipbookTime and Graph.GenerateSeed(v46.FlipbookTime);
        v49.FlipbookTime = v50;
        local v51 = v46.MaskFlipbookTime and Graph.GenerateSeed(v46.MaskFlipbookTime);
        v49.MaskFlipbookTime = v51;
        u47.Seeds = v49;
        u47.TextureScale = EmitData.TextureScale;
        u47.BackFaces = EmitData.BackFaces;
        u47.ViewMode = EmitData.ViewMode;
        u47._host = v42;
        u47._folder = p38:GetFolder();
        u47._sheet = {};
        u47._group = {};
        u47._shapes = {};
        u47._spare = {};
        u47._followItem = v45 and u39 and u39 or nil;
        u47._sourceItem = u39;
        local u52 = EmitData.Pool ~= false;

        if not u52 then
            script_LayerPool.drop(u39);
            script_Looks.drop(u39);
        end;

        if EmitData.ViewMode ~= script_View.MODES.Tilted then
            u47._layer = script_LayerPool.take(u39, v42, u47._folder);
            u47._sheet = u47._layer.sheet;
        end;

        local u53 = EmitData.FlipbookMode == "None" and {} or (script_Field.frames(u39) or {});

        if #u53 > 0 then
            u47._flip = Flipbook.layerState(nil, u53, EmitData.FlipbookMode, Range.RandomValueFromRange(EmitData.FlipbookFramerate), EmitData.FlipbookStartRandom, EmitData.FlipbookReverse);

            if not u4[u53[1]] then
                u4[u53[1]] = true;
                Preload.ask(u53);
            end;
        end;

        u47._picture = {
            needsLook = false,
            owner = u39,
            backing = script_Field.BACKING,

            plane = function(p54) -- Line: 353, Name: plane
                -- upvalues: script_Field (ref)
                return script_Field.bare(p54, "Field");
            end,

            look = function(p55) -- Line: 356, Name: look
                -- upvalues: u53 (copy), script_Field (ref), u39 (copy)
                return u53[p55] or script_Field.still(u39);
            end
        };
        local u56 = EmitData.MaskFlipbookMode == "None" and {} or (script_Field.maskFrames(u39) or {});
        local u57 = script_Field.maskStill(u39);

        if #u56 > 0 then
            u47._maskFlip = Flipbook.layerState(nil, u56, EmitData.MaskFlipbookMode, Range.RandomValueFromRange(EmitData.MaskFlipbookFramerate), EmitData.MaskFlipbookStartRandom, EmitData.MaskFlipbookReverse);

            if not u4[u56[1]] then
                u4[u56[1]] = true;
                Preload.ask(u56);
            end;
        end;

        if #u56 > 0 or u57 then
            u47._mask = {
                frame = 0,
                distance = script_Place.MASK_NEAREST,
                scale = EmitData.MaskScale,
                from = {
                    needsLook = true,
                    owner = u39,

                    plane = function(p58) -- Line: 380, Name: plane
                        -- upvalues: script_Field (ref)
                        return script_Field.bare(p58, "Mask");
                    end,

                    look = function(p59) -- Line: 383, Name: look
                        -- upvalues: u56 (copy), u57 (copy)
                        return u56[p59] or u57;
                    end
                }
            };
        end;

        function u47._onReclaim() -- Line: 390
            -- upvalues: u47 (copy), u3 (ref), u52 (copy), script_LayerPool (ref), u39 (copy), script_Layer (ref), script_Twins (ref), Pool (ref), script_Looks (ref)
            u47._released = true;
            local table_find_ret = table.find(u3, u47);

            if table_find_ret then
                u3[table_find_ret] = u3[#u3];
                u3[#u3] = nil;
            end;

            local function done(p60) -- Line: 400
                -- upvalues: u52 (ref), script_LayerPool (ref), u39 (ref), script_Layer (ref)
                if u52 then
                    script_LayerPool.give(u39, p60);

                    return;
                end;

                script_Layer.destroy(p60);
            end;

            for _, v in ipairs(u47._shapes) do
                script_Twins.destroy(v);

                if not u47._layer then
                    local layer = v.layer;

                    if u52 then
                        script_LayerPool.give(u39, layer);
                    else
                        script_Layer.destroy(layer);
                    end;
                end;

                Pool.dropCloneMap(v.holder or v.source);
                script_Twins.dismiss(v);
            end;

            if u47._layer then
                local _layer = u47._layer;

                if u52 then
                    script_LayerPool.give(u39, _layer);
                else
                    script_Layer.destroy(_layer);
                end;
            end;

            for _, v in ipairs(u47._spare) do
                if u52 then
                    script_LayerPool.give(u39, v);
                else
                    script_Layer.destroy(v);
                end;
            end;

            if not u52 then
                script_Looks.drop(u39);
            end;
        end;

        if p41 and (p41._parentAlive and not EmitData.EmitParent) then
            u47._parentAlive = p41._parentAlive;
        end;

        u1._seedTsOverride(u47, u39);
        u47._nestedAlive = { true };
        p38:_registerEmit(u47, p41);
        table.insert(u3, u47);
        local v61 = p38:_makeAliveCheck();

        for _, descendant in ipairs(v43:GetDescendants()) do
            Particles.EnableEmitSingle(descendant, v61);
        end;

        NestedEmit.walk(p38, EmitData.RenderTemplate, v43, u47._nestedAlive, p41, nil, function(p62, p63) -- Line: 441
            -- upvalues: u47 (copy), NestedEmit (ref), EmitData (copy)
            p63._matte = u47;
            NestedEmit.keepPlace(p62, p63, EmitData.RenderTemplate);
        end);
    end;
end;