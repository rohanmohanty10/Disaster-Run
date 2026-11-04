 
 

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local script_Particles = require(script.Particles);
local u1 = {
    Beam = {},
    _focused = true,
    _unfocusedAt = 0
};

if RunService:IsClient() then
    u1._focusConn = UserInputService.WindowFocused:Connect(function() -- Line: 105
        -- upvalues: u1 (copy)
        u1._focused = true;
        u1._unfocusedAt = 0;
    end);
    u1._blurConn = UserInputService.WindowFocusReleased:Connect(function() -- Line: 106
        -- upvalues: u1 (copy)
        u1._focused = false;
        u1._unfocusedAt = os.clock();
    end);
end;

u1.ActiveEmits = {};
u1.ActiveLoops = {};
u1.ActiveAnimates = {};
u1.ActiveChainLoops = {};
u1.Connection = nil;
u1._CachedFolder = nil;
u1._engineGen = 0;
u1.MAX_ACTIVE_PARTICLES = 1000;
u1._capWarnLastAt = 0;
u1._lingerVisualCount = 0;
require(script.GetData)(u1);
require(script.Transform)(u1);
require(script.Update)(u1);
require(script.UpdateBeam)(u1);
require(script.Timescale)(u1);
require(script.Emit)(u1);
require(script.EmitAnimate)(u1);
require(script.EmitModel)(u1);
require(script.UpdateModel)(u1);
require(script.PointLight)(u1);
require(script.Highlight)(u1);
require(script.TrailEmitter)(u1);
require(script.ScreenEmit)(u1);
require(script.ImageEmit)(u1);
require(script.LinkTrack)(u1);
require(script.Orientation)(u1);
require(script.ZOffset)(u1);
require(script.Engine)(u1);
require(script.Lifecycle)(u1);

function u1._warnIfNotActivated(p2, p3) -- Line: 153
    if p2.Connection then
        return;
    end;

    if p2._notActivatedWarned then
        return;
    end;

    p2._notActivatedWarned = true;
    warn(string.format("[Part-Icles] :%s() called before :Activate()  -  particles will not update until the engine is activated. Call Particle:Activate() once at startup.", p3));
end;

function u1._applyEmitVisualPasses(p4, p5) -- Line: 164
    local Type = p5.Type;

    if Type ~= "Part" and (Type ~= "Model" and Type ~= "Attachment") then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    local v6 = p5.Orientation and p5.Orientation ~= "None";
    local v7 = p5.ZOffset and p5.ZOffset ~= 0;

    if v6 or v7 then
        p5._postUpdateCF = Type == "Model" and p5.VisualPart:GetPivot() or p5.VisualPart.CFrame;
    end;

    if v6 then
        p4:ApplyOrientation(p5, 0.016666666666666666, workspace_CurrentCamera);
    end;

    if v7 then
        p4:ApplyZOffset(p5, workspace_CurrentCamera);
    end;
end;

function u1.Emit(p8, u9, p10, p11) -- Line: 185
    if not (u9 and u9.Parent) then
        return;
    end;

    p8:_warnIfNotActivated("Emit");
    local v12 = p8.MAX_ACTIVE_PARTICLES or 1000;

    if v12 <= #p8.ActiveEmits + (p8._lingerVisualCount or 0) then
        local os_clock_ret = os.clock();

        if os_clock_ret - (p8._capWarnLastAt or 0) >= 1 then
            p8._capWarnLastAt = os_clock_ret;
            warn(("[Part-Icles] active particle cap (%d) reached  -  new emits skipped (user Module code still runs)."):format(v12));
        end;

        return;
    end;

    if u9:IsA("Beam") and u9:FindFirstChild("PartIcleProperties") then
        p8:EmitBeam(u9, p10, p11);

        return;
    end;

    if not (u9:IsA("Beam") or u9:IsA("Trail") and not u9:FindFirstChild("PartIcleProperties")) then
        if u9:IsA("Trail") then
            p8:EmitTrail(u9, p10, p11);

            return;
        end;

        if u9:IsA("PointLight") then
            p8:EmitPointLight(u9, p10, p11);

            return;
        end;

        if u9:IsA("Highlight") then
            p8:EmitHighlight(u9, p10, p11);

            return;
        end;

        if u9:IsA("Attachment") then
            p8:EmitAttachment(u9, p10, p11);

            return;
        end;

        if u9:IsA("Model") then
            p8:EmitModel(u9, p10, p11);

            return;
        end;

        if u9:IsA("BlurEffect") then
            p8:EmitBlur(u9, p10, p11);

            return;
        end;

        if u9:IsA("BloomEffect") then
            p8:EmitBloom(u9, p10, p11);

            return;
        end;

        if u9:IsA("ColorCorrectionEffect") then
            p8:EmitColorCorrection(u9, p10, p11);

            return;
        end;

        if u9:IsA("Atmosphere") then
            p8:EmitAtmosphere(u9, p10, p11);

            return;
        end;

        if u9:IsA("ImageLabel") then
            p8:EmitImageLabel(u9, p10, p11);

            return;
        end;

        if u9:IsA("BasePart") then
            p8:EmitPart(u9, p10, p11);
        end;

        return;
    end;

    local Attribute = u9:GetAttribute("EmitDuration");
    local u13 = 0;

    if typeof(Attribute) == "number" then
        u13 = Attribute;
    elseif Attribute ~= nil then
        local v14, v15 = tostring(Attribute):match("([%-%.%d]+)%s*,%s*([%-%.%d]+)");
        local v16;

        if v14 and v15 then
            local v17 = tonumber(v14) or 0;
            local v18 = tonumber(v15) or 0;
            u13 = math.max(v17, v18);

            if not u13 then
                v16 = tostring(Attribute);
                u13 = tonumber(v16) or 0;
            end;
        else
            v16 = tostring(Attribute);
            u13 = tonumber(v16) or 0;
        end;
    end;

    if u13 > 0 then
        task.delay(u9:GetAttribute("EmitDelay") or 0, function() -- Line: 217
            -- upvalues: u9 (copy), u13 (ref)
            if not (u9 and u9.Parent) then
                return;
            end;

            u9.Enabled = true;
            task.delay(u13, function() -- Line: 220
                -- upvalues: u9 (ref)
                if u9 and u9.Parent then
                    u9.Enabled = false;
                end;
            end);
        end);
    end;
end;

local script_Duration = require(script.Duration);

function u1.await(p19) -- Line: 262
    if p19 == nil then
        return;
    end;

    if type(p19) ~= "number" then
        return;
    end;

    if p19 <= 0 then
        return;
    end;

    task.wait(p19);
end;

function u1._absoluteEmitFire(p20, u21, p22, p23) -- Line: 272
    -- upvalues: script_Particles (copy)
    if u21:GetAttribute("Transformed") then
        p20:EnableEmit(u21, nil, p23);

        return;
    end;

    local u24 = p20:_makeAliveCheck();

    if not u21:IsA("ParticleEmitter") then
        if u21:IsA("Trail") then
            if p22 then
                return;
            end;

            script_Particles.EnableEmitSingle(u21, u24);

            return;
        end;

        if u21:IsA("Beam") then
            if p22 then
                return;
            end;

            local u25 = tonumber(u21:GetAttribute("EmitDuration")) or 0;
            local v26 = tonumber(u21:GetAttribute("EmitDelay")) or 0;

            if u25 > 0 then
                local u27 = script_Particles.ReadNativeGen(u21);

                local function doEmit() -- Line: 323
                    -- upvalues: u24 (copy), script_Particles (ref), u21 (copy), u27 (copy), u25 (copy)
                    if not (u24() and script_Particles.IsNativeGenCurrent(u21, u27)) then
                        return;
                    end;

                    script_Particles.SetEnabledForDuration(u21, u25);
                end;

                if v26 > 0 then
                    task.delay(v26, doEmit);

                    return;
                end;

                if u24() then
                    if not script_Particles.IsNativeGenCurrent(u21, u27) then
                        return;
                    end;

                    script_Particles.SetEnabledForDuration(u21, u25);
                end;
            end;

            return;
        end;

        local v28;

        if u21:IsA("BasePart") or u21:IsA("Attachment") then
            v28 = not p22;
        else
            v28 = u21:IsA("Model") and not p22;
        end;

        if v28 then
            script_Particles.EnableEmit(u21, u24);
        end;

        local v29 = v28 or p22;

        for _, child in u21:GetChildren() do
            if not (u21:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p20:_absoluteEmitFire(child, v29, p23);
            end;
        end;

        return;
    end;

    if p22 then
        return;
    end;

    local u30 = tonumber(u21:GetAttribute("EmitCount")) or 1;
    local v31 = tonumber(u21:GetAttribute("EmitDelay")) or 0;
    local u32 = tonumber(u21:GetAttribute("EmitDuration")) or 0;

    if u30 <= 0 and u32 <= 0 then
        return;
    end;

    local u33 = script_Particles.ReadNativeGen(u21);

    local function v34() -- Line: 295
        -- upvalues: u24 (copy), script_Particles (ref), u21 (copy), u33 (copy), u30 (copy), u32 (copy)
        if not (u24() and script_Particles.IsNativeGenCurrent(u21, u33)) then
            return;
        end;

        if u30 > 0 then
            u21:Emit(u30);
        end;

        if u32 > 0 then
            script_Particles.SetEnabledForDuration(u21, u32);
        end;
    end;

    if v31 > 0 then
        task.delay(v31, v34);

        return;
    end;

    v34();
end;

function u1.AbsoluteEmit(p35, p36, p37, p38) -- Line: 362
    -- upvalues: script_Duration (copy)
    p35:_warnIfNotActivated("AbsoluteEmit");

    if not p36 then
        return 0;
    end;

    p35:_absoluteEmitFire(p36, p37, p38);

    return script_Duration.computeMaxDuration(p36, 0);
end;

function u1.AbsoluteEmitAt(u39, u40, u41, p42) -- Line: 400
    -- upvalues: script_Duration (copy), script_Particles (copy)
    u39:_warnIfNotActivated("AbsoluteEmitAt");

    if not (u40 and u41) then
        return 0;
    end;

    local u43 = p42 or {};
    local v44 = script_Duration.computeMaxDuration(u40, 0);

    if u40:GetAttribute("Transformed") then
        local v45 = u43.Link ~= nil;
        local v46 = {
            ChainCtx = u43.ChainCtx,
            EventOriginCF = u41,
            EventOriginResolver = u43.OriginResolver,
            UseFullOrigin = u43.UseFullOrigin ~= false
        };
        local v47;

        if u43.IgnoreLink == true then
            v47 = not v45;
        else
            v47 = false;
        end;

        v46.IgnoreLink = v47;
        v46.Link = u43.Link;
        v46.LinkMode = u43.LinkMode;
        v46.EmitParent = u43.EmitParent;
        u39:EnableEmit(u40, u43.Link, v46);

        return v44;
    end;

    if not (u40:IsA("BasePart") or (u40:IsA("Model") or u40:IsA("Attachment"))) then
        return 0;
    end;

    local v48 = nil;
    local u49;

    if u40:IsA("Model") then
        local v50;
        v50, u49 = pcall(u40.GetPivot, u40);

        if not v50 then
            u49 = v48;
        end;
    elseif u40:IsA("BasePart") then
        u49 = u40.CFrame;
    elseif u40:IsA("Attachment") then
        u49 = u40.WorldCFrame;
    else
        u49 = v48;
    end;

    local function readWorldCF(p51) -- Line: 436
        if p51:IsA("Model") then
            local success, result = pcall(p51.GetPivot, p51);

            return success and result and result or nil;
        end;

        if p51:IsA("Attachment") then
            return p51.WorldCFrame;
        end;

        if p51:IsA("BasePart") then
            return p51.CFrame;
        end;

        return nil;
    end;

    local function originFor(p52) -- Line: 443
        -- upvalues: u49 (ref), u41 (copy), readWorldCF (copy)
        if not u49 then
            return u41;
        end;

        local v53 = readWorldCF(p52);

        if v53 then
            return u41 * u49:ToObjectSpace(v53);
        end;

        return u41;
    end;

    local function ctxFor(p54) -- Line: 450
        -- upvalues: u43 (ref), u49 (ref), u41 (copy), readWorldCF (copy)
        local v55 = {
            ChainCtx = u43.ChainCtx
        };
        local v56;

        if u49 then
            local v57 = readWorldCF(p54);

            if v57 then
                v56 = u41 * u49:ToObjectSpace(v57);
            else
                v56 = u41;
            end;
        else
            v56 = u41;
        end;

        v55.EventOriginCF = v56;
        v55.EventOriginResolver = u43.OriginResolver;
        v55.UseFullOrigin = u43.UseFullOrigin ~= false;
        v55.IgnoreLink = u43.IgnoreLink == true;

        return v55;
    end;

    local function walkTransformed(p58) -- Line: 463
        -- upvalues: u39 (copy), u43 (ref), u49 (ref), u41 (copy), readWorldCF (copy), walkTransformed (copy)
        if not p58:GetAttribute("Transformed") then
            for _, child in p58:GetChildren() do
                walkTransformed(child);
            end;

            return;
        end;

        local v59 = {
            ChainCtx = u43.ChainCtx
        };
        local v60;

        if u49 then
            local v61 = readWorldCF(p58);

            if v61 then
                v60 = u41 * u49:ToObjectSpace(v61);
            else
                v60 = u41;
            end;
        else
            v60 = u41;
        end;

        v59.EventOriginCF = v60;
        v59.EventOriginResolver = u43.OriginResolver;
        v59.UseFullOrigin = u43.UseFullOrigin ~= false;
        v59.IgnoreLink = u43.IgnoreLink == true;
        u39:EnableEmit(p58, nil, v59);
    end;

    walkTransformed(u40);

    if u43.SkipClone then
        script_Particles.EnableEmit(u40, u39:_makeAliveCheck());

        return v44;
    end;

    local function _underTransformedAncestor(p62) -- Line: 486
        -- upvalues: u40 (copy)
        local Parent = p62.Parent;

        while Parent and Parent ~= u40 do
            if Parent:GetAttribute("Transformed") then
                return true;
            end;

            Parent = Parent.Parent;
        end;

        return false;
    end;

    local v63 = false;

    for _, descendant in ipairs(u40:GetDescendants()) do
        if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam"))) and not (descendant:GetAttribute("Transformed") or _underTransformedAncestor(descendant)) then
            v63 = true;
            break;
        end;
    end;

    if not v63 then
        return v44;
    end;

    local success, result = pcall(u40.Clone, u40);

    if not (success and result) then
        return v44;
    end;

    pcall(function() -- Line: 506
        -- upvalues: result (copy)
        result.Archivable = false;
    end);

    for _, descendant in ipairs(result:GetDescendants()) do
        if descendant:GetAttribute("Transformed") then
            pcall(function() -- Line: 512
                -- upvalues: descendant (copy)
                descendant:Destroy();
            end);
        end;
    end;

    if result:IsA("BasePart") then
        pcall(function() -- Line: 516
            -- upvalues: result (copy)
            result.Anchored = true;
        end);
    end;

    for _, descendant in ipairs(result:GetDescendants()) do
        if descendant:IsA("BasePart") then
            pcall(function() -- Line: 518
                -- upvalues: descendant (copy)
                descendant.Anchored = true;
            end);
        end;
    end;

    if u43.UseFullOrigin == false and u49 then
        u41 = CFrame.new(u41.Position) * u49.Rotation;
    end;

    if result:IsA("Model") then
        pcall(function() -- Line: 528
            -- upvalues: result (copy), u41 (ref)
            result:PivotTo(u41);
        end);
    elseif result:IsA("BasePart") then
        pcall(function() -- Line: 530
            -- upvalues: result (copy), u41 (ref)
            result.CFrame = u41;
        end);
    elseif result:IsA("Attachment") then
        pcall(function() -- Line: 532
            -- upvalues: result (copy)
            result:Destroy();
        end);

        return v44;
    end;

    result.Parent = u39:GetFolder();
    u39:_absoluteEmitFire(result, nil, nil);
    task.delay(v44 or 60, function() -- Line: 544
        -- upvalues: result (copy)
        if result and result.Parent then
            pcall(function() -- Line: 545
                -- upvalues: result (ref)
                result:Destroy();
            end);
        end;
    end);

    return v44;
end;

local script_TexturePin = require(script.TexturePin);

local function _isPreloadable(p64) -- Line: 565
    return p64:GetAttribute("Transformed") or (p64:IsA("ParticleEmitter") or p64:IsA("Trail"));
end;

local function _walk(p65, u66, u67) -- Line: 566
    if not p65 then
        return;
    end;

    local function visit(p68) -- Line: 568
        -- upvalues: u66 (copy), u67 (copy), visit (copy)
        if (p68:GetAttribute("Transformed") or (p68:IsA("ParticleEmitter") or p68:IsA("Trail"))) and (u66 or p68:GetAttribute("PreloadTexture") == true) then
            u67(p68);
        end;

        for _, child in p68:GetChildren() do
            visit(child);
        end;
    end;

    visit(p65);
end;

function u1.Preload(p69, p70, u71) -- Line: 577
    -- upvalues: script_TexturePin (copy)
    local pinSubtree = script_TexturePin.pinSubtree;

    if not p70 then
        return;
    end;

    local function u73(p72) -- Line: 568
        -- upvalues: u71 (copy), pinSubtree (copy), u73 (copy)
        if (p72:GetAttribute("Transformed") or (p72:IsA("ParticleEmitter") or p72:IsA("Trail"))) and (u71 or p72:GetAttribute("PreloadTexture") == true) then
            pinSubtree(p72);
        end;

        for _, child in p72:GetChildren() do
            u73(child);
        end;
    end;

    u73(p70);
end;

function u1.Deload(p74, p75, u76) -- Line: 579
    -- upvalues: script_TexturePin (copy)
    local unpinSubtree = script_TexturePin.unpinSubtree;

    if not p75 then
        return;
    end;

    local function u78(p77) -- Line: 568
        -- upvalues: u76 (copy), unpinSubtree (copy), u78 (copy)
        if (p77:GetAttribute("Transformed") or (p77:IsA("ParticleEmitter") or p77:IsA("Trail"))) and (u76 or p77:GetAttribute("PreloadTexture") == true) then
            unpinSubtree(p77);
        end;

        for _, child in p77:GetChildren() do
            u78(child);
        end;
    end;

    u78(p75);
end;

u1.LinkService = require(script.LinkService);

function u1.SetLink(p79, u80, p81, u82) -- Line: 592
    if not (u80 and u80:GetAttribute("Transformed")) then
        return;
    end;

    if p81 == "camera" then
        pcall(function() -- Line: 595
            -- upvalues: u80 (copy)
            u80:SetAttribute("LinkSource", "Camera");
        end);
    elseif p81 == nil then
        pcall(function() -- Line: 597
            -- upvalues: u80 (copy)
            u80:SetAttribute("LinkSource", "None");
        end);
        local Link = u80:FindFirstChild("Link");

        if Link and Link:IsA("ObjectValue") then
            Link.Value = nil;
        end;
    elseif typeof(p81) == "Instance" then
        local Link = u80:FindFirstChild("Link");

        if not Link then
            Link = Instance.new("ObjectValue");
            Link.Name = "Link";
            Link.Parent = u80;
        end;

        Link.Value = p81;
        pcall(function() -- Line: 608
            -- upvalues: u80 (copy)
            u80:SetAttribute("LinkSource", "Object");
        end);
    end;

    if u82 then
        pcall(function() -- Line: 610
            -- upvalues: u80 (copy), u82 (copy)
            u80:SetAttribute("LinkMode", u82);
        end);
    end;
end;

function u1.SetEmitParent(p83, p84, p85) -- Line: 615
    if not (p84 and p84:GetAttribute("Transformed")) then
        return;
    end;

    if p85 == nil then
        local EmitParent = p84:FindFirstChild("EmitParent");

        if EmitParent then
            pcall(function() -- Line: 619
                -- upvalues: EmitParent (copy)
                EmitParent:Destroy();
            end);
        end;

        return;
    end;

    if typeof(p85) ~= "Instance" then
        return;
    end;

    local EmitParent = p84:FindFirstChild("EmitParent");

    if not EmitParent then
        EmitParent = Instance.new("ObjectValue");
        EmitParent.Name = "EmitParent";
        EmitParent.Parent = p84;
    end;

    EmitParent.Value = p85;
end;

return u1;