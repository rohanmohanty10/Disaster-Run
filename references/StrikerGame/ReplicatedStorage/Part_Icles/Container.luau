 

 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local Particles = require(script.Parent.Particles);
local VisualHost = require(script.Parent.VisualHost);
local TypeRegistry = require(script.Parent.TypeRegistry);
local script_Clock = require(script.Clock);
local script_Colors = require(script.Colors);
local script_Drive = require(script.Drive);

return function(u1) -- Line: 49
    -- upvalues: PartConstants (copy), NestedEmit (copy), VisualHost (copy), Pool (copy), script_Drive (copy), script_Colors (copy), Graph (copy), Range (copy), TypeRegistry (copy), script_Clock (copy), Particles (copy)
    function u1._isContainer(p2) -- Line: 52
        local v3 = (p2:IsA("BasePart") or p2:IsA("Attachment")) and p2:GetAttribute("IsContainer") == true;

        return v3;
    end;

    local function basePartAncestor(p4) -- Line: 56
        local Parent = p4.Parent;

        while Parent do
            if Parent:IsA("BasePart") then
                return Parent;
            end;

            Parent = Parent.Parent;
        end;

        return nil;
    end;

    local function hostAttachment(p5, p6, p7, p8, p9, p10) -- Line: 70
        -- upvalues: PartConstants (ref), NestedEmit (ref), VisualHost (ref)
        local v11 = PartConstants.playOrigin(p6.WorldCFrame, p10);
        local v12 = p8.EmitParent or NestedEmit.resolveCloneParent(p6, p9, p10);
        local v13 = nil;

        if not v12 then
            local Parent = p6.Parent;

            while true do
                if not Parent then
                    Parent = nil;
                    break;
                end;

                if Parent:IsA("BasePart") then
                    break;
                end;

                Parent = Parent.Parent;
            end;

            if Parent then
                v12 = VisualHost.acquireCarrier(Parent);
                v13 = v12;
            else
                v12 = VisualHost.worldCarrier();
            end;
        end;

        local CFrame_new_ret = CFrame.new();

        if v12:IsA("BasePart") then
            CFrame_new_ret = v12.CFrame;
        end;

        p7.CFrame = CFrame_new_ret:ToObjectSpace(v11);
        p7.Parent = v12;

        return v13;
    end;

    local function hostPart(p14, p15, p16, p17, p18, p19) -- Line: 93
        -- upvalues: PartConstants (ref), NestedEmit (ref)
        local v20, v21 = PartConstants.playOrigin(p15.CFrame, p19);
        p16.CFrame = v20;
        p16.Parent = p17.EmitParent or (NestedEmit.resolveCloneParent(p15, p18, p19) or p14:GetFolder());

        return v21;
    end;

    local function layoutOf(p22, p23) -- Line: 102
        -- upvalues: Pool (ref), PartConstants (ref)
        local v24 = Pool._cloneMaps[p22];

        if not v24 then
            return nil;
        end;

        local v25 = PartConstants.resolveLinkCFrame(p23);
        local v26 = nil;

        for i, v in pairs(v24) do
            if v ~= p22 and v:IsA("BasePart") then
                v26 = v26 or {};
                local v27 = {
                    part = v,
                    offset = v25:ToObjectSpace(i.CFrame)
                };
                table.insert(v26, v27);
            end;
        end;

        return v26;
    end;

    local function placeLayout(p28) -- Line: 119
        -- upvalues: PartConstants (ref)
        local _layout = p28._layout;

        if not _layout then
            return;
        end;

        local v29 = PartConstants.resolveLinkCFrame(p28.VisualPart);

        if v29 == p28._layoutFrame then
            return;
        end;

        p28._layoutFrame = v29;

        for _, v in ipairs(_layout) do
            v.part.CFrame = v29 * v.offset;
        end;
    end;

    function u1.UpdateContainer(p30, p31, p32, p33) -- Line: 134
        -- upvalues: placeLayout (copy), script_Drive (ref)
        local VisualPart = p31.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p31._parentAlive and not p31._parentAlive[1] then
            return true;
        end;

        if p33 - p31.StartTime > 180 then
            return true;
        end;

        local v34 = (p31._tsOverride == nil or p33 >= (p31._tsOverrideUntil or 0)) and 1 or p31._tsOverride;
        local _effectiveElapsed = p31._effectiveElapsed;

        if not p31._timeFrozen then
            _effectiveElapsed = math.clamp(_effectiveElapsed + p32 * v34, 0, p31.LifeTime);
            p31._effectiveElapsed = _effectiveElapsed;
        end;

        local _followItem = p31._followItem;

        if _followItem and _followItem.Parent then
            VisualPart.CFrame = _followItem.CFrame;
        end;

        placeLayout(p31);

        if p31._drives then
            script_Drive.step(p31, _effectiveElapsed);
        end;

        return p31.LifeTime <= _effectiveElapsed;
    end;

    function u1._adoptIntoContainer(p35, p36, p37) -- Line: 165
        -- upvalues: script_Drive (ref)
        if p37 then
            p37 = p37._containerDrive;
        end;

        if p37 then
            script_Drive.adopt(p37, p36);
        end;
    end;

    function u1.EmitContainer(p38, p39, p40, p41) -- Line: 172
        -- upvalues: Pool (ref), script_Drive (ref), script_Colors (ref), Graph (ref), Range (ref), TypeRegistry (ref), script_Clock (ref), hostAttachment (copy), PartConstants (ref), NestedEmit (ref), layoutOf (copy), placeLayout (copy), u1 (copy), Particles (ref)
        if not (p39 and p39.Parent) then
            return;
        end;

        local EmitData = p38:GetEmitData(p39, p41);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v42 = Pool.acquireOrCopyBare(EmitData.RenderTemplate, "Container", false);
        v42.Archivable = false;

        for _, descendant in ipairs(v42:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local v43 = script_Drive.collect(v42);
        local v44 = script_Drive.collectLines(v42);
        local v45 = script_Drive.activeGraphs(EmitData.DriveGraphs);
        local v46 = script_Drive.colorGraph(EmitData.DriveColor, EmitData.ColorMode);
        local v47;

        if v46 then
            v47 = script_Colors.referenceHue(v46);
        else
            v47 = nil;
        end;

        local v48 = {};

        for i, v in pairs(v45) do
            v48[i] = Graph.GenerateSeed(v);
        end;

        local v49 = {};

        for i, v in ipairs(v43) do
            v49[i] = v.timing;
        end;

        local v50 = Range.RandomValueFromRange(EmitData.Lifetime);
        local math_max_ret = math.max(v50, 0.001);
        local v52, u53 = script_Drive.collectCarried(EmitData.RenderTemplate, function(p51) -- Line: 204
            -- upvalues: TypeRegistry (ref)
            return TypeRegistry.read(p51, "Lifetime");
        end);
        local v54 = {};

        for i, v in ipairs(v52) do
            v54[i] = v.timing;
        end;

        local v55 = {};

        for i, v in ipairs(v44) do
            v55[i] = v.timing;
        end;

        local v56 = script_Clock.playLength(math_max_ret, v49, script_Drive.slowestTimescale(v43, v45));
        local v57 = script_Clock.playLength(math_max_ret, v55, script_Drive.lowestTimescale(v45));
        local math_max_ret2 = math.max(v56, v57, script_Clock.playLength(math_max_ret, v54, 1));
        local v58 = nil;
        local v59 = nil;

        if v42:IsA("Attachment") then
            v58 = hostAttachment(p38, p39, v42, EmitData, p40, p41);
        else
            local v60, v61 = PartConstants.playOrigin(p39.CFrame, p41);
            v42.CFrame = v60;
            v42.Parent = EmitData.EmitParent or (NestedEmit.resolveCloneParent(p39, p40, p41) or p38:GetFolder());

            if v61 then
                v59 = p39;
            end;
        end;

        local u62 = {
            Type = "Container",
            TotalKeyFrames = 1,
            CurrentStep = -1,
            PartLife = 0,
            _effectiveElapsed = 0,
            _color = nil,
            _sampledPosition = nil,
            _layoutFrame = nil,
            VisualPart = v42,
            _carrier = v58,
            Events = EmitData.Events,
            StartTime = os.clock(),
            LifeTime = math_max_ret2,
            Graphs = {},
            Seeds = v48,
            Mode = EmitData.Mode,
            ContainerLife = math_max_ret,
            Driven = v43,
            Lines = v44,
            Carried = v52,
            ActiveGraphs = v45,
            ColorGraph = v46,
            ColorMode = EmitData.ColorMode,
            ColorReference = v47,
            Skips = EmitData.DriveSkips
        };
        local v63;

        if next(v45) == nil and v46 == nil then
            v63 = false;
        else
            v63 = (#v43 > 0 or #v44 > 0) and true or #v52 > 0;
        end;

        u62._drives = v63;
        u62._values = {};
        u62._followItem = v59;
        u62._layout = layoutOf(v42, EmitData.RenderTemplate);
        u62._sourceItem = p39;
        placeLayout(u62);

        for _, v in ipairs(v52) do
            v.play = u62;
        end;

        function u62._onReclaim() -- Line: 272
            -- upvalues: u62 (copy)
            u62._released = true;
        end;

        if p41 and (p41._parentAlive and not EmitData.EmitParent) then
            u62._parentAlive = p41._parentAlive;
        end;

        u1._seedTsOverride(u62, p39);

        if u62._drives then
            script_Drive.step(u62, 0);
        end;

        u62._nestedAlive = { true };
        p38:_registerEmit(u62, p41);
        local v64 = p38:_makeAliveCheck();

        for _, descendant in ipairs(v42:GetDescendants()) do
            Particles.EnableEmitSingle(descendant, v64);
        end;

        NestedEmit.walk(p38, EmitData.RenderTemplate, v42, u62._nestedAlive, p41, nil, function(p65, p66) -- Line: 299
            -- upvalues: u53 (copy), NestedEmit (ref), EmitData (copy)
            p66._containerDrive = u53[p65];
            NestedEmit.keepPlace(p65, p66, EmitData.RenderTemplate);
        end);
    end;
end;