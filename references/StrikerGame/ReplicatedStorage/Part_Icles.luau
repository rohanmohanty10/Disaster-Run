 

 

local script_Log = require(script.Log);
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local script_Particles = require(script.Particles);
local u1 = {
    Beam = {},
    _focused = true,
    _unfocusedAt = 0
};

if RunService:IsClient() then
    u1._focusConn = UserInputService.WindowFocused:Connect(function() -- Line: 121
        -- upvalues: u1 (copy)
        u1._focused = true;
        u1._unfocusedAt = 0;
    end);
    u1._blurConn = UserInputService.WindowFocusReleased:Connect(function() -- Line: 122
        -- upvalues: u1 (copy)
        u1._focused = false;
        u1._unfocusedAt = os.clock();
    end);
end;

u1.ActiveEmits = {};
u1.ActiveLoops = {};
u1.ActiveAnimates = {};
u1.ActiveChainLoops = {};
u1._evenCycleStore = {};
u1.Connection = nil;
u1._engineGen = 0;
u1.MAX_ACTIVE_PARTICLES = 1000;
u1._capWarnLastAt = 0;
u1._lingerVisualCount = 0;
u1._preloadedAssets = setmetatable({}, {
    __mode = "k"
});
require(script.GetData)(u1);
require(script.EmitOverrides)(u1);
require(script.Transform)(u1);
require(script.Update)(u1);
require(script.UpdateAttachment)(u1);
require(script.UpdateBeam)(u1);
require(script.Timescale)(u1);
require(script.Emit)(u1);
require(script.EmitAttachment)(u1);
require(script.EmitAnimate)(u1);
require(script.EmitModel)(u1);
require(script.UpdateModel)(u1);
require(script.PointLight)(u1);
require(script.Sound)(u1);
require(script.Highlight)(u1);
require(script.Lightning)(u1);
require(script.CameraShake)(u1);
require(script.Rocks)(u1);
require(script.Rope)(u1);
require(script.Distortion)(u1);
require(script.Container)(u1);
require(script.Force)(u1);
require(script.Matte)(u1);
require(script.Reactor)(u1);
require(script.TrailEmitter)(u1);
require(script.ScreenEmit)(u1);
require(script.ImageEmit)(u1);
require(script.LinkTrack)(u1);
require(script.Orientation)(u1);
require(script.ZOffset)(u1);
require(script.Engine)(u1);
require(script.EngineReplay)(u1);
require(script.PreSimulate)(u1);
require(script.RegisterEmit)(u1);
require(script.Lifecycle)(u1);
require(script.LifecycleRelease)(u1);
require(script.EmitAt)(u1);
require(script.Absolute)(u1);

function u1._warnIfNotActivated(p2, p3) -- Line: 196
    -- upvalues: script_Log (copy)
    if p2.Connection then
        return;
    end;

    if p2._notActivatedWarned then
        return;
    end;

    p2._notActivatedWarned = true;
    script_Log.warn(string.format("[Part-Icles] :%s() called before :Activate()  -  particles will not update until the engine is activated. Call Particle:Activate() once at startup.", p3));
end;

function u1._applyEmitVisualPasses(p4, p5) -- Line: 207
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

function u1.Emit(p8, u9, p10, p11) -- Line: 228
    -- upvalues: script_Log (copy), u1 (copy)
    if not (u9 and u9.Parent) then
        return;
    end;

    p8:_warnIfNotActivated("Emit");
    local v12 = p8.MAX_ACTIVE_PARTICLES or 1000;

    if v12 <= #p8.ActiveEmits + (p8._lingerVisualCount or 0) then
        local os_clock_ret = os.clock();

        if os_clock_ret - (p8._capWarnLastAt or 0) >= 1 then
            p8._capWarnLastAt = os_clock_ret;
            script_Log.warn(("[Part-Icles] active particle cap (%d) reached  -  new emits skipped (user Module code still runs)."):format(v12));
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

        if u9:IsA("Light") then
            p8:EmitPointLight(u9, p10, p11);

            return;
        end;

        if u9:IsA("Sound") then
            p8:EmitSound(u9, p10, p11);

            return;
        end;

        if u9:IsA("Highlight") then
            p8:EmitHighlight(u9, p10, p11);

            return;
        end;

        if u1._isContainer(u9) then
            p8:EmitContainer(u9, p10, p11);

            return;
        end;

        if u1._isForce(u9) then
            p8:EmitForce(u9, p10, p11);

            return;
        end;

        if u1._isMatte(u9) then
            p8:EmitMatte(u9, p10, p11);

            return;
        end;

        if u1._isReactor(u9) then
            p8:EmitReactor(u9, p10, p11);

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

        if u1._isLightning(u9) then
            p8:EmitLightning(u9, p10, p11);

            return;
        end;

        if u1._isCameraShake(u9) then
            p8:EmitCameraShake(u9, p10, p11);

            return;
        end;

        if u1._isRocks(u9) then
            p8:EmitRocks(u9, p10, p11);

            return;
        end;

        if u1._isRope(u9) then
            p8:EmitRope(u9, p10, p11);

            return;
        end;

        if u1._isDistortion(u9) then
            p8:EmitDistortion(u9, p10, p11);

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
        task.delay(u9:GetAttribute("EmitDelay") or 0, function() -- Line: 260
            -- upvalues: u9 (copy), u13 (ref)
            if not (u9 and u9.Parent) then
                return;
            end;

            u9.Enabled = true;
            task.delay(u13, function() -- Line: 263
                -- upvalues: u9 (ref)
                if u9 and u9.Parent then
                    u9.Enabled = false;
                end;
            end);
        end);
    end;
end;

function u1.await(p19) -- Line: 321
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

local script_TexturePin = require(script.TexturePin);

local function _isPreloadable(p20) -- Line: 338
    return p20:GetAttribute("Transformed") or (p20:IsA("ParticleEmitter") or p20:IsA("Trail"));
end;

local function _walk(p21, u22, u23) -- Line: 339
    if not p21 then
        return;
    end;

    local function visit(p24) -- Line: 341
        -- upvalues: u22 (copy), u23 (copy), visit (copy)
        if (p24:GetAttribute("Transformed") or (p24:IsA("ParticleEmitter") or p24:IsA("Trail"))) and (u22 or p24:GetAttribute("PreloadTexture") == true) then
            u23(p24);
        end;

        for _, child in p24:GetChildren() do
            visit(child);
        end;
    end;

    visit(p21);
end;

function u1.Preload(p25, p26, u27) -- Line: 350
    -- upvalues: script_TexturePin (copy)
    local pinSubtree = script_TexturePin.pinSubtree;

    if not p26 then
        return;
    end;

    local function u29(p28) -- Line: 341
        -- upvalues: u27 (copy), pinSubtree (copy), u29 (copy)
        if (p28:GetAttribute("Transformed") or (p28:IsA("ParticleEmitter") or p28:IsA("Trail"))) and (u27 or p28:GetAttribute("PreloadTexture") == true) then
            pinSubtree(p28);
        end;

        for _, child in p28:GetChildren() do
            u29(child);
        end;
    end;

    u29(p26);
end;

function u1.Deload(p30, p31, u32) -- Line: 352
    -- upvalues: script_TexturePin (copy)
    local unpinSubtree = script_TexturePin.unpinSubtree;

    if not p31 then
        return;
    end;

    local function u34(p33) -- Line: 341
        -- upvalues: u32 (copy), unpinSubtree (copy), u34 (copy)
        if (p33:GetAttribute("Transformed") or (p33:IsA("ParticleEmitter") or p33:IsA("Trail"))) and (u32 or p33:GetAttribute("PreloadTexture") == true) then
            unpinSubtree(p33);
        end;

        for _, child in p33:GetChildren() do
            u34(child);
        end;
    end;

    u34(p31);
end;

u1.LinkService = require(script.LinkService);
u1.Log = script_Log;
u1.parseDuration = script_Particles.parseDuration;

function u1.SetLink(p35, u36, p37, u38) -- Line: 368
    if not (u36 and u36:GetAttribute("Transformed")) then
        return;
    end;

    if p37 == "camera" then
        pcall(function() -- Line: 371
            -- upvalues: u36 (copy)
            u36:SetAttribute("LinkSource", "Camera");
        end);
    elseif p37 == nil then
        pcall(function() -- Line: 373
            -- upvalues: u36 (copy)
            u36:SetAttribute("LinkSource", "None");
        end);
        local Link = u36:FindFirstChild("Link");

        if Link and Link:IsA("ObjectValue") then
            Link.Value = nil;
        end;
    elseif typeof(p37) == "Instance" then
        local Link = u36:FindFirstChild("Link");

        if not Link then
            Link = Instance.new("ObjectValue");
            Link.Name = "Link";
            Link.Parent = u36;
        end;

        Link.Value = p37;
        pcall(function() -- Line: 384
            -- upvalues: u36 (copy)
            u36:SetAttribute("LinkSource", "Object");
        end);
    end;

    if u38 then
        pcall(function() -- Line: 386
            -- upvalues: u36 (copy), u38 (copy)
            u36:SetAttribute("LinkMode", u38);
        end);
    end;
end;

function u1.SetEmitParent(p39, p40, p41) -- Line: 391
    if not (p40 and p40:GetAttribute("Transformed")) then
        return;
    end;

    if p41 == nil then
        local EmitParent = p40:FindFirstChild("EmitParent");

        if EmitParent then
            pcall(function() -- Line: 395
                -- upvalues: EmitParent (copy)
                EmitParent:Destroy();
            end);
        end;

        return;
    end;

    if typeof(p41) ~= "Instance" then
        return;
    end;

    local EmitParent = p40:FindFirstChild("EmitParent");

    if not EmitParent then
        EmitParent = Instance.new("ObjectValue");
        EmitParent.Name = "EmitParent";
        EmitParent.Parent = p40;
    end;

    EmitParent.Value = p41;
end;

return u1;