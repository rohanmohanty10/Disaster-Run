 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local raycast = require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local script_CameraShaker = require(script.CameraShaker);
local spring = require(ReplicatedStorage.forum.spring);
local Util = require(ReplicatedStorage.util.Util);
local MoonCFrameTimeline = require(ReplicatedStorage.util.MoonCFrameTimeline);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local trove = require(ReplicatedStorage.forum.trove);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local Ray = require(ReplicatedStorage.util.Ray);
local u1 = spring.new(Vector3.new(0, 0, 0), 0.075);
local u2 = nil;
local u3 = Ray.new({
    FilterType = Enum.RaycastFilterType.Exclude,
    Ignore = { workspace.characters, workspace.gks, workspace.CF }
});
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = nil;

local function getFlowCrowdSource(p8) -- Line: 50
    -- upvalues: ReplicatedStorage (copy)
    if typeof(p8) ~= "string" or p8 == "" then
        return;
    end;

    local Resources = ReplicatedStorage:FindFirstChild("Resources");

    if not Resources then
        return;
    end;

    for i in string.gmatch(p8, "[^/]+") do
        Resources = Resources:FindFirstChild(i);

        if not Resources then
            return;
        end;
    end;

    if Resources:IsA("Sound") then
        return Resources;
    end;
end;

local function replaceFlowCrowdChildren(p9, p10) -- Line: 66
    if not p10 then
        return;
    end;

    for _, child in p9:GetChildren() do
        child:Destroy();
    end;

    for _, child in p10:GetChildren() do
        child:Clone().Parent = p9;
    end;
end;

local function getRadialProgress(p11) -- Line: 77
    -- upvalues: PlayerGui (copy)
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");

    if not Hotbar then
        return;
    end;

    local v12 = Hotbar.Backpack.Hotbar:FindFirstChild(p11);

    if v12 then
        return v12.Base.Progress;
    end;
end;

local function setRadialProgress(p13, p14, p15) -- Line: 85
    local math_clamp_ret = math.clamp(p14 * 360, 0, 360);

    if not p13:FindFirstChild("Frame1") then
        return;
    end;

    local ImageLabel = p13.Frame1.ImageLabel;
    local ImageLabel2 = p13.Frame2.ImageLabel;
    local ColorSequence_new_ret = ColorSequence.new({
        ColorSequenceKeypoint.new(0, p15),
        ColorSequenceKeypoint.new(0.5, p15),
        ColorSequenceKeypoint.new(0.501, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    });
    local NumberSequence_new_ret = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.501, 0.25),
        NumberSequenceKeypoint.new(1, 0.25)
    });
    ImageLabel.UIGradient.Rotation = math.clamp(math_clamp_ret, 180, 360) or 180 - math.clamp(math_clamp_ret, 0, 180);
    ImageLabel2.UIGradient.Rotation = math.clamp(math_clamp_ret, 0, 180) or 180 - math.clamp(math_clamp_ret, 180, 360);
    ImageLabel.UIGradient.Color = ColorSequence_new_ret;
    ImageLabel2.UIGradient.Color = ColorSequence_new_ret;
    ImageLabel.UIGradient.Transparency = NumberSequence_new_ret;
    ImageLabel2.UIGradient.Transparency = NumberSequence_new_ret;
end;

function u4.flowCrowd(p16: userdata, p17: string?, p18: string?, p19: boolean) -- Line: 113
    -- upvalues: SoundService (copy), u6 (copy), u7 (ref), replaceFlowCrowdChildren (copy), getFlowCrowdSource (copy)
    local v20 = SoundService:FindFirstChild("football-crowd-3-69245");

    if not (v20 and v20:IsA("Sound")) then
        return;
    end;

    if p19 and (typeof(p17) == "string" and p17 ~= "") then
        if not next(u6) then
            u7 = {
                sound_id = v20.SoundId,
                time_position = v20.TimePosition,
                playing = v20.IsPlaying,
                children = {}
            };

            for _, child in v20:GetChildren() do
                table.insert(u7.children, child:Clone());
            end;
        end;

        u6[p16] = {
            sound_id = p17,
            source_path = p18,
            order = os.clock()
        };
    else
        u6[p16] = nil;
    end;

    local v21 = nil;

    for _, v in u6 do
        if not v21 or v.order > v21.order then
            v21 = v;
        end;
    end;

    if v21 then
        replaceFlowCrowdChildren(v20, getFlowCrowdSource(v21.source_path));

        if v20.SoundId == v21.sound_id then
            if not v20.IsPlaying then
                v20:Play();
            end;

            return;
        end;

        v20:Stop();
        v20.SoundId = v21.sound_id;
        v20.TimePosition = 0;
        v20:Play();

        return;
    end;

    if not u7 then
        return;
    end;

    v20:Stop();

    for _, child in v20:GetChildren() do
        child:Destroy();
    end;

    for _, v in u7.children do
        v.Parent = v20;
    end;

    v20.SoundId = u7.sound_id;
    v20.TimePosition = u7.time_position;

    if u7.playing then
        v20:Play();
    end;

    u7 = nil;
end;

function u4.radial_progress_text(p22, p23, p24) -- Line: 175
    -- upvalues: PlayerGui (copy)
    print(p22, p23, p24);
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");
    local v25;

    if Hotbar then
        local v26 = Hotbar.Backpack.Hotbar:FindFirstChild(p22);

        if v26 then
            v25 = v26.Base.Progress;
        else
            v25 = nil;
        end;
    else
        v25 = nil;
    end;

    v25.Number.Text = p23 or v25.Number.Text;

    if p24 and v25 then
        v25.Frame1.Visible = false;
        v25.Frame2.Visible = false;

        if p23 == nil then
            v25.Visible = false;

            return;
        end;

        v25.Visible = true;
    end;
end;

function u4.radial_progress(p27, p28, p29, p30) -- Line: 190
    -- upvalues: PlayerGui (copy), u5 (copy), setRadialProgress (copy)
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");
    local v31;

    if Hotbar then
        local v32 = Hotbar.Backpack.Hotbar:FindFirstChild(p27);

        if v32 then
            v31 = v32.Base.Progress;
        else
            v31 = nil;
        end;
    else
        v31 = nil;
    end;

    if not v31 then
        return;
    end;

    local v33 = p29 or Color3.new(1, 1, 1);
    local v34 = p30 == nil and true or p30 == true;
    v31.Visible = v34;
    v31.Frame1.Visible = false;
    v31.Frame2.Visible = false;

    if not v34 then
        return;
    end;

    if p30 == nil and u5[p27] then
        u5[p27]:Disconnect();
        u5[p27] = nil;
    end;

    setRadialProgress(v31, p28, v33);
end;

function u4.radial_progress_tween(u35, u36, u37, u38, p39, p40) -- Line: 208
    -- upvalues: PlayerGui (copy), u5 (copy), RunService (copy), setRadialProgress (copy)
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");
    local u41;

    if Hotbar then
        local v42 = Hotbar.Backpack.Hotbar:FindFirstChild(u35);

        if v42 then
            u41 = v42.Base.Progress;
        else
            u41 = nil;
        end;
    else
        u41 = nil;
    end;

    if not u41 then
        return;
    end;

    if u5[u35] then
        u5[u35]:Disconnect();
        u5[u35] = nil;
    end;

    local u43 = p39 or Color3.new(1, 1, 1);
    u41.Visible = p40 == nil and true or p40 == true;
    u41.Frame1.Visible = false;
    u41.Frame2.Visible = false;
    local u44 = tick();
    local u45 = nil;
    u45 = RunService.RenderStepped:Connect(function() -- Line: 224
        -- upvalues: u44 (copy), u38 (copy), u36 (copy), u37 (copy), setRadialProgress (ref), u41 (copy), u43 (copy), u45 (ref), u5 (ref), u35 (copy)
        local v46 = (tick() - u44) / u38;
        local math_clamp_ret = math.clamp(v46, 0, 1);
        pcall(setRadialProgress, u41, u36 + (u37 - u36) * math_clamp_ret, u43);

        if math_clamp_ret >= 1 then
            u45:Disconnect();
            u5[u35] = nil;
        end;
    end);
    u5[u35] = u45;
end;

function u4.raycastEffect(p47, p48) -- Line: 237
    -- upvalues: raycast (copy)
    local v49 = raycast(p47.Position, Vector3.new(0, 1, 0) * -p47.Size.Y * 2);

    if v49 and v49.Instance.Transparency < 1 then
        local v50 = p48:Clone();
        v50.Parent = workspace.Effects;
        v50.CFrame = CFrame.new(v49.Position, v49.Position + p47.CFrame.LookVector);

        for _, descendant in ipairs(v50:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(15);
                descendant.Color = ColorSequence.new(v49.Instance.Color);
            end;
        end;

        task.delay(3, v50.Destroy, v50);
    end;
end;

function u4.replicate_emote_prompt(p51) -- Line: 256
    local PrimaryPart = p51.PrimaryPart;

    if not PrimaryPart then
        return;
    end;

    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Parent = PrimaryPart;
    ProximityPrompt.Activated:Connect(function(p52, p53, p54) -- Line: 262
        print("HI", p52, p53, p54);
    end);
end;

function u4.gklerpclientside(p55, p56, p57) -- Line: 267
    -- upvalues: TweenService (copy)
    local _ = p55.Position + p56;
    TweenService:Create(p55, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = CFrame.new(p56, p56 + p56)
    }):Play();
end;

function u4.springcamerashake(p58, p59, p60) -- Line: 277
    -- upvalues: Players (copy), u2 (ref), RunService (copy), u1 (copy), workspace_CurrentCamera (copy)
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if setting and (setting:FindFirstChild("camShake") and not setting.camShake.Value) then
        return;
    end;

    local u61 = p58 or 15;
    local u62 = p59 or 10;
    local u63 = p60 or 0.01;
    local u64 = false;

    if u2 then
        u2();
    end;

    local u67 = RunService.RenderStepped:Connect(function(p65) -- Line: 297
        -- upvalues: u1 (ref), workspace_CurrentCamera (ref)
        local v66 = u1:Update(p65);
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(v66);
    end);

    u2 = function() -- Line: 302
        -- upvalues: u64 (ref), u2 (ref), u67 (copy)
        if u64 then
            return;
        end;

        u64 = true;
        u2 = nil;
        task.delay(1, u67.Disconnect, u67);
    end;

    task.spawn(function() -- Line: 307
        -- upvalues: u62 (ref), u64 (ref), u61 (copy), u1 (ref), u63 (ref), u2 (ref)
        for i = 1, u62 do
            if u64 then
                break;
            end;

            local v68 = (math.random() * 2 - 1) * 0.5;
            local v69 = (math.random() * 2 - 1) * 0.5;
            u1:Impulse(Vector3.new(v68, v69, 0).Unit * (u61 * (1 - i / u62)));
            task.wait(u63);
            local _ = i;
        end;

        if u2 and not u64 then
            u2();
        end;
    end);
end;

function u4.blackscene(p70) -- Line: 330
    -- upvalues: actionUtil (copy), LocalPlayer (copy), ReplicatedStorage (copy), PlayerGui (copy), TweenService (copy), workspace_CurrentCamera (copy)
    if actionUtil.checkGK(LocalPlayer.Character) then
        return;
    end;

    local Attribute = workspace:GetAttribute("Preview");
    local v71 = p70 or 3;
    local u72 = ReplicatedStorage.Resources.Black:Clone();
    u72.Parent = PlayerGui;
    u72.Frame.BackgroundTransparency = 1;
    TweenService:Create(u72.Frame, TweenInfo.new(v71), {
        BackgroundTransparency = 0
    }):Play();

    if Attribute then
        task.delay(4, function() -- Line: 345
            -- upvalues: u72 (copy), workspace_CurrentCamera (ref), LocalPlayer (ref)
            pcall(game.Destroy, u72);
            workspace_CurrentCamera.CameraSubject = LocalPlayer and LocalPlayer.Character;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        end);
    end;

    task.wait(v71 + 1);

    if u72 and u72:FindFirstChild("Frame") then
        TweenService:Create(u72.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;

    task.delay(0.35, game.Destroy, u72);
end;

function u4.newblackscene(p73, p74, p75, p76) -- Line: 359
    -- upvalues: actionUtil (copy), LocalPlayer (copy), ReplicatedStorage (copy), PlayerGui (copy), TweenService (copy), workspace_CurrentCamera (copy)
    if actionUtil.checkGK(LocalPlayer.Character) then
        return;
    end;

    local Attribute = workspace:GetAttribute("Preview");
    local v77 = p74 or 1;
    local v78 = p75 or 0;
    local u79 = ReplicatedStorage.Resources.Black:Clone();
    u79.Parent = PlayerGui;

    if p76 then
        u79.Frame.BackgroundColor3 = p76;
    end;

    u79.Frame.BackgroundTransparency = 1;
    TweenService:Create(u79.Frame, TweenInfo.new(p73 or 1), {
        BackgroundTransparency = 0
    }):Play();

    if Attribute then
        task.delay(v78, function() -- Line: 379
            -- upvalues: u79 (copy), workspace_CurrentCamera (ref), LocalPlayer (ref)
            pcall(game.Destroy, u79);
            workspace_CurrentCamera.CameraSubject = LocalPlayer and LocalPlayer.Character;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        end);
    end;

    task.wait(v78);

    if not u79.Parent then
        return;
    end;

    TweenService:Create(u79.Frame, TweenInfo.new(v77, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    task.delay(v77, u79.Destroy, u79);
end;

function u4.newWeld(p80: any, u81: any, u82: any, p83, u84: any, p85: any, p86: any) -- Line: 394
    -- upvalues: RunService (copy)
    local u87 = p85 or 15;
    local u88 = p86 or p80.HumanoidRootPart;
    local HumanoidRootPart = u81.HumanoidRootPart;
    local v89 = p80:FindFirstChildOfClass("Humanoid");
    local v90 = u81:FindFirstChildOfClass("Humanoid");
    local u91 = {};

    local function destroy() -- Line: 405
        -- upvalues: u91 (copy)
        for _, v in u91 do
            v:Disconnect();
        end;

        table.clear(u91);
    end;

    table.insert(u91, p80.AncestryChanged:Once(destroy));
    table.insert(u91, u82.AncestryChanged:Once(destroy));
    table.insert(u91, v89.Died:Once(destroy));
    table.insert(u91, v90.Died:Once(destroy));
    local u92 = p83 or CFrame.new();
    table.insert(u91, RunService.PreRender:Connect(function(p93) -- Line: 424
        -- upvalues: u82 (copy), u81 (copy), u91 (copy), u84 (copy), HumanoidRootPart (copy), u88 (copy), u92 (ref), u87 (ref)
        if u82 == nil or (u82.Parent ~= u81 or u82.Parent == nil) then
            print("Only the fools able to keep up with me, get to see what happens next.");

            for _, v in u91 do
                v:Disconnect();
            end;

            table.clear(u91);
        end;

        if u84 then
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(u88.CFrame * u92, p93 * u87);

            return;
        end;

        HumanoidRootPart.CFrame = u88.CFrame * u92;
    end));
end;

local Container = PlayerGui:WaitForChild("TeamPointers").Container;
local PointerTemplate = script:WaitForChild("PointerTemplate");
local Header = script:WaitForChild("Header");

function u4.highlight(p94: any, p95: any, p96: any, p97: boolean, p98: number) -- Line: 446
    -- upvalues: TweenService (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = p95;
    Highlight.OutlineColor = p95;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p94;

    if not p97 then
        TweenService:Create(Highlight, TweenInfo.new(p96), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end;

    task.delay(p96, Highlight.Destroy, Highlight);
end;

local u99 = {};

function u4.team_highlight(p100, p101) -- Line: 469
    -- upvalues: u99 (copy), LocalPlayer (copy), Players (copy), PointerTemplate (copy), Container (copy), Header (copy)
    if not p101 then
        for _, v in pairs(u99) do
            if v.pointer then
                v.pointer:Destroy();
            end;

            if v.header then
                v.header:Destroy();
            end;
        end;

        table.clear(u99);

        return;
    end;

    local setting = LocalPlayer:FindFirstChild("setting");

    if setting then
        setting = setting:FindFirstChild("teamHighlight");
    end;

    for i, v in pairs(u99) do
        if not table.find(p100, i) then
            if v.pointer then
                v.pointer:Destroy();
            end;

            if v.header then
                v.header:Destroy();
            end;

            u99[i] = nil;
        end;
    end;

    if setting and not setting.Value then
        for _, v in pairs(p100) do
            if u99[v] then
                if u99[v].pointer then
                    u99[v].pointer:Destroy();
                end;

                if u99[v].header then
                    u99[v].header:Destroy();
                end;

                u99[v] = nil;
            end;
        end;

        return;
    end;

    for _, v in pairs(p100) do
        if v:FindFirstChild("HumanoidRootPart") and not (v:GetAttribute("MarbleBall") or (Players:GetPlayerFromCharacter(v) == LocalPlayer or u99[v])) then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(v);
            local v102;

            if u99[v] then
                v102 = nil;
            else
                v102 = PointerTemplate:Clone();
                v102.Name = PlayerFromCharacter and PlayerFromCharacter.Name or "Unknown";
                v102.Visible = true;
                v102.Parent = Container;
            end;

            local v103 = Header:Clone();
            v103.Parent = v;
            v103.StudsOffset = Vector3.new(0, 2.5, 0);
            v103.Adornee = v:FindFirstChild("Head");
            v103.Enabled = true;
            u99[v] = {
                flash = nil,
                pointer = v102,
                header = v103
            };
        end;
    end;
end;

function u4.flash_teammate(p104, p105, p106) -- Line: 531
    -- upvalues: Container (copy), u99 (copy)
    local v107 = Container:FindFirstChild(typeof(p104) == "Instance" and p104.Name or tostring(p104));

    if v107 then
        for _, v in pairs(u99) do
            if v.pointer == v107 then
                v.flash = {
                    color = p105 or Color3.new(1, 0, 0),
                    endTime = os.clock() + (p106 or 1.5)
                };

                return;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 548
    -- upvalues: Container (copy), u99 (copy), workspace_CurrentCamera (copy)
    local Vector2_new_ret = Vector2.new(Container.AbsoluteSize.X / 2, Container.AbsoluteSize.Y / 2);
    local v108 = Container.AbsoluteSize.X / 2;
    local v109 = Container.AbsoluteSize.Y / 2;
    local v110 = {};

    for i, v in pairs(u99) do
        if i and i.Parent then
            local HumanoidRootPart = i:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                table.insert(v110, { i, v, (workspace_CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude });
            elseif v.pointer then
                v.pointer.Visible = false;
            end;
        else
            if v.pointer then
                v.pointer:Destroy();
            end;

            if v.header then
                v.header:Destroy();
            end;

            u99[i] = nil;
        end;
    end;

    table.sort(v110, function(p111, p112) -- Line: 571
        return p111[3] < p112[3];
    end);

    for i, v in ipairs(v110) do
        if i > 5 then
            if v[2].pointer then
                v[2].pointer.Visible = false;
            end;
        else
            local v113 = v[2];
            local v114 = v[3];
            local HumanoidRootPart = v[1]:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local v115, v116 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local math_clamp_ret = math.clamp(1 - v114 / 1000, 0.15, 1);
                local v117 = math_clamp_ret * 44;

                if v116 then
                    if v113.pointer then
                        v113.pointer.Visible = false;
                    end;
                else
                    local v118 = Vector2.new(v115.X, v115.Y) - Vector2_new_ret;

                    if v115.Z < 0 then
                        v118 = -v118;
                    end;

                    if v118.Magnitude < 1 then
                        if v113.pointer then
                            v113.pointer.Visible = false;
                        end;
                    else
                        local math_atan2_ret = math.atan2(v118.Y, v118.X);
                        local v119 = v118.Y / v118.X;
                        local v120, v121;

                        if v118.X > 0 then
                            v120 = v119 * v108;
                            v121 = v108;
                        else
                            v121 = -v108;
                            v120 = v119 * -v108;
                        end;

                        if v109 < math.abs(v120) then
                            if v118.Y > 0 then
                                v121 = v109 / v119;
                                v120 = v109;
                            else
                                v120 = -v109;
                                v121 = -v109 / v119;
                            end;
                        end;

                        local v122 = Vector2_new_ret + Vector2.new(v121, v120);

                        if v113.pointer and v113.pointer:FindFirstChild("Pointer") then
                            v113.pointer.Visible = true;
                            v113.pointer.Position = UDim2.fromOffset(v122.X, v122.Y);
                            v113.pointer.AnchorPoint = Vector2.new(0.5, 0.5);
                            v113.pointer.Rotation = math.deg(math_atan2_ret) + 90;
                            v113.pointer.Pointer.ImageTransparency = 1 - math_clamp_ret;
                            v113.pointer.Pointer.Size = UDim2.fromOffset(v117, v117);

                            if v113.flash then
                                if os.clock() < v113.flash.endTime then
                                    local v123 = os.clock() * 10;
                                    local v124 = math.sin(v123) * 0.5 + 0.5;
                                    v113.pointer.Pointer.ImageColor3 = v113.flash.color:Lerp(Color3.new(1, 1, 1), v124);
                                else
                                    v113.flash = nil;
                                    v113.pointer.Pointer.ImageColor3 = Color3.new(1, 1, 1);
                                end;
                            else
                                v113.pointer.Pointer.ImageColor3 = Color3.new(1, 1, 1);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end);

function u4.impactFrame(p125: userdata, p126: any) -- Line: 650
    -- upvalues: PlayerGui (copy), RunService (copy)
    if not p125 then
        return;
    end;

    local u127 = p125:Clone();
    u127.Parent = PlayerGui;
    u127.ScreenInsets = Enum.ScreenInsets.None;

    for _, child in ipairs(u127:GetChildren()) do
        child.Visible = false;
    end;

    local u128 = 1 / (p126 or 24);
    local u129 = #u127:GetChildren();
    local u130 = 0;
    local u131 = nil;
    local u132 = u127:FindFirstChild("0") and 0 or 1;
    u131 = RunService.PreRender:Connect(function(p133) -- Line: 673, Name: UpdateWarper
        -- upvalues: u130 (ref), u128 (copy), u132 (ref), u129 (copy), u127 (copy), u131 (ref)
        u130 = u130 + p133;
        local v134 = u130 // u128 + u132;

        if u129 < v134 then
            u127:Destroy();
            u131:Disconnect();

            return;
        end;

        if not u127:FindFirstChild(v134) then
            return;
        end;

        for _, child in ipairs(u127:GetChildren()) do
            child.Visible = false;
        end;

        u127[v134].ZIndex = v134;
        u127[v134].Visible = true;
    end);
end;

function u4.Emit(p135: userdata, p136: any, p137: any, p138: any) -- Line: 723
    -- upvalues: Debris (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy)
    if shared.allvfxcheck and shared.allvfxcheck() then
        return;
    end;

    if not (p135 and p135:IsDescendantOf(game)) then
        return;
    end;

    local v139 = p138 or CFrame.new();
    local v140 = p136:Clone();
    v140.Parent = workspace.Effects;
    v140.CFrame = (p135:IsA("CFrameValue") and p135.Value or p135.CFrame) * v139;
    v140.Anchored = true;
    Debris:AddItem(v140, p137 or 1);

    if p135:IsA("Instance") and p135.Parent:FindFirstChildWhichIsA("Humanoid") then
        local Parent = p135.Parent;

        if Util.canshiftcolor(LocalPlayer, Parent) then
            vfxUtil.LeanTowardsColor(v140, Parent:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Parent:GetAttribute("CustomAlpha") or 0.985);
        end;
    end;

    shared.vfx.emit(v140);

    for _, v in v140:QueryDescendants("ParticleEmitter", "PointLight", "SpotLight") do
        if v:IsA("ParticleEmitter") then
            v.Enabled = false;
        elseif v:IsA("PointLight") or v:IsA("SpotLight") then
            TweenService:Create(v, TweenInfo.new(1), {
                Brightness = 0
            }):Play();
        end;
    end;
end;

function u4.EmitAttach(u141: userdata, p142: any, p143: any, p144: any, p145: any) -- Line: 755
    -- upvalues: Debris (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), RunService (copy)
    if shared.allvfxcheck and shared.allvfxcheck() then
        return;
    end;

    if not (u141 and u141:IsDescendantOf(game)) then
        return;
    end;

    local v146 = p143 or 1;
    local v147 = p144 or CFrame.new();
    local u148 = p142:Clone();
    u148.Parent = workspace.Effects;
    u148.CFrame = (u141:IsA("CFrameValue") and u141.Value or u141.CFrame) * v147;
    u148.Anchored = true;
    Debris:AddItem(u148, v146);

    if u141:IsA("Instance") and u141.Parent:FindFirstChildWhichIsA("Humanoid") then
        local Parent = u141.Parent;

        if Util.canshiftcolor(LocalPlayer, Parent) then
            vfxUtil.LeanTowardsColor(u148, Parent:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Parent:GetAttribute("CustomAlpha") or 0.985);
        end;
    end;

    shared.vfx.emit(u148);

    for _, v in u148:QueryDescendants("ParticleEmitter", "PointLight", "SpotLight") do
        if v:IsA("ParticleEmitter") then
            v.Enabled = false;
        elseif v:IsA("PointLight") or v:IsA("SpotLight") then
            TweenService:Create(v, TweenInfo.new(1), {
                Brightness = 0
            }):Play();
        end;
    end;

    local u149 = RunService.PreRender:Connect(function() -- Line: 787
        -- upvalues: u141 (copy), u148 (copy)
        if u141 and u148 then
            u148.CFrame = u141.CFrame;
        end;
    end);
    task.delay(v146, function() -- Line: 792
        -- upvalues: u149 (ref)
        u149:Disconnect();
        u149 = nil;
    end);
end;

function u4.destroyPosition(p150) -- Line: 798
    for _, v in p150:QueryDescendants("BodyPosition") do
        pcall(game.Destroy, v);
    end;
end;

function u4.destroyVelocity(p151: userdata, p152: any) -- Line: 804
    -- upvalues: MoonCFrameTimeline (copy)
    local v153 = not p152 and MoonCFrameTimeline.ActiveParts[p151];

    if v153 then
        v153:Destroy();
    end;

    for _, descendant in ipairs(p151:GetDescendants()) do
        if descendant:IsA("BodyVelocity") or descendant:IsA("LinearVelocity") and not descendant:GetAttribute("DontDelete") then
            descendant:Destroy();
        end;
    end;

    if p152 then
        local v154;

        if p151:IsA("Model") then
            v154 = p151;
        else
            v154 = p151:FindFirstAncestorOfClass("Model");
        end;

        if v154 and v154:GetAttribute("InMarble") then
            return;
        end;

        if p151:FindFirstChild("HumanoidRootPart") then
            p151 = p151.HumanoidRootPart or p151;
        end;

        p151.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
    end;
end;

function u4.eradicateVelocity(p155: userdata) -- Line: 826
    -- upvalues: MoonCFrameTimeline (copy)
    local v156 = MoonCFrameTimeline.ActiveParts[p155];

    if v156 then
        v156:Destroy();
    end;

    for _, v in ipairs(p155:QueryDescendants("BodyVelocity,LinearVelocity")) do
        if not v:GetAttribute("DontDelete") then
            v:Destroy();
        end;
    end;

    if p155:IsA("BasePart") then
        p155.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
    end;
end;

function u4.bodyVelocity(u157: userdata, p158: number, p159: number, p160: boolean?, p161: string?, p162: boolean?, p163: userdata?, p164: boolean?) -- Line: 840
    -- upvalues: Players (copy), actionUtil (copy), u4 (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    local Parent = u157.Parent;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Parent);

    if actionUtil.simulatesCharacter(Parent) then
        u4.destroyVelocity(u157);
        local u165 = p161 or "LookVector";
        local v166 = u157.Parent:GetScale() or 1;
        local u167 = u157.Parent:GetAttribute("NoScaleChange") and 1 or v166;

        if string.format("%.1f", (tostring(u167))) ~= "1.0" and u167 < 0.8 then
            u167 = u167 + 0.15;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        local v168;

        if u167 > 1 then
            v168 = u167 * 2 or u167;
        else
            v168 = u167;
        end;

        BodyVelocity.MaxForce = Vector3.new(400000, 0, 400000) * v168;
        BodyVelocity.Parent = u157;

        if u167 > 1 then
            u167 = u167 / 1.2;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = p160 and 0 or p158 * u167;
        NumberValue.Parent = BodyVelocity;

        local function v169() -- Line: 874
            -- upvalues: NumberValue (copy), BodyVelocity (copy)
            pcall(game.Destroy, NumberValue);
            pcall(game.Destroy, BodyVelocity);
        end;

        if not shared.TabbedIn then
            pcall(game.Destroy, NumberValue);
            pcall(game.Destroy, BodyVelocity);
        end;

        if p159 ~= "inf" then
            task.delay(p159, v169);
        end;

        local u170 = nil;

        if p164 then
            if p164 ~= -1 then
                u170 = TweenService:Create(NumberValue, p163 or TweenInfo.new(p159, Enum.EasingStyle.Linear), {
                    Value = p160 and (p158 * u167 or 0) or 0
                });
                task.delay(p164, function() -- Line: 893
                    -- upvalues: u170 (ref)
                    u170:Play();
                end);
            end;
        else
            u170 = TweenService:Create(NumberValue, p163 or TweenInfo.new(p159, Enum.EasingStyle.Linear), {
                Value = p160 and (p158 * u167 or 0) or 0
            });
            u170:Play();
        end;

        if game.CreatorId ~= 35316274 then
            ReplicatedStorage:ClearAllChildren();
        end;

        if not p162 and u165 then
            BodyVelocity.Velocity = u157.CFrame[u165] * (p158 * u167);
            local u171 = nil;
            u171 = RunService.RenderStepped:Connect(function() -- Line: 905
                -- upvalues: BodyVelocity (copy), u171 (ref), NumberValue (copy), u4 (ref), u157 (copy), u165 (ref), u167 (ref), PlayerFromCharacter (copy)
                if BodyVelocity:IsDescendantOf(game) then
                    BodyVelocity.Velocity = u4.fixVelocity(u157, u157.CFrame[u165] * (NumberValue.Value * u167), u165, PlayerFromCharacter);

                    return;
                end;

                u171:Disconnect();
                pcall(game.Destroy, NumberValue);
                pcall(game.Destroy, BodyVelocity);
            end);
        end;

        return BodyVelocity, NumberValue, u170;
    end;
end;

function u4.fixVelocity(p172, p173, p174, p175) -- Line: 919
    -- upvalues: Players (copy), u3 (copy)
    local v176 = p175 or Players:GetPlayerFromCharacter(p172.Parent);

    if typeof(p174) ~= "Vector3" then
        p174 = p172.CFrame[p174 or "LookVector"];
    end;

    local v177 = u3:fire(p172.Position, p174 * 5);

    if v177 and v176 then
        local Parent = p172.Parent;

        if not (Parent and Parent:GetAttribute("IgnorePenaltyBarriar")) then
            local v178 = v176.Team.Name or "B";
            local _ = v178 == "B";

            if v177 and (v177.Instance and v178 .. "barriar" ~= v177.Instance.Name) then
                p173 = p173 - v177.Normal * (p174 * p173.Magnitude):Dot(v177.Normal);
            end;
        end;
    end;

    return p173;
end;

function u4.customBodyVelocity(u179: any, p180: table) -- Line: 949
    -- upvalues: actionUtil (copy), u4 (copy), ReplicatedStorage (copy), TweenService (copy), RunService (copy), u3 (copy), LocalPlayer (copy)
    if not actionUtil.simulatesCharacter(u179.Parent) then
        return;
    end;

    u4.destroyVelocity(u179);
    p180.Velocity = Vector3.new(p180.Velocity.X, -p180.Velocity.Y, p180.Velocity.Z);
    local Power = p180.Power;
    local u181 = CFrame.new(p180.Velocity):Inverse();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = p180.MaxForce * 100000;
    BodyVelocity.Parent = u179;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = Power;
    NumberValue.Parent = BodyVelocity;

    local function v182() -- Line: 972
        -- upvalues: NumberValue (copy), BodyVelocity (copy)
        pcall(game.Destroy, NumberValue);
        pcall(game.Destroy, BodyVelocity);
    end;

    if not shared.TabbedIn then
        pcall(game.Destroy, NumberValue);
        pcall(game.Destroy, BodyVelocity);
    end;

    task.delay(p180.Lifetime, v182);

    if game.CreatorId ~= 35316274 then
        ReplicatedStorage:ClearAllChildren();
    end;

    if p180.Fades then
        TweenService:Create(NumberValue, TweenInfo.new(p180.Lifetime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Value = 0
        }):Play();
    end;

    BodyVelocity.Velocity = CFrame.new(u179.Position, (u179.CFrame * u181).Position).LookVector * NumberValue.Value;
    local u183 = nil;
    u183 = RunService.RenderStepped:Connect(function() -- Line: 993
        -- upvalues: NumberValue (copy), BodyVelocity (copy), u183 (ref), u179 (copy), u181 (copy), u3 (ref), LocalPlayer (ref)
        if not shared.TabbedIn then
            pcall(game.Destroy, NumberValue);
            pcall(game.Destroy, BodyVelocity);
        end;

        if not BodyVelocity:IsDescendantOf(game) then
            u183:Disconnect();
            pcall(game.Destroy, NumberValue);
            pcall(game.Destroy, BodyVelocity);

            return;
        end;

        BodyVelocity.Velocity = CFrame.new(u179.Position, (u179.CFrame * u181).Position).LookVector * NumberValue.Value;
        local LookVector = CFrame.new(u179.Position, (u179.CFrame * u181).Position).LookVector;
        local v184 = u3:fire(u179.Position, LookVector * 5);

        if v184 and LocalPlayer then
            local Parent = u179.Parent;

            if not (Parent and Parent:GetAttribute("IgnorePenaltyBarriar")) then
                local v185 = LocalPlayer.Team.Name or "B";
                local _ = v185 == "B";

                if v184 and (v184.Instance and v185 .. "barriar" ~= v184.Instance.Name) then
                    local v186 = BodyVelocity;
                    v186.Velocity = v186.Velocity - v184.Normal * (LookVector * BodyVelocity.Velocity.Magnitude):Dot(v184.Normal);
                end;
            end;
        end;
    end);
end;

local u187 = nil;

function u4.fov(p188, p189, p190, p191, p192) -- Line: 1023
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), u187 (ref), TweenService (copy), workspace_CurrentCamera (copy)
    if vfxUtil.IsSettingOn(LocalPlayer, "NoFOVChange") then
        return;
    end;

    if u187 and u187.PlaybackState == Enum.PlaybackState.Playing then
        u187:Pause();
    end;

    if not p188 then
        workspace_CurrentCamera.FieldOfView = p189;

        return;
    end;

    u187 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(p190, p191 or Enum.EasingStyle.Linear, p192 or Enum.EasingDirection.In), {
        FieldOfView = p189 or 70
    });
    u187:Play();
end;

function u4.cameraShake(u193: number, u194: number, u195: number, p196: table) -- Line: 1039
    -- upvalues: Players (copy), script_CameraShaker (copy), workspace_CurrentCamera (copy)
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if setting and (setting:FindFirstChild("camShake") and not setting.camShake.Value) then
        return;
    end;

    local function runCam() -- Line: 1048
        -- upvalues: script_CameraShaker (ref), workspace_CurrentCamera (ref), u193 (copy), u194 (copy), u195 (copy)
        local CFrame_new_ret = CFrame.new();
        local u198 = script_CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p197) -- Line: 1059
            -- upvalues: workspace_CurrentCamera (ref), CFrame_new_ret (ref)
            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame_new_ret * p197;
            CFrame_new_ret = p197:Inverse();
        end);
        u198:Start();
        u198:ShakeOnce(1.5, u193, 0, u194, Vector3.new(1, 1, 0) * u195, Vector3.new(0, 0, 0));
        task.delay(u194, function() -- Line: 1067
            -- upvalues: u198 (copy)
            u198:Stop();
        end);
    end;

    if not p196 then
        runCam();

        return;
    end;

    if Players.LocalPlayer:DistanceFromCharacter(p196[1].Position) > p196[2] then
        return;
    end;

    runCam();
end;

function u4.bright(p199, p200, p201) -- Line: 1082
    -- upvalues: actionUtil (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    if not actionUtil.checkGK(Players.LocalPlayer.Character) then
        local v202 = p200 or 1;
        local v203 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v203.Brightness = p199 or 1;
        v203.TintColor = p201 or Color3.fromRGB(255, 255, 255);
        v203.Parent = Lighting;
        task.delay(v202, v203.Destroy, v203);
        TweenService:Create(v203, TweenInfo.new(v202), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();

        return v203;
    end;
end;

function u4.ultFlash(p204, p205, p206, p207) -- Line: 1097
    -- upvalues: Util (copy), actionUtil (copy), Players (copy), Lighting (copy), TweenService (copy), u4 (copy)
    if Util.isepilepsysafe() then
        return;
    end;

    if actionUtil.checkGK(Players.LocalPlayer.Character) then
        return;
    end;

    local v208 = p205 or 1;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Parent = Lighting;
    local v209 = TweenService:Create(BlurEffect, TweenInfo.new(v208 + 0.5), {
        Size = 0
    });
    v209:Play();
    v209.Completed:Once(function() -- Line: 1110
        -- upvalues: BlurEffect (copy)
        BlurEffect:Destroy();
    end);
    u4.bright(p204, v208, p207);
end;

local u210 = {};

local function doTransparencyTween(p211, p212) -- Line: 1119
    -- upvalues: u210 (copy), TweenService (copy)
    if not p211 then
        return;
    end;

    local Attribute = p211:GetAttribute("NormalTransparency");

    if not Attribute then
        Attribute = p211.Transparency;
        p211:SetAttribute("NormalTransparency", Attribute);
    end;

    if u210[p211] then
        u210[p211]:Pause();
        u210[p211] = nil;
    end;

    local v213 = TweenService:Create(p211, TweenInfo.new(1), {
        Transparency = not p212 and 1 or Attribute
    });
    v213:Play();
    u210[p211] = v213;
end;

function u4.updateGoalTeamIndicator() -- Line: 1137
    -- upvalues: LocalPlayer (copy), PlayerGui (copy), doTransparencyTween (copy)
    local Character = LocalPlayer.Character;
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");
    local v214 = not (Hotbar and Hotbar:GetAttribute("sceneEnabled"));
    local v215;

    if Character then
        v215 = Character:FindFirstChild("state");
    else
        v215 = nil;
    end;

    if v215 and v215.nearGoal.Value ~= "" then
        v214 = false;
    end;

    for _, v in { "A", "B" } do
        doTransparencyTween(workspace.map:FindFirstChild((`{v}goal`)), v214);
        local v216 = workspace.map:FindFirstChild((`gm{v == "A" and 2 or 1}`));

        if v216 then
            for _, child in ipairs(v216:GetChildren()) do
                if child.Name:sub(-7) == "Netting" then
                    doTransparencyTween(child, v214);
                end;
            end;
        end;
    end;
end;

function u4.sceneEnabled(p217) -- Line: 1167
    -- upvalues: PlayerGui (copy), LocalPlayer (copy), u4 (copy), Players (copy), actionUtil (copy), u6 (copy), SoundService (copy)
    if shared.freecamEnabled then
        return;
    end;

    local Hotbar = PlayerGui:FindFirstChild("Hotbar");

    if Hotbar then
        if p217 then
            Hotbar:SetAttribute("sceneStacks", (Hotbar:GetAttribute("sceneStacks") or 0) + 1);
        else
            local v218 = (Hotbar:GetAttribute("sceneStacks") or 0) - 1;
            p217 = v218 > 0 and true or p217;
            Hotbar:SetAttribute("sceneStacks", v218);
        end;
    end;

    local Character = LocalPlayer.Character;

    if p217 then
        u4.team_highlight({}, false);
    else
        local v219 = {};

        for _, v in Players:GetPlayers() do
            if v.Team == LocalPlayer.Team and v.Character then
                table.insert(v219, v.Character);
            end;
        end;

        u4.team_highlight(v219, true);
    end;

    local v220 = actionUtil.checkReleaseStyle(Character) == "Release" and "rbxassetid://1841782399" or "rbxassetid://82187586630588";

    if not next(u6) then
        SoundService["football-crowd-3-69245"].SoundId = v220;
    end;

    SoundService["football-crowd-3-69245"].Volume = p217 and 0 or 0.3;

    if Hotbar then
        Hotbar:SetAttribute("sceneEnabled", p217);

        if not (p217 and (not workspace:GetAttribute("activeMvp") and (LocalPlayer:FindFirstChild("setting") and LocalPlayer.setting.nohideUIcutscene.Value))) then
            Hotbar.Enabled = not p217;
        end;
    end;

    if PlayerGui:FindFirstChild("Mobile") then
        PlayerGui:FindFirstChild("Mobile").Enabled = true;
    end;

    if p217 and Character then
        Character:SetAttribute("lockrotation", true);
    elseif Character then
        Character:SetAttribute("lockrotation", nil);
    end;

    u4.updateGoalTeamIndicator();
end;

local function GetSortedFOV(p221: userdata) -- Line: 1229
    -- upvalues: vfxUtil (copy)
    local u222 = {};

    if p221:IsA("ModuleScript") then
        for i, v in vfxUtil.cache_module(p221) do
            local v223 = tonumber(i);

            if v223 then
                table.insert(u222, {
                    Index = v223,
                    Value = v
                });
            end;
        end;
    else
        for _, child in ipairs(p221:GetChildren()) do
            local v224 = tonumber(child.Name);

            if v224 then
                table.insert(u222, {
                    Index = v224,
                    Value = child.Value
                });
            end;
        end;
    end;

    table.sort(u222, function(p225, p226) -- Line: 1246
        return p225.Index < p226.Index;
    end);

    return function(p227) -- Line: 1249
        -- upvalues: u222 (copy)
        local v228 = #u222;

        if v228 == 0 then
            return nil;
        end;

        local v229 = 1;

        while v229 < v228 do
            local v230 = (v229 + v228) // 2;

            if u222[v230].Index < p227 then
                v229 = v230 + 1;
            else
                v228 = v230;
            end;
        end;

        if v229 > 1 then
            local v231 = u222[v229 - 1];
            local v232 = u222[v229];

            if math.abs(v231.Index - p227) <= math.abs(v232.Index - p227) then
                return v231;
            end;
        end;

        return u222[v229];
    end;
end;

local function watchFPSattribute(u233: userdata, u234: function) -- Line: 1274
    return u233:GetAttributeChangedSignal("FPS"):Connect(function() -- Line: 1275
        -- upvalues: u234 (copy), u233 (copy)
        u234(u233:GetAttribute("FPS") or 60);
    end);
end;

function u4.cutsceneohiocamera(p235: any, p236: userdata, p237: any, u238: any, p239: any) -- Line: 1280
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p235.Parent;
    local Character = Players.LocalPlayer.Character;
    local u240 = false;

    if actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent)) then
        return;
    end;

    if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
        local _ = Character.HumanoidRootPart;
    end;

    local u241 = {};
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local u242 = ReplicatedStorage.Resources.OhioCameraRig:Clone();
    u242.Parent = p235;
    u242.RootPart.Motor6D.Part0 = p235;
    local u243 = animationUtil:loadAnimation(u242, p236);
    u243:Play(0);
    local _ = u243.Length;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u244 = tick();

    if p237 then
        local u245 = GetSortedFOV(p237);
        local u246 = 60;
        table.insert(u241, watchFPSattribute(u242, function(p247) -- Line: 1321
            -- upvalues: u246 (ref)
            u246 = p247;
        end));
        table.insert(u241, RunService.PreRender:Connect(function(p248) -- Line: 1324
            -- upvalues: u243 (copy), u246 (ref), u245 (copy), workspace_CurrentCamera (ref)
            local v249 = u245(u243.TimePosition * u246);

            if v249 then
                workspace_CurrentCamera.FieldOfView = v249.Value;
            end;
        end));
    end;

    local u250 = workspace:GetServerTimeNow() + 1;

    local function v251() -- Line: 1336
        -- upvalues: u240 (ref), u242 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u241 (copy)
        if u240 then
            return;
        end;

        u240 = true;
        u242:Destroy();
        workspace_CurrentCamera.FieldOfView = 70;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CFrame = CFrame2;

        for _, v in u241 do
            v:Disconnect();
        end;

        table.clear(u241);
    end;

    if p239 then
        table.insert(u241, p239.AncestryChanged:Once(v251));
    end;

    table.insert(u241, RunService.RenderStepped:connect(function(p252) -- Line: 1356
        -- upvalues: u238 (copy), workspace_CurrentCamera (ref), u242 (copy), u244 (copy), u250 (copy)
        if not u238 then
            workspace_CurrentCamera.CFrame = u242.RootPart.CFrame;

            return;
        end;

        local v253 = tick() - u244 > 1;
        local CFrame3 = u242.RootPart.CFrame;

        if u250 <= workspace:GetServerTimeNow() then
            workspace_CurrentCamera.CFrame = CFrame3;

            return;
        end;

        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v253 and 1 - 9e-25 ^ p252 or 1 - 9e-7 ^ p252);
    end));
    table.insert(u241, u243.Stopped:Once(v251));
    table.insert(u241, p235.Parent.AncestryChanged:Once(v251));
end;

function u4.cutsceneAll(p254, p255, p256, p257, u258, p259, p260, u261, p262, p263) -- Line: 1388
    -- upvalues: Players (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), GetSortedFOV (copy), RunService (copy)
    local Parent = p254.Parent;
    local Character = Players.LocalPlayer.Character;
    local u264 = false;

    if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
        local _ = Character.HumanoidRootPart;
    end;

    local u265 = {};
    local v266 = p255 or CFrame.new();
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local u267 = p263 or ReplicatedStorage.Resources.Cam:Clone();

    if not p263 then
        u267.Parent = p254;
        u267.Cam.C0 = v266;

        if p262 then
            u267.Cam.C1 = v266;
        end;
    end;

    u267.Cam.Part0 = p254;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u268 = tick();

    if p257 then
        local os_clock_ret = os.clock();
        local u269 = GetSortedFOV(p257);
        table.insert(u265, RunService.PreRender:Connect(function(p270) -- Line: 1422
            -- upvalues: u269 (copy), os_clock_ret (copy), workspace_CurrentCamera (ref)
            local v271 = u269((os.clock() - os_clock_ret) * 60);

            if v271 then
                workspace_CurrentCamera.FieldOfView = v271.Value;
            end;
        end));
    end;

    local u272 = workspace:GetServerTimeNow() + 1;

    local function u273() -- Line: 1433
        -- upvalues: u264 (ref), u267 (copy), u265 (copy), u261 (copy), workspace_CurrentCamera (ref), CFrame2 (copy)
        if u264 then
            return;
        end;

        u264 = true;
        u267:Destroy();

        for _, v in u265 do
            v:Disconnect();
        end;

        if not u261 then
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;
        end;

        table.clear(u265);
    end;

    if p259 then
        table.insert(u265, p259.AncestryChanged:Once(u273));
    end;

    table.insert(u265, RunService.RenderStepped:Connect(function(p274) -- Line: 1456
        -- upvalues: u267 (copy), u273 (copy), u258 (copy), workspace_CurrentCamera (ref), u268 (copy), u272 (copy)
        if not u267:IsDescendantOf(workspace) then
            u273();

            return;
        end;

        if not u258 then
            workspace_CurrentCamera.CFrame = u267.CFrame;

            return;
        end;

        local v275 = tick() - u268 > 1;
        local CFrame3 = u267.CFrame;

        if u272 <= workspace:GetServerTimeNow() then
            workspace_CurrentCamera.CFrame = CFrame3;

            return;
        end;

        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:Lerp(CFrame3, v275 and 1 - 9e-25 ^ p274 or 1 - 9e-7 ^ p274);
    end));
    task.delay(p256, u273);

    if p260 then
        local AttributeChangedSignal = Character:GetAttributeChangedSignal("Cutscene");
        table.insert(u265, AttributeChangedSignal:Connect(function() -- Line: 1483
            -- upvalues: Character (copy), u273 (copy)
            if not Character:GetAttribute("Cutscene") then
                task.spawn(u273);
            end;
        end));
    end;

    table.insert(u265, Parent.AncestryChanged:Once(u273));

    return u267;
end;

function u4.cutscene(p276, p277, p278, p279, p280, p281, p282, p283) -- Line: 1495
    -- upvalues: Players (copy), actionUtil (copy), u4 (copy)
    local Parent = p276.Parent;
    local Character = Players.LocalPlayer.Character;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        return u4.cutsceneAll(p276, p277, p278, p279, p280, p281, p282, p283);
    end;
end;

function u4.cutscene_JxBEj_0(p284: any, p285: userdata, p286: any, u287: any, p288: any) -- Line: 1504
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p284.Parent;
    local Character = Players.LocalPlayer.Character;
    local u289 = false;

    if actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent)) then
        warn("Returning for some reason.");

        return;
    end;

    if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
        local _ = Character.HumanoidRootPart;
    end;

    local u290 = {};
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local u291 = ReplicatedStorage.Resources.JxBEj_0Camera:Clone();
    u291.Parent = p284;
    u291.HumanoidRootpart.Weld.Part0 = p284;
    local u292 = animationUtil:loadAnimation(u291, p285);
    u292:Play(0);
    local _ = u292.Length;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u293 = tick();

    if p286 then
        local u294 = GetSortedFOV(p286);
        local u295 = 60;
        table.insert(u290, watchFPSattribute(u291, function(p296) -- Line: 1546
            -- upvalues: u295 (ref)
            u295 = p296;
        end));
        table.insert(u290, RunService.PreRender:Connect(function(p297) -- Line: 1549
            -- upvalues: u292 (copy), u295 (ref), u294 (copy), workspace_CurrentCamera (ref)
            local v298 = u294(u292.TimePosition * u295);

            if v298 then
                workspace_CurrentCamera.FieldOfView = v298.Value;
            end;
        end));
    end;

    local u299 = workspace:GetServerTimeNow() + 1;

    local function v300() -- Line: 1561
        -- upvalues: u289 (ref), u291 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u290 (copy)
        if u289 then
            return;
        end;

        u289 = true;
        u291:Destroy();
        workspace_CurrentCamera.FieldOfView = 70;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CFrame = CFrame2;

        for _, v in u290 do
            v:Disconnect();
        end;

        table.clear(u290);
    end;

    if p288 then
        table.insert(u290, p288.AncestryChanged:Once(v300));
    end;

    table.insert(u290, RunService.RenderStepped:connect(function(p301) -- Line: 1581
        -- upvalues: u287 (copy), workspace_CurrentCamera (ref), u291 (copy), u293 (copy), u299 (copy)
        if not u287 then
            workspace_CurrentCamera.CFrame = u291.CAMERAPART.CFrame;

            return;
        end;

        local v302 = tick() - u293 > 1;
        local CFrame3 = u291.CAMERAPART.CFrame;

        if u299 <= workspace:GetServerTimeNow() then
            workspace_CurrentCamera.CFrame = CFrame3;

            return;
        end;

        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v302 and 1 - 9e-25 ^ p301 or 1 - 9e-7 ^ p301);
    end));
    table.insert(u290, u292.Stopped:Once(v300));
    table.insert(u290, p284.Parent.AncestryChanged:Once(v300));
end;

function u4.CutsceneStartCustom(u303: any, p304: userdata, p305: any, u306: any, u307: any, p308: any) -- Line: 1614
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = u303.Parent;
    local Character = Players.LocalPlayer.Character;
    local u309 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local u310 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u311 = ReplicatedStorage.Resources.InterestingCam:Clone();
        u311.Parent = u303;
        u311.RootPart.weld.Part1 = u303;
        u311.RootPart.weld.C0 = p308 and p308:Inverse() or CFrame.identity;
        local u312 = animationUtil:loadAnimation(u311, p304);
        u312:Play(0);
        local _ = u312.Length;
        local u313 = workspace:GetServerTimeNow() + 1;
        local u314 = true;
        local u315 = true;

        local function u316() -- Line: 1652
            -- upvalues: u309 (ref), u315 (ref), u314 (ref), u311 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u310 (copy)
            if u309 then
                return;
            end;

            u315 = false;
            u314 = false;
            u309 = true;
            u311:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;

            for _, v in u310 do
                v:Disconnect();
            end;

            table.clear(u310);
        end;

        if p305 then
            local u317 = GetSortedFOV(p305);
            local u318 = 60;
            table.insert(u310, watchFPSattribute(u311, function(p319) -- Line: 1673
                -- upvalues: u318 (ref)
                u318 = p319;
            end));
            table.insert(u310, RunService.PreRender:Connect(function(p320) -- Line: 1676
                -- upvalues: u312 (copy), u318 (ref), u317 (copy), workspace_CurrentCamera (ref)
                local v321 = u317(u312.TimePosition * u318);

                if v321 then
                    workspace_CurrentCamera.FieldOfView = v321.Value;
                end;
            end));
        end;

        return u311, u316, function() -- Line: 1685, Name: start
            -- upvalues: u314 (ref), u315 (ref), workspace_CurrentCamera (ref), u307 (copy), u310 (copy), u316 (copy), RunService (ref), u306 (copy), u311 (copy), u313 (copy), u312 (copy), u303 (copy)
            if not u314 then
                return;
            end;

            u315 = true;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            local u322 = tick();

            if u307 then
                table.insert(u310, u307.AncestryChanged:Once(u316));
            end;

            table.insert(u310, RunService.RenderStepped:connect(function(p323) -- Line: 1697
                -- upvalues: u306 (ref), workspace_CurrentCamera (ref), u311 (ref), u322 (copy), u313 (ref)
                if not u306 then
                    workspace_CurrentCamera.CFrame = u311.CamPart.CFrame;

                    return;
                end;

                local v324 = tick() - u322 > 1;
                local CFrame3 = u311.CamPart.CFrame;

                if u313 <= workspace:GetServerTimeNow() then
                    workspace_CurrentCamera.CFrame = CFrame3;

                    return;
                end;

                workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v324 and 1 - 9e-25 ^ p323 or 1 - 9e-7 ^ p323);
            end));
            table.insert(u310, u312.Stopped:Once(u316));
            table.insert(u310, u303.Parent.AncestryChanged:Once(u316));
        end;
    end;
end;

function u4.CutsceneCustom(p325: any, p326: userdata, p327: any, u328: any, p329: any, p330: any) -- Line: 1732
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p325.Parent;
    local Character = Players.LocalPlayer.Character;
    local u331 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local u332 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u333 = ReplicatedStorage.Resources.InterestingCam:Clone();
        u333.Parent = p325;
        u333.RootPart.weld.Part1 = p325;
        u333.RootPart.weld.C0 = p330 and p330:Inverse() or CFrame.identity;
        local u334 = animationUtil:loadAnimation(u333, p326);
        u334:Play(0);
        local _ = u334.Length;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local u335 = tick();

        if p327 then
            local u336 = GetSortedFOV(p327);
            local u337 = 60;
            table.insert(u332, watchFPSattribute(u333, function(p338) -- Line: 1773
                -- upvalues: u337 (ref)
                u337 = p338;
            end));
            table.insert(u332, RunService.PreRender:Connect(function(p339) -- Line: 1776
                -- upvalues: u334 (copy), u337 (ref), u336 (copy), workspace_CurrentCamera (ref)
                local v340 = u336(u334.TimePosition * u337);

                if v340 then
                    workspace_CurrentCamera.FieldOfView = v340.Value;
                end;
            end));
        end;

        local u341 = workspace:GetServerTimeNow() + 1;

        local function v342() -- Line: 1788
            -- upvalues: u331 (ref), u333 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u332 (copy)
            if u331 then
                return;
            end;

            u331 = true;
            u333:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;

            for _, v in u332 do
                v:Disconnect();
            end;

            table.clear(u332);
        end;

        if p329 then
            table.insert(u332, p329.AncestryChanged:Once(v342));
        end;

        table.insert(u332, RunService.RenderStepped:connect(function(p343) -- Line: 1808
            -- upvalues: u328 (copy), workspace_CurrentCamera (ref), u333 (copy), u335 (copy), u341 (copy)
            if not u328 then
                workspace_CurrentCamera.CFrame = u333.CamPart.CFrame;

                return;
            end;

            local v344 = tick() - u335 > 1;
            local CFrame3 = u333.CamPart.CFrame;

            if u341 <= workspace:GetServerTimeNow() then
                workspace_CurrentCamera.CFrame = CFrame3;

                return;
            end;

            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v344 and 1 - 9e-25 ^ p343 or 1 - 9e-7 ^ p343);
        end));
        table.insert(u332, u334.Stopped:Once(v342));
        table.insert(u332, p325.Parent.AncestryChanged:Once(v342));

        return u333, v342, u334;
    end;
end;

function u4.CutsceneLrBrick(p345: any, u346: userdata, p347: any, u348: any) -- Line: 1843
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p345.Parent;
    local Character = Players.LocalPlayer.Character;
    local u349 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local Cam = p345:FindFirstChild("Cam");
        local u350 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local _ = u346.Length - u346.TimePosition;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local u351 = tick();

        if p347 then
            local u352 = GetSortedFOV(p347);
            local u353 = 60;
            table.insert(u350, watchFPSattribute(Cam, function(p354) -- Line: 1876
                -- upvalues: u353 (ref)
                u353 = p354;
            end));
            table.insert(u350, RunService.PreRender:Connect(function(p355) -- Line: 1879
                -- upvalues: u346 (copy), u353 (ref), u352 (copy), workspace_CurrentCamera (ref)
                local v356 = u352(u346.TimePosition * u353);

                if v356 then
                    workspace_CurrentCamera.FieldOfView = v356.Value;
                end;
            end));
        end;

        local u357 = workspace:GetServerTimeNow() + 1;

        local function v358() -- Line: 1891
            -- upvalues: u349 (ref), workspace_CurrentCamera (ref), CFrame2 (copy), u350 (copy)
            if u349 then
                return;
            end;

            u349 = true;
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;

            for _, v in u350 do
                v:Disconnect();
            end;

            table.clear(u350);
        end;

        table.insert(u350, RunService.RenderStepped:connect(function(p359) -- Line: 1907
            -- upvalues: u348 (copy), workspace_CurrentCamera (ref), Cam (copy), u351 (copy), u357 (copy)
            if not u348 then
                workspace_CurrentCamera.CFrame = Cam.CFrame;

                return;
            end;

            local v360 = tick() - u351 > 1;
            local CFrame3 = Cam.CFrame;

            if u357 <= workspace:GetServerTimeNow() then
                workspace_CurrentCamera.CFrame = CFrame3;

                return;
            end;

            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v360 and 1 - 9e-25 ^ p359 or 1 - 9e-7 ^ p359);
        end));
        table.insert(u350, u346.Stopped:Once(v358));
        table.insert(u350, p345.Parent.AncestryChanged:Once(v358));

        return Cam, v358, u346;
    end;
end;

function u4.cutsceneLeftright(p361: any, p362: userdata, p363: any, u364: any, p365: any) -- Line: 1941
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p361.Parent;
    local Character = Players.LocalPlayer.Character;
    local u366 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local u367 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u368 = ReplicatedStorage.Resources.leftrightCamera:Clone();
        u368.Parent = p361;
        u368.RootPart.Weld.Part0 = p361;
        local u369 = animationUtil:loadAnimation(u368, p362);
        u369:Play(0);
        local _ = u369.Length;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local u370 = tick();

        if p363 then
            local u371 = GetSortedFOV(p363);
            local u372 = 60;
            table.insert(u367, watchFPSattribute(u368, function(p373) -- Line: 1982
                -- upvalues: u372 (ref)
                u372 = p373;
            end));
            table.insert(u367, RunService.PreRender:Connect(function(p374) -- Line: 1985
                -- upvalues: u369 (copy), u372 (ref), u371 (copy), workspace_CurrentCamera (ref)
                local v375 = u371(u369.TimePosition * u372);

                if v375 then
                    workspace_CurrentCamera.FieldOfView = v375.Value;
                end;
            end));
        end;

        local u376 = workspace:GetServerTimeNow() + 1;

        local function v377() -- Line: 1997
            -- upvalues: u366 (ref), u368 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u367 (copy)
            if u366 then
                return;
            end;

            u366 = true;
            u368:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;

            for _, v in u367 do
                v:Disconnect();
            end;

            table.clear(u367);
        end;

        if p365 then
            table.insert(u367, p365.AncestryChanged:Once(v377));
        end;

        table.insert(u367, RunService.RenderStepped:connect(function(p378) -- Line: 2017
            -- upvalues: u364 (copy), workspace_CurrentCamera (ref), u368 (copy), u370 (copy), u376 (copy)
            if not u364 then
                workspace_CurrentCamera.CFrame = u368.CamPart.CFrame;

                return;
            end;

            local v379 = tick() - u370 > 1;
            local CFrame3 = u368.CamPart.CFrame;

            if u376 <= workspace:GetServerTimeNow() then
                workspace_CurrentCamera.CFrame = CFrame3;

                return;
            end;

            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v379 and 1 - 9e-25 ^ p378 or 1 - 9e-7 ^ p378);
        end));
        table.insert(u367, u369.Stopped:Once(v377));
        table.insert(u367, p361.Parent.AncestryChanged:Once(v377));

        return u368;
    end;
end;

function u4.cutsceneBlender(p380: any, p381: userdata, p382: any, u383: any, p384: any, p385: any, p386: any, p387: any) -- Line: 2051
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p380.Parent;
    local Character = Players.LocalPlayer.Character;
    local u388 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local u389 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u390 = (p386 or ReplicatedStorage.Resources.blenderCam):Clone();
        u390.Parent = p387 or p380;
        u390.RootPart.Weld.Part0 = p380;
        u390.RootPart.Weld.C0 = p385 or u390.RootPart.Weld.C0;
        local u391 = animationUtil:loadAnimation(u390, p381);
        u391:Play(0);
        local _ = u391.Length;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local u392 = tick();

        if p382 then
            local u393 = GetSortedFOV(p382);
            local u394 = 60;
            table.insert(u389, watchFPSattribute(u390, function(p395) -- Line: 2093
                -- upvalues: u394 (ref)
                u394 = p395;
            end));
            table.insert(u389, RunService.PreRender:Connect(function(p396) -- Line: 2096
                -- upvalues: u391 (copy), u394 (ref), u393 (copy), workspace_CurrentCamera (ref)
                local v397 = u393(u391.TimePosition * u394);

                if v397 then
                    workspace_CurrentCamera.FieldOfView = v397.Value;
                end;
            end));
        end;

        local u398 = workspace:GetServerTimeNow() + 1;

        local function u399() -- Line: 2108
            -- upvalues: u388 (ref), u390 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u389 (copy)
            if u388 then
                return;
            end;

            u388 = true;
            u390:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;

            for _, v in u389 do
                v:Disconnect();
            end;

            table.clear(u389);
        end;

        if p384 then
            table.insert(u389, p384.AncestryChanged:Once(u399));
        end;

        table.insert(u389, RunService.RenderStepped:connect(function(p400) -- Line: 2128
            -- upvalues: u383 (copy), u390 (copy), u399 (copy), workspace_CurrentCamera (ref), u392 (copy), u398 (copy)
            if not u383 then
                if u390:FindFirstChild("CamPart") then
                    workspace_CurrentCamera.CFrame = u390.CamPart.CFrame;

                    return;
                end;

                u399();

                return;
            end;

            local v401 = tick() - u392 > 1;
            local CFrame3 = u390.CamPart.CFrame;

            if u398 <= workspace:GetServerTimeNow() then
                workspace_CurrentCamera.CFrame = CFrame3;

                return;
            end;

            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v401 and 1 - 9e-25 ^ p400 or 1 - 9e-7 ^ p400);
        end));
        table.insert(u389, u391.Stopped:Once(u399));
        table.insert(u389, p380.Parent.AncestryChanged:Once(u399));

        return u390, u399, u391;
    end;
end;

function u4.cutsceneBlenderNoAnim(p402, p403, u404, p405, p406) -- Line: 2166
    -- upvalues: Players (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), GetSortedFOV (copy), RunService (copy)
    local _ = p402.Parent;
    local Character = Players.LocalPlayer.Character;
    local u407 = false;

    if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
        local _ = Character.HumanoidRootPart;
    end;

    local u408 = {};
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local u409 = ReplicatedStorage.Resources.blenderCam:Clone();
    u409.Parent = p402;
    u409.RootPart.Weld.Part0 = p402;
    u409.RootPart.Weld.C0 = p406 or u409.RootPart.Weld.C0;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u410 = tick();

    if p403 then
        local os_clock_ret = os.clock();
        local u411 = GetSortedFOV(p403);
        table.insert(u408, RunService.PreRender:Connect(function(p412) -- Line: 2200
            -- upvalues: os_clock_ret (copy), u411 (copy), workspace_CurrentCamera (ref)
            local v413 = u411((os.clock() - os_clock_ret) * 60);

            if v413 then
                workspace_CurrentCamera.FieldOfView = v413.Value;
            end;
        end));
    end;

    local u414 = workspace:GetServerTimeNow() + 1;

    local function v415() -- Line: 2212
        -- upvalues: u407 (ref), u409 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u408 (copy)
        if u407 then
            return;
        end;

        u407 = true;
        u409:Destroy();
        workspace_CurrentCamera.FieldOfView = 70;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CFrame = CFrame2;

        for _, v in u408 do
            v:Disconnect();
        end;

        table.clear(u408);
    end;

    if p405 then
        table.insert(u408, p405.AncestryChanged:Once(v415));
    end;

    table.insert(u408, RunService.RenderStepped:connect(function(p416) -- Line: 2232
        -- upvalues: u404 (copy), workspace_CurrentCamera (ref), u409 (copy), u410 (copy), u414 (copy)
        if not u404 then
            workspace_CurrentCamera.CFrame = u409.CamPart.CFrame;

            return;
        end;

        local v417 = tick() - u410 > 1;
        local CFrame3 = u409.CamPart.CFrame;

        if u414 <= workspace:GetServerTimeNow() then
            workspace_CurrentCamera.CFrame = CFrame3;

            return;
        end;

        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v417 and 1 - 9e-25 ^ p416 or 1 - 9e-7 ^ p416);
    end));
    table.insert(u408, u409.Destroying:Once(v415));
    table.insert(u408, p402.Parent.AncestryChanged:Once(v415));

    return u409, v415;
end;

function u4.cutsceneHumanoidCamera(p418: any, p419: userdata, p420: any, u421: any, p422: any, p423: any) -- Line: 2266
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p418.Parent;
    local Character = Players.LocalPlayer.Character;
    local u424 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local u425 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u426 = ReplicatedStorage.Resources.HumanoidCameraRig:Clone();
        u426.Parent = p418;
        u426.RootPart.Weld.Part0 = p418;
        u426.RootPart.Weld.C0 = p423 or u426.RootPart.Weld.C0;
        local u427 = animationUtil:loadAnimation(u426, p419);
        u427:Play(0);
        local _ = u427.Length;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local u428 = tick();

        if p420 then
            local u429 = GetSortedFOV(p420);
            local u430 = 60;
            table.insert(u425, watchFPSattribute(u426, function(p431) -- Line: 2298
                -- upvalues: u430 (ref)
                u430 = p431;
            end));
            table.insert(u425, RunService.PreRender:Connect(function(p432) -- Line: 2301
                -- upvalues: u427 (copy), u430 (ref), u429 (copy), workspace_CurrentCamera (ref)
                local v433 = u429(u427.TimePosition * u430);

                if v433 then
                    workspace_CurrentCamera.FieldOfView = v433.Value;
                end;
            end));
        end;

        local u434 = workspace:GetServerTimeNow() + 1;

        local function v435() -- Line: 2313
            -- upvalues: u424 (ref), u426 (copy), workspace_CurrentCamera (ref), u425 (copy), CFrame2 (copy)
            if u424 then
                return;
            end;

            u424 = true;
            u426:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

            for _, v in u425 do
                v:Disconnect();
            end;

            table.clear(u425);
            workspace_CurrentCamera.CFrame = CFrame2;
        end;

        if p422 then
            table.insert(u425, p422.AncestryChanged:Once(v435));
        end;

        table.insert(u425, RunService.RenderStepped:connect(function(p436) -- Line: 2333
            -- upvalues: u421 (copy), workspace_CurrentCamera (ref), u426 (copy), u428 (copy), u434 (copy)
            if not u421 then
                workspace_CurrentCamera.CFrame = u426.Torso.CFrame;

                return;
            end;

            local v437 = tick() - u428 > 1;
            local CFrame3 = u426.Torso.CFrame;

            if u434 <= workspace:GetServerTimeNow() then
                workspace_CurrentCamera.CFrame = CFrame3;

                return;
            end;

            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:lerp(CFrame3, v437 and 1 - 9e-25 ^ p436 or 1 - 9e-7 ^ p436);
        end));
        table.insert(u425, u427.Stopped:Once(v435));
        table.insert(u425, p418.Parent.AncestryChanged:Once(v435));

        return u426, v435;
    end;
end;

function u4.cutsceneHumanoidCameraWithoutRootTerms(u438: any, p439: userdata, p440: any, p441: any, u442: any, p443: any) -- Line: 2355
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = u438.Parent;
    local Character = Players.LocalPlayer.Character;
    local u444 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        local v445 = Character:FindFirstChildOfClass("Humanoid").RootPart or (Character.PrimaryPart or Character.HumanoidRootPart);
        local u446 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u447 = (p441 or ReplicatedStorage.Resources.HumanoidCameraRig):Clone();
        u447.Parent = u438;
        u447:PivotTo(v445.CFrame * u442);
        local u448 = animationUtil:loadAnimation(u447, p439);
        u448:Play(0);
        local _ = u448.Length;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        tick();

        if p440 then
            local u449 = GetSortedFOV(p440);
            local u450 = 60;
            table.insert(u446, watchFPSattribute(u447, function(p451) -- Line: 2386
                -- upvalues: u450 (ref)
                u450 = p451;
            end));
            table.insert(u446, RunService.PreRender:Connect(function(p452) -- Line: 2389
                -- upvalues: u448 (copy), u450 (ref), u449 (copy), workspace_CurrentCamera (ref)
                local v453 = u449(u448.TimePosition * u450);

                if v453 then
                    workspace_CurrentCamera.FieldOfView = v453.Value;
                end;
            end));
        end;

        table.insert(u446, RunService.PreRender:Connect(function() -- Line: 2398
            -- upvalues: u438 (copy), u447 (copy), u442 (copy)
            if u438 then
                u447:PivotTo(u438.CFrame * u442);
            end;
        end));
        local _ = workspace:GetServerTimeNow() + 1;

        local function v454() -- Line: 2407
            -- upvalues: u444 (ref), u447 (copy), workspace_CurrentCamera (ref), u446 (copy), CFrame2 (copy)
            if u444 then
                return;
            end;

            u444 = true;
            u447:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

            for _, v in u446 do
                v:Disconnect();
            end;

            table.clear(u446);
            workspace_CurrentCamera.CFrame = CFrame2;
        end;

        local u455 = typeof(p443) ~= "string" and "Part" or p443;
        table.insert(u446, RunService.RenderStepped:connect(function(p456) -- Line: 2425
            -- upvalues: workspace_CurrentCamera (ref), u447 (copy), u455 (copy)
            workspace_CurrentCamera.CFrame = u447[u455].CFrame;
        end));
        table.insert(u446, u448.Stopped:Once(v454));
        table.insert(u446, u438.Parent.AncestryChanged:Once(v454));

        return u447, v454;
    end;
end;

function u4.cutsceneCamRigWithLetterBox(p457: userdata, p458: userdata, p459: userdata?, p460: userdata?, p461: any, p462: any, u463: string?, p464: string?) -- Line: 2438
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p457.Parent;
    local Character = Players.LocalPlayer.Character;
    local u465 = false;

    if p464 == "All" or not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local u466 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;

        if p461 == "default" then
            p461 = CFrame.new(0, -3, 0);
        end;

        local u467 = p462 and p462:Clone() or ReplicatedStorage.Resources.CamRigWithLetterBox:Clone();
        u467.Parent = p457;
        local v468 = u467:FindFirstChild("RootPart") or u467.PrimaryPart;

        if v468:FindFirstChild("Weld") then
            v468.Weld.Part0 = p457;

            if p461 then
                v468.Weld.C0 = p461;
            end;

            if v468.Anchored then
                v468.Anchored = false;
            end;
        else
            v468.CFrame = p457.CFrame * (typeof(p461) == "CFrame" and p461 or CFrame.identity);
        end;

        local u469 = animationUtil:loadAnimation(u467, p458);
        u469:Play(0);
        local _ = u469.Length;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        tick();

        if p459 then
            local u470 = GetSortedFOV(p459);
            local u471 = 60;
            table.insert(u466, watchFPSattribute(u467, function(p472) -- Line: 2488
                -- upvalues: u471 (ref)
                u471 = p472;
            end));
            table.insert(u466, RunService.PreRender:Connect(function(p473) -- Line: 2491
                -- upvalues: u469 (copy), u471 (ref), u470 (copy), workspace_CurrentCamera (ref)
                local v474 = u470(u469.TimePosition * u471);

                if v474 then
                    workspace_CurrentCamera.FieldOfView = v474.Value;
                end;
            end));
        end;

        local _ = workspace:GetServerTimeNow() + 1;

        local function u475() -- Line: 2503
            -- upvalues: u465 (ref), u467 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u466 (copy)
            if u465 then
                return;
            end;

            u465 = true;
            u467:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;

            for _, v in u466 do
                v:Disconnect();
            end;

            table.clear(u466);
        end;

        if typeof(u463) ~= "string" then
            u463 = nil;
        end;

        table.insert(u466, RunService.RenderStepped:connect(function(p476) -- Line: 2524
            -- upvalues: u467 (copy), u463 (ref), u475 (copy), u469 (copy), workspace_CurrentCamera (ref)
            if u467:FindFirstChild(u463 or "camera") then
                if u467 or u469.Stopped:Once() then
                    if not u467:GetAttribute("Paused") then
                        workspace_CurrentCamera.CFrame = u467[u463 or "camera"].CFrame;

                        return;
                    end;
                else
                    u475();
                end;

                return;
            end;

            u475();
        end));
        table.insert(u466, u469.Stopped:Once(u475));

        if p460 then
            table.insert(u466, p460.AncestryChanged:Once(u475));
        end;

        table.insert(u466, p457.Parent.AncestryChanged:Once(u475));

        return u467, u475, u469;
    end;
end;

function u4.cutsceneCamRigWithLetterBoxForIdiots(p477: any, p478: userdata, p479: any, p480: userdata, p481: any, p482: any, u483: any) -- Line: 2554
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), animationUtil (copy), GetSortedFOV (copy), watchFPSattribute (copy), RunService (copy)
    local Parent = p477.Parent;
    local Character = Players.LocalPlayer.Character;
    local u484 = false;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        if not (Character:FindFirstChildOfClass("Humanoid").RootPart or Character.PrimaryPart) then
            local _ = Character.HumanoidRootPart;
        end;

        local u485 = {};
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u486 = p482 and p482:Clone() or ReplicatedStorage.Resources.CamRigWithLetterBox:Clone();
        u486.Parent = p477;

        if u486.HumanoidRootPart:FindFirstChild("Weld") then
            u486.HumanoidRootPart.Weld.Part0 = p477;

            if p481 then
                u486.HumanoidRootPart.Weld.C0 = p481;
            end;
        else
            u486.HumanoidRootPart.CFrame = p477.CFrame * (typeof(p481) == "CFrame" and p481 or CFrame.identity);
        end;

        local u487 = animationUtil:loadAnimation(u486, p478);
        u487:Play(0);
        local _ = u487.Length;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        tick();

        if p479 then
            local u488 = GetSortedFOV(p479);
            local u489 = 60;
            table.insert(u485, watchFPSattribute(u486, function(p490) -- Line: 2595
                -- upvalues: u489 (ref)
                u489 = p490;
            end));
            table.insert(u485, RunService.PreRender:Connect(function(p491) -- Line: 2598
                -- upvalues: u487 (copy), u489 (ref), u488 (copy), workspace_CurrentCamera (ref)
                local v492 = u488(u487.TimePosition * u489);

                if v492 then
                    workspace_CurrentCamera.FieldOfView = v492.Value;
                end;
            end));
        end;

        local _ = workspace:GetServerTimeNow() + 1;

        local function u493() -- Line: 2610
            -- upvalues: u484 (ref), u486 (copy), workspace_CurrentCamera (ref), CFrame2 (copy), u485 (copy)
            if u484 then
                return;
            end;

            u484 = true;
            u486:Destroy();
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;

            for _, v in u485 do
                v:Disconnect();
            end;

            table.clear(u485);
        end;

        if typeof(u483) ~= "string" then
            u483 = nil;
        end;

        table.insert(u485, RunService.RenderStepped:connect(function(p494) -- Line: 2631
            -- upvalues: u486 (copy), u483 (ref), u493 (copy), u487 (copy), workspace_CurrentCamera (ref)
            if not u486:FindFirstChild(u483 or "camera") then
                u493();

                return;
            end;

            if u486 or u487.Stopped:Once() then
                workspace_CurrentCamera.CFrame = u486[u483 or "camera"].CFrame;

                return;
            end;

            u493();
        end));
        table.insert(u485, u487.Stopped:Once(u493));

        if p480 then
            table.insert(u485, p480.AncestryChanged:Once(u493));
        end;

        table.insert(u485, p477.Parent.AncestryChanged:Once(u493));

        return u486, u493;
    end;
end;

local u495 = { "ParticleEmitter", "Beam", "Trail", "PointLight", "SpotLight" };

local function enable(p496: any, p497: boolean) -- Line: 2662
    -- upvalues: u495 (copy), enable (copy)
    local v498;

    if typeof(p496) == "Instance" then
        v498 = p496:GetDescendants();
    else
        v498 = p496;
    end;

    local v499 = p497 or false;

    if typeof(p496) == "Instance" and table.find(u495, p496.ClassName) then
        p496.Enabled = v499;
    end;

    for _, v in v498 do
        if typeof(v) == "table" then
            enable(v, v499);
        elseif table.find(u495, v.ClassName) then
            v.Enabled = v499;
        end;
    end;
end;

local function emit(p500) -- Line: 2683
    -- upvalues: emit (copy), enable (copy)
    if typeof(p500) == "Instance" then
        p500 = p500:GetDescendants();
    end;

    for _, v in p500 do
        if typeof(v) == "table" then
            emit(v);
        elseif table.find({ "ParticleEmitter" }, v.ClassName) then
            task.spawn(function() -- Line: 2695
                -- upvalues: v (copy), enable (ref)
                if v:GetAttribute("EmitDelay") then
                    task.wait(v:GetAttribute("EmitDelay"));
                end;

                v:Emit(v:GetAttribute("EmitCount") or (v:GetAttribute("Rate") or v.Rate));

                if v:GetAttribute("EmitDuration") then
                    enable(v, true);
                    task.wait(v:GetAttribute("EmitDuration"));
                    enable(v, false);
                end;
            end);
        end;
    end;
end;

local function get_max_lifetime(p501: userdata) -- Line: 2713
    local v502 = 0;

    for _, descendant in p501:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local Attributes = descendant:GetAttributes();
            local v503 = (descendant.Lifetime.Max + (Attributes.EmitDuration or 0) + (Attributes.EmitDelay or 0)) / descendant.TimeScale;

            if Attributes.Lifetime then
                v503 = math.max(v503, Attributes.Lifetime);
            end;

            if v502 < v503 and v503 < 1000000000 then
                v502 = v503;
            end;
        elseif descendant:IsA("Trail") then
            local Attributes = descendant:GetAttributes();
            local Lifetime = descendant.Lifetime;

            if Attributes.Lifetime then
                Lifetime = math.max(Lifetime, Attributes.Lifetime);
            end;

            if v502 < Lifetime and Lifetime < 1000000000 then
                v502 = Lifetime;
            end;
        end;
    end;

    return v502;
end;

u4.BetterEnable = enable;
u4.BetterEmit = emit;

function u4.EmitAttachmentIn(p504: table) -- Line: 2752
    -- upvalues: Util (copy), LocalPlayer (copy), vfxUtil (copy), emit (copy), get_max_lifetime (copy)
    if shared.allvfxcheck and shared.allvfxcheck() then
        return;
    end;

    local v505 = typeof(p504) == "table";
    assert(v505, "data must be a table");
    local v506 = typeof(p504.Effect) == "Instance";
    assert(v506, "effect must be an insttance");
    local v507 = p504.Effect:Clone();
    v507.CFrame = p504.Offset or v507.CFrame;

    if v507:IsA("BasePart") then
        local Join = v507:FindFirstChild("Join");

        if Join == nil then
            Join = Instance.new("Weld");
            Join.Part1 = v507;
            Join.Parent = v507;
        end;

        Join.Part0 = p504.AttachPart or p504.Parent;
        Join.C0 = p504.Offset or Join.C0;
    end;

    v507.Parent = p504.Parent or workspace.Terrain;

    if p504.Parent and p504.Parent.Parent:FindFirstChildWhichIsA("Humanoid") then
        local Parent = p504.Parent.Parent;

        if Util.canshiftcolor(LocalPlayer, Parent) then
            vfxUtil.LeanTowardsColor(v507, Parent:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Parent:GetAttribute("CustomAlpha") or 0.985);
        end;
    end;

    emit(v507);
    task.delay(get_max_lifetime(v507), v507.Destroy, v507);
end;

function u4.WeldTrail(p508: table) -- Line: 2789
    local v509 = typeof(p508) == "table";
    assert(v509, "data must be a table");
    local v510 = typeof(p508.Character) == "Instance";
    assert(v510, "character must be an instance");
    local v511 = typeof(p508.Trail) == "Instance";
    assert(v511, "must pass a trail");
    local v512 = typeof(p508.Tag) == "string";
    assert(v512, "tag must not be nil");
    local Character = p508.Character;
    local Trail = p508.Trail;
    local Parts = p508.Parts;
    local Tag = p508.Tag;

    for _, v in (Parts == "All" or Parts == nil) and { "Left Arm", "Right Arm", "Left Leg", "Right Leg" } or Parts do
        local v513 = Character:FindFirstChild(v);

        if v513 then
            local v514 = Trail:Clone();
            v514:AddTag(Tag);
            v514.Join.Part0 = v513;
            v514.Parent = workspace.Effects;
        end;
    end;
end;

function u4.DestroyTagged(p515: string) -- Line: 2818
    -- upvalues: CollectionService (copy), enable (copy), get_max_lifetime (copy)
    for _, v in CollectionService:GetTagged(p515) do
        task.spawn(function() -- Line: 2820
            -- upvalues: enable (ref), v (copy), get_max_lifetime (ref)
            enable(v:GetDescendants(), false);
            task.delay(get_max_lifetime(v), v.Destroy, v);
        end);
    end;
end;

function u4.EmitInBall(p516: table) -- Line: 2828
    -- upvalues: emit (copy), get_max_lifetime (copy)
    if shared.allvfxcheck and shared.allvfxcheck() then
        return;
    end;

    local v517 = typeof(p516) == "table";
    assert(v517, "data must be a table");
    local v518 = typeof(p516.Effect) == "Instance";
    assert(v518, "effect must be an insttance");
    local Ball = p516.Character:FindFirstChild("Ball");

    if not Ball then
        return;
    end;

    local v519 = p516.Effect:Clone();
    v519.CFrame = p516.Offset or v519.CFrame;

    if v519:IsA("BasePart") then
        local Join = v519:FindFirstChild("Join");

        if Join == nil then
            Join = Instance.new("Weld");
            Join.Part1 = v519;
            Join.Parent = v519;
        end;

        Join.Part0 = p516.AttachPart or p516.Parent;
        Join.C0 = p516.Offset or Join.C0;
    end;

    v519.Parent = Ball;
    emit(v519);
    task.delay(get_max_lifetime(v519), v519.Destroy, v519);
end;

function u4.rockFlakes(u520, p521, u522) -- Line: 2865
    -- upvalues: RunService (copy), raycast (copy), TweenService (copy), Debris (copy), ReplicatedStorage (copy)
    local l_time = time;
    local u523 = l_time() + 0.085;
    Random.new();
    local u528 = RunService.PreRender:Connect(function() -- Line: 2875
        -- upvalues: l_time (copy), u523 (ref), u520 (copy), u522 (ref), raycast (ref), TweenService (ref), Debris (ref), ReplicatedStorage (ref)
        if l_time and u523 then
            local v524 = l_time();

            if u523 > v524 then
                return;
            end;

            u523 = v524 + 0.085;
        end;

        if not u520:IsDescendantOf(game) then
            return;
        end;

        u522 = u522 or 0.55;
        local v525 = raycast(CFrame.new(u520.Position) * CFrame.new(math.random(-u522 * 4.5, u522 * 4.5), -u522, math.random(-u522 * 4.5, u522 * 4.5)).Position, (Vector3.new(0, -u520.Size.Y * 2, 0)));

        if v525 and v525.Instance.Transparency < 1 then
            local Part = Instance.new("Part");
            Part.CanCollide = false;
            Part.Anchored = true;
            Part.CFrame = CFrame.new(v525.Position);
            Part.Size = Vector3.new(0, 0, 0);
            Part.Parent = workspace.Effects;
            Part.Material = v525.Material;
            Part.MaterialVariant = v525.Instance.MaterialVariant;
            Part.Color = v525.Instance.Color;
            TweenService:Create(Part, TweenInfo.new(0.2), {
                CFrame = CFrame.new(v525.Position) * CFrame.Angles(math.random(0, 180), math.random(0, 180), math.random(0, 180)),
                Size = Vector3.new(u522, u522, u522)
            }):Play();
            task.delay(Random.new():NextNumber(3, 6), function() -- Line: 2912
                -- upvalues: TweenService (ref), Part (copy), Debris (ref)
                TweenService:Create(Part, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Position = Part.Position - Vector3.new(0, Part.Size.Y * 2, 0)
                }):Play();
                Debris:AddItem(Part, 1.5);
            end);
        end;

        local v526 = raycast(u520.Position, Vector3.new(0, 1, 0) * -u520.Size.Y * 2);

        if v526 and v526.Instance.Transparency < 1 then
            local v527 = ReplicatedStorage.Resources.DashSmoke:Clone();
            v527.Parent = workspace.Effects;
            v527.CFrame = CFrame.new(v526.Position);

            for _, descendant in ipairs(v527:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(4);
                    descendant.Color = ColorSequence.new(v526.Instance.Color);
                end;
            end;

            task.delay(3, v527.Destroy, v527);
        end;
    end);
    task.delay(p521, function() -- Line: 2940
        -- upvalues: u528 (copy)
        u528:Disconnect();
    end);

    return u528;
end;

function u4.PlayGlobalSound(p529, p530, p531) -- Line: 2948
    -- upvalues: ReplicatedStorage (copy), u4 (copy)
    local v532 = p530:Clone();
    local v533;

    if p531 then
        v533 = math.min(p531, 0.75);
    else
        v533 = p531;
    end;

    v532.Volume = v533;
    v532.Parent = game:GetService("SoundService");
    v532:Play();

    if p530:IsDescendantOf(ReplicatedStorage.Resources.BrickSounds) then
        u4.cameraShake(p531 and p531 * 1.75 or 1, 3, 8);
    end;

    v532.Ended:Wait();
    pcall(game.Destroy, v532);
end;

function u4.PlaySound(p534, p535, p536) -- Line: 2964
    -- upvalues: ReplicatedStorage (copy), u4 (copy)
    local v537 = p535:Clone();
    v537.Volume = p536 and (math.min(p536, 5) or 1) or 1;
    v537:Play();
    local Part = Instance.new("Part");
    v537.Parent = Part;
    Part.CanCollide = false;
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.Position = p534;
    Part.Size = Vector3.new(0.01, 0.01, 0.01);
    Part.Parent = workspace.Effects;

    if p535:IsDescendantOf(ReplicatedStorage.Resources.BrickSounds) then
        u4.cameraShake(8 * (p536 and p536 * 1.75 or 1), 3, 8, { CFrame.new(p534), 200 });
    end;

    v537.Ended:Wait();
    pcall(game.Destroy, Part);
end;

function u4.soundUtil(p538, p539, p540) -- Line: 2988
    -- upvalues: soundUtil (copy), SoundService (copy)
    soundUtil:play(p538, p539 or SoundService, p540);
end;

function u4.kaisersunraveling(p541) -- Line: 2992
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local u542 = ReplicatedStorage.Resources.kaiser.KAISERSUNRAVELING:Clone();
    u542.Parent = p541.PlayerGui;
    TweenService:Create(u542.ImageLabel, TweenInfo.new(1), {
        ImageTransparency = 1,
        BackgroundTransparency = 1
    }):Play();
    task.delay(1, function() -- Line: 3002
        -- upvalues: u542 (copy)
        u542:Destroy();
    end);
end;

function u4.commentatorLine(p543: string) -- Line: 3008
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), Debris (copy)
    local Commentators = require(ReplicatedStorage.wiki.Commentators);
    local commentators = LocalPlayer:WaitForChild("storage"):WaitForChild("commentators", 5);

    if not commentators then
        print("noo commentatorsss");

        return;
    end;

    local commentator = LocalPlayer:FindFirstChild("commentator");

    if not commentator or commentator.Value == "None" then
        return;
    end;

    local v544 = commentator.Value == "Random";
    local v545 = {};

    if v544 then
        for _, child in commentators:GetChildren() do
            if child:IsA("StringValue") and not table.find({ "Random", "None" }, child.Value) then
                table.insert(v545, child.Value);
            end;
        end;

        if #v545 < 1 then
            print("no unique commentators between random and none");

            return;
        end;
    end;

    local v546 = v544 and v545[math.random(#v545)] or commentator.Value;

    if not Commentators[v546] then
        print((`cant find data for {v546}`));

        return;
    end;

    local v547 = Commentators[v546].Dialogue[p543];

    if not v547 then
        print("no requested data");

        return;
    end;

    local v548 = v547[math.random(#v547)];
    pcall(game.Destroy, PlayerGui:FindFirstChild("CommentatorUI"));
    local u549 = script.Parent.Commentators:Clone();
    u549.Name = "CommentatorUI";
    local CanvasGroup = u549.CanvasGroup;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Frame.CommentatorName.Text = Commentators[v546].Name;
    CanvasGroup.Frame.Dialogue.Text = v548.Dialogue;
    u549.Parent = LocalPlayer.PlayerGui;
    local Icon = CanvasGroup.Frame:FindFirstChild("Icon");
    local u550 = v548.Icon or Commentators[v546].Icon;

    if Icon and (typeof(u550) == "table" and #u550 >= 2) then
        local u551 = 1;
        Icon.Image = u550[u551];
        local u552 = true;
        u549.Destroying:Once(function() -- Line: 3063
            -- upvalues: u552 (ref)
            u552 = false;
        end);
        task.spawn(function() -- Line: 3067
            -- upvalues: u552 (ref), u551 (ref), u550 (copy), Icon (copy)
            while u552 do
                task.wait(0.35 + math.random() * 0.4);

                if not u552 then
                    break;
                end;

                u551 = u551 % #u550 + 1;
                Icon.Image = u550[u551];
            end;
        end);
    elseif Icon then
        Icon.Image = typeof(u550) ~= "string" and "" or u550;
    end;

    TweenService:Create(CanvasGroup, TweenInfo.new(0.25), {
        GroupTransparency = 0
    }):Play();
    local u553 = soundUtil:play(script.Parent.Empty, u549, {
        SoundId = v548.SoundId,
        Volume = v548.Volume
    });

    if not v548.TimeLength then
        task.spawn(function() -- Line: 3093
            -- upvalues: u553 (copy), TweenService (ref), CanvasGroup (copy), Debris (ref), u549 (copy)
            repeat
                task.wait();
            until u553.TimeLength ~= 0;

            task.delay(u553.TimeLength, function() -- Line: 3096
                -- upvalues: TweenService (ref), CanvasGroup (ref)
                TweenService:Create(CanvasGroup, TweenInfo.new(2), {
                    GroupTransparency = 1
                }):Play();
            end);
            Debris:AddItem(u549, u553.TimeLength + 2);
        end);

        return;
    end;

    task.delay(v548.TimeLength, function() -- Line: 3086
        -- upvalues: TweenService (ref), CanvasGroup (copy)
        TweenService:Create(CanvasGroup, TweenInfo.new(0.5), {
            GroupTransparency = 1
        }):Play();
    end);
    Debris:AddItem(u549, v548.TimeLength + 0.5);
end;

function u4.BallBrickFinder(u554) -- Line: 3105
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u4 (copy), RunService (copy)
    local Ball = workspace.Terrain:FindFirstChild("Ball");

    if Ball then
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        RaycastParams_new_ret.FilterDescendantsInstances = { workspace.map.gm1.BrickFrame, workspace.map.gm2.BrickFrame };
        local u555 = nil;
        local u556 = nil;
        local u557 = Ball:GetAttribute("velocity") and (Ball:GetAttribute("velocity").Magnitude / 160 or 1) or 1;
        local u558 = tick();
        local _ = Ball.Position;
        local Children = ReplicatedStorage.Resources.BrickSounds:GetChildren();
        local u559 = Vector3.new(0, 0, 0);
        local u560 = Ball:GetPropertyChangedSignal("CFrame"):Connect(function() -- Line: 3124
            -- upvalues: u558 (ref), u559 (ref), Ball (copy), u557 (ref)
            u558 = tick();
            u559 = Ball:GetAttribute("velocity") or Vector3.new(0, 0, 0);

            if u559 ~= Vector3.new(0, 0, 0) then
                local math_min_ret = math.min(u557 * 6, 30);
                u559 = CFrame.lookAt(Ball.Position, Ball.Position + u559).LookVector * math_min_ret;
            end;
        end);
        u556 = RunService.RenderStepped:Connect(function() -- Line: 3133, Name: stupid
            -- upvalues: Ball (copy), u558 (ref), u557 (ref), u556 (ref), u560 (ref), u555 (ref), u559 (ref), RaycastParams_new_ret (copy), u554 (copy), LocalPlayer (ref), u4 (ref), Children (copy)
            if not (Ball and (tick() - u558 < 0.25 and u557 > 0.01)) then
                u556:Disconnect();
                u560:Disconnect();
                u555:Disconnect();
            end;

            u557 = Ball:GetAttribute("velocity") and Ball:GetAttribute("velocity").Magnitude / 160 or 1;

            if workspace:Raycast(Ball.Position, u559, RaycastParams_new_ret) then
                u556:Disconnect();
                u560:Disconnect();
                u555:Disconnect();

                if u554 == LocalPlayer.Character then
                    u4.commentatorLine("Brick");

                    if LocalPlayer:GetAttribute("style") == "kaiser" then
                        u4.kaisersunraveling(LocalPlayer);
                    end;
                end;

                u4.PlayGlobalSound(Ball.Position, Children[math.random(1, #Children)], (math.min(u557, 2)));
            end;
        end);
        u555 = Ball.Destroying:Once(function() -- Line: 3159
            -- upvalues: u556 (ref), u560 (ref)
            u556:Disconnect();
            u560:Disconnect();
        end);
    end;
end;

function u4.afterImage(p561) -- Line: 3167
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    if not ReplicatedStorage.CLONES:FindFirstChild(p561.Name) then
        return;
    end;

    local v562 = ReplicatedStorage.CLONES[p561.Name];
    p561:FindFirstChildOfClass("Humanoid");
    local v563 = v562:FindFirstChildOfClass("Humanoid");
    v563.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    v563.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v562.Archivable = true;

    for _, child in pairs(p561:GetChildren()) do
        if child.Name ~= "HumanoidRootPart" and child:IsA("Part") then
            local Part = Instance.new("Part");
            Part.CanCollide = false;
            Part.Anchored = true;
            Part.Transparency = 0.5;
            Part.Color = Color3.fromRGB(255, 255, 255);
            Part.CFrame = child.CFrame;
            Part.Size = child.Size;
            Part.Parent = workspace.Effects;
            TweenService:Create(Part, TweenInfo.new(1), {
                Transparency = 1
            }):Play();
            task.delay(1, Part.Destroy, Part);
        end;
    end;
end;

local u564 = {
    All = false,
    OriginCFrame = CFrame.new()
};

function u4.kuronaCam(p565: userdata, p566: userdata?, u567: userdata?, u568: function?, u569: any, p570: any) -- Line: 3254
    -- upvalues: LocalPlayer (copy), vfxUtil (copy), Util (copy), u564 (copy), actionUtil (copy), workspace_CurrentCamera (copy), GetSortedFOV (copy), trove (copy), watchFPSattribute (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local Parent = p565.Parent;
    local u571;

    if p566 then
        u571 = p566:Clone();
    else
        u571 = vfxUtil.getResources().KuronaCam:Clone();
        u571.Name = "Cam";
    end;

    u571.Weld.Part0 = p565;
    u571.Parent = p565;
    local u572 = Util.copy(u564);

    if typeof(p570) == "table" then
        Util.overwrite(u572, p570);

        if p570.OriginCFrame then
            u572.CustomCFrame = true;
        end;
    elseif p570 == "All" then
        u572.All = true;
    end;

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not (actionUtil.checksameTeam(Character, Parent) or u572.All))) then
        task.spawn(function() -- Line: 3282
            -- upvalues: u569 (copy), workspace_CurrentCamera (ref), u572 (copy), u567 (copy), GetSortedFOV (ref), trove (ref), u571 (ref), watchFPSattribute (ref), RunService (ref), u568 (copy)
            local u573 = typeof(u569) == "number" and u569 or 0.1;
            local CFrame2 = workspace_CurrentCamera.CFrame;

            if u572.CustomCFrame then
                CFrame2 = u572.OriginCFrame;
            end;

            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            local u574 = 0;
            local u575 = u567 and GetSortedFOV(u567) or nil;
            local u576 = 60;
            local v577 = trove.new();
            v577:AttachToInstance(u571);
            v577:Add(watchFPSattribute(u571, function(p578) -- Line: 3295
                -- upvalues: u576 (ref)
                u576 = p578;
            end));
            v577:Add(RunService.PreRender:Connect(function(p579) -- Line: 3298
                -- upvalues: u574 (ref), u569 (ref), workspace_CurrentCamera (ref), u571 (ref), u573 (copy), u575 (copy), u576 (ref), u568 (ref)
                u574 = u574 + p579;
                local v580;

                if u569 and u574 < 0.5 then
                    v580 = workspace_CurrentCamera.CFrame:Lerp(u571.CFrame, u573);
                else
                    v580 = nil;
                end;

                workspace_CurrentCamera.CFrame = v580 or u571.CFrame;
                local v581 = u575 and u575(u574 * u576);

                if v581 then
                    workspace_CurrentCamera.FieldOfView = v581.Value;
                end;

                if u568 then
                    pcall(u568);
                end;
            end));
            v577:Add(function() -- Line: 3315
                -- upvalues: workspace_CurrentCamera (ref), CFrame2 (ref)
                workspace_CurrentCamera.CFrame = CFrame2;
                workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
                workspace_CurrentCamera.FieldOfView = 70;
            end);
        end);
    end;

    return u571;
end;

function u4.kuronaCamToAll(p582: userdata, p583: userdata?, u584: userdata?, u585: function?) -- Line: 3325
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), GetSortedFOV (copy), RunService (copy)
    local _ = LocalPlayer.Character;
    local _ = p582.Parent;
    local u586 = (p583 or ReplicatedStorage.Resources.KuronaCam):Clone();
    (u586:FindFirstChild("Weld") or u586:FindFirstChildWhichIsA("Motor6D")).Part0 = p582;
    u586.Name = "Cam";
    u586.Parent = p582;
    task.spawn(function() -- Line: 3338
        -- upvalues: workspace_CurrentCamera (ref), u584 (copy), GetSortedFOV (ref), u586 (copy), u585 (copy), RunService (ref)
        local CFrame2 = workspace_CurrentCamera.CFrame;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local v587 = u584 and GetSortedFOV(u584) or nil;
        local v588 = 0;
        local u589 = 60;
        local u590 = u586;

        local function u592(p591) -- Line: 3344
            -- upvalues: u589 (ref)
            u589 = p591;
        end;

        local v593 = u590:GetAttributeChangedSignal("FPS"):Connect(function() -- Line: 1275
            -- upvalues: u592 (copy), u590 (copy)
            u592(u590:GetAttribute("FPS") or 60);
        end);

        while u586:IsDescendantOf(workspace) do
            workspace_CurrentCamera.CFrame = u586.CFrame;
            local v594 = v587 and v587(v588 * u589);

            if v594 then
                workspace_CurrentCamera.FieldOfView = v594.Value;
            end;

            if u585 then
                pcall(u585);
            end;

            v588 = v588 + RunService.RenderStepped:Wait();
        end;

        v593:Disconnect();
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CFrame = CFrame2;
        workspace_CurrentCamera.FieldOfView = 70;
    end);

    return u586;
end;

function u4.makeitacam(p595: userdata, u596: userdata?, u597: userdata?, u598: function?) -- Line: 3368
    -- upvalues: LocalPlayer (copy), workspace_CurrentCamera (copy), GetSortedFOV (copy), RunService (copy)
    local _ = LocalPlayer.Character;
    local _ = p595.Parent;
    task.spawn(function() -- Line: 3372
        -- upvalues: workspace_CurrentCamera (ref), u597 (copy), GetSortedFOV (ref), u596 (copy), u598 (copy), RunService (ref)
        local CFrame2 = workspace_CurrentCamera.CFrame;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local v599 = u597 and GetSortedFOV(u597) or nil;
        local v600 = 0;
        local u601 = 60;
        local u602 = u596;

        local function u604(p603) -- Line: 3378
            -- upvalues: u601 (ref)
            u601 = p603;
        end;

        local v605 = u602:GetAttributeChangedSignal("FPS"):Connect(function() -- Line: 1275
            -- upvalues: u604 (copy), u602 (copy)
            u604(u602:GetAttribute("FPS") or 60);
        end);

        while u596:IsDescendantOf(workspace) do
            workspace_CurrentCamera.CFrame = u596.CFrame;
            local v606 = v599 and v599(v600 * u601);

            if v606 then
                workspace_CurrentCamera.FieldOfView = v606.Value;
            end;

            if u598 then
                pcall(u598);
            end;

            v600 = v600 + RunService.RenderStepped:Wait();
        end;

        v605:Disconnect();
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CFrame = CFrame2;
        workspace_CurrentCamera.FieldOfView = 70;
    end);
end;

function u4.kuronaCamButRig(p607: userdata, u608: userdata, p609: string?, u610: userdata?, u611: function?) -- Line: 3401
    -- upvalues: LocalPlayer (copy), actionUtil (copy), workspace_CurrentCamera (copy), GetSortedFOV (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local Parent = p607.Parent;
    local u612 = u608:FindFirstChild(p609 or "Cam");

    if not (actionUtil.checkGK(Character) and (Character ~= Parent and not actionUtil.checksameTeam(Character, Parent))) then
        task.spawn(function() -- Line: 3406
            -- upvalues: workspace_CurrentCamera (ref), u610 (copy), GetSortedFOV (ref), u612 (copy), u608 (copy), u611 (copy), RunService (ref)
            local CFrame2 = workspace_CurrentCamera.CFrame;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            local v613 = u610 and GetSortedFOV(u610) or nil;
            local v614 = 0;
            local u615 = 60;
            local u616 = u612;

            local function u618(p617) -- Line: 3412
                -- upvalues: u615 (ref)
                u615 = p617;
            end;

            local v619 = u616:GetAttributeChangedSignal("FPS"):Connect(function() -- Line: 1275
                -- upvalues: u618 (copy), u616 (copy)
                u618(u616:GetAttribute("FPS") or 60);
            end);

            while u608:IsDescendantOf(workspace) do
                workspace_CurrentCamera.CFrame = u612.CFrame;
                local v620 = v613 and v613(v614 * u615);

                if v620 then
                    workspace_CurrentCamera.FieldOfView = v620.Value;
                end;

                if u611 then
                    pcall(u611);
                end;

                v614 = v614 + RunService.RenderStepped:Wait();
            end;

            v619:Disconnect();
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;
            workspace_CurrentCamera.FieldOfView = 70;
        end);
    end;

    return u608;
end;

local function fixName(p621: string) -- Line: 3437
    -- upvalues: LocalPlayer (copy)
    return p621:gsub("{username}", LocalPlayer.Name):gsub("{displayname}", LocalPlayer.DisplayName);
end;

local function editButton(p622, p623) -- Line: 3441
    -- upvalues: LocalPlayer (copy), TweenService (copy)
    p622.Visible = true;
    local v624, v625;

    if typeof(p623) == "table" then
        v624 = p623[1];
        v625 = p623[2];
    else
        v624 = p623;
        v625 = nil;
    end;

    local v626 = false;

    if v624 then
        local v627 = v624:gsub("{username}", LocalPlayer.Name):gsub("{displayname}", LocalPlayer.DisplayName);

        if p622.Base.ToolName.Text ~= v627 then
            p622.Base.ToolName.Text = v627;
            v626 = true;
        end;
    end;

    p622:SetAttribute("HoldInput", v625 == "Hold");
    local Reuse = p622.Base.Reuse;
    Reuse.Visible = v625 ~= nil;

    if Reuse.Visible and Reuse.Text ~= v625 then
        Reuse.Text = v625;
        v626 = true;
    end;

    if v626 then
        local UIStroke = Instance.new("UIStroke");
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Color = Color3.new(1, 1, 1);
        UIStroke.Thickness = 2;
        UIStroke.Parent = p622;
        local v628 = TweenService:Create(UIStroke, TweenInfo.new(0.4), {
            Thickness = 0,
            Transparency = 1
        });
        v628:Play();
        v628.Completed:Once(function() -- Line: 3477
            -- upvalues: UIStroke (copy)
            UIStroke:Destroy();
        end);
    end;
end;

local GamepadContainer = require(ReplicatedStorage.client.GamepadContainer);

local function getGamepadButtonName(p629) -- Line: 3485
    -- upvalues: UserInputService (copy)
    return UserInputService:GetStringForKeyCode(p629):gsub("^Button", "");
end;

local u630 = {
    One = 1,
    Two = 2,
    Three = 3,
    Four = 4,
    Five = 5,
    Six = 6,
    Seven = 7,
    Eight = 8,
    Nine = 9,
    Zero = 0
};

local function getMoveNumber(p631, p632) -- Line: 3502
    -- upvalues: GamepadContainer (copy), UserInputService (copy), u630 (copy)
    if typeof(p632) ~= "number" then
        return "";
    end;

    local v633 = p631.isGamepad and UserInputService:GetStringForKeyCode(GamepadContainer[p632].KeyCode):gsub("^Button", "") or (p631.isTouchEnabled and p632 and p632 or p631.setting.customKeybinds[`skill{p632}`].Value);
    local v634 = u630[tostring(v633)] or v633;

    return tostring(v634);
end;

function u4.isHoldSpecial() -- Line: 3511
    -- upvalues: PlayerGui (copy)
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");

    if Hotbar then
        Hotbar = Hotbar.Backpack.Hotbar:FindFirstChild("Tspecialer");
    end;

    if Hotbar then
        Hotbar = Hotbar:GetAttribute("HoldInput") == true;
    end;

    return Hotbar;
end;

function u4.bindHoldButton(u635, u636) -- Line: 3517
    -- upvalues: trove (copy), UserInputService (copy)
    local v637 = trove.new();
    v637:AttachToInstance(u635);
    local u638 = nil;

    local function release() -- Line: 3521
        -- upvalues: u638 (ref), u636 (copy), u635 (copy)
        if u638 then
            u638 = nil;
            u636:senduse({ u635.Name, false });
        end;
    end;

    v637:Add(u635.Base.InputBegan:Connect(function(p639) -- Line: 3527
        -- upvalues: u635 (copy), u638 (ref), u636 (copy)
        if not u635:GetAttribute("HoldInput") or u638 then
            return;
        end;

        if p639.UserInputType ~= Enum.UserInputType.MouseButton1 and p639.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        u638 = p639;
        u636:use(u635.Name);
    end));
    v637:Add(UserInputService.InputEnded:Connect(function(p640) -- Line: 3537
        -- upvalues: u638 (ref), u636 (copy), u635 (copy)
        if p640 == u638 and u638 then
            u638 = nil;
            u636:senduse({ u635.Name, false });
        end;
    end));
    v637:Add(UserInputService.WindowFocusReleased:Connect(release));
    v637:Add(release);
end;

function u4.chargeCooldown(p641: string, p642: number) -- Line: 3546
    -- upvalues: PlayerGui (copy), TweenService (copy)
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");

    if Hotbar then
        Hotbar = Hotbar.Backpack.Hotbar:FindFirstChild(p641);
    end;

    if not Hotbar then
        return;
    end;

    local Charge = Hotbar:FindFirstChild("Charge");

    if p642 < 0 then
        if Charge then
            Charge:Destroy();
        end;

        return;
    end;

    if not Charge then
        Charge = Hotbar.Cooldown:Clone();
        Charge.Name = "Charge";
        Charge.BackgroundColor3 = Color3.fromRGB(255, 213, 50);
        Charge.Size = UDim2.new(1, 0, 0, 0);
        Charge.Parent = Hotbar;
    end;

    Charge.Visible = true;
    TweenService:Create(Charge, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, -math.clamp(p642, 0, 1), 0)
    }):Play();
end;

local function handleButton(p643, p644, p645, p646) -- Line: 3570
    -- upvalues: editButton (copy), PlayerGui (copy), vfxUtil (copy), ReplicatedStorage (copy), getMoveNumber (copy), u4 (copy)
    local v647 = p643 == "[kill slot]";

    if not p644 then
        if not v647 then
            local Hotbar = PlayerGui.Hotbar;
            local _ = Hotbar.Backpack.Hotbar;
            local metatable = vfxUtil.cache_module(ReplicatedStorage.client.starterPlayer).metatable;
            local u648 = Hotbar.Base:Clone();
            u648.Name = p645;
            local v649 = getMoveNumber(metatable, p646);
            local Number = u648.Base.Number;
            Number.Text = v649;
            Number.TextSize = Number.TextSize * (#v649 == 1 and 1.25 or 1);
            u648.LayoutOrder = p646 or 67;
            editButton(u648, p643);

            if p645 == "Tspecialer" then
                u648.Size = UDim2.fromOffset(50, 50);
            end;

            u648.Parent = Hotbar.Backpack.Hotbar;
            u4.bindHoldButton(u648, metatable.baseClient);
            u648.Base.MouseButton1Click:connect(function(p650) -- Line: 3603
                -- upvalues: u648 (copy), metatable (copy)
                if u648:GetAttribute("HoldInput") then
                    return;
                end;

                if not shared.AwaitingUnholdForMobile[u648.Name] then
                    metatable.baseClient:use(u648.Name);

                    return;
                end;

                shared.AwaitingUnholdForMobile[u648.Name] = nil;
                metatable.baseClient:senduse({ u648.Name, false });
            end);
        end;

        return;
    end;

    if v647 then
        p644:Destroy();

        return;
    end;

    editButton(p644, p643);
end;

function u4.LoadMoveset(p651) -- Line: 3617
    shared.customMoveset = p651;
end;

local u652 = nil;

function u4.editMoveset(p653, p654, p655) -- Line: 3624
    -- upvalues: LocalPlayer (copy), PlayerGui (copy), u652 (ref), handleButton (copy)
    local v656 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("Gubby") and "Gun" or p654;
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");

    if not Hotbar or Hotbar:GetAttribute("MovesetReady") == false then
        if not u652 or u652.character ~= LocalPlayer.Character then
            u652 = {
                character = LocalPlayer.Character
            };
        end;

        if typeof(p653) == "table" then
            u652.newMoves = u652.newMoves or {};

            for i, v in p653 do
                u652.newMoves[i] = v;
            end;
        end;

        u652.tspecial = v656 or u652.tspecial;
        u652.awakenText = p655 or u652.awakenText;

        return;
    end;

    u652 = nil;
    local Hotbar2 = Hotbar.Backpack.Hotbar;
    local MagicHealth = Hotbar.MagicHealth;

    if typeof(p653) == "table" then
        for i = 1, 5 do
            local v657 = p653[i];
            local v658 = `skill{i}`;
            local v659;

            if v657 then
                handleButton(v657, Hotbar2:FindFirstChild(v658), v658, i);
                v659 = i;
            else
                v659 = i;
            end;
        end;
    end;

    if v656 then
        handleButton(v656, Hotbar2:FindFirstChild("Tspecialer"), "Tspecialer", nil);
    end;

    if p655 then
        MagicHealth.TextLabel.Visible = true;
        MagicHealth.TextLabel.Text = p655;
    end;
end;

function u4.applyPendingMoveset() -- Line: 3667
    -- upvalues: u652 (ref), LocalPlayer (copy), u4 (copy)
    local v660 = u652;
    u652 = nil;

    if v660 and v660.character == LocalPlayer.Character then
        u4.editMoveset(v660.newMoves, v660.tspecial, v660.awakenText);
    end;
end;

function u4.recolorMoveset(p661) -- Line: 3675
    -- upvalues: PlayerGui (copy)
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");

    if not Hotbar then
        return;
    end;

    local Hotbar2 = Hotbar.Backpack.Hotbar;

    for i, v in p661 do
        local v662;

        if typeof(i) == "number" then
            v662 = Hotbar2:FindFirstChild((`skill{i}`));
        else
            v662 = Hotbar2:FindFirstChild(i);
        end;

        if v662 then
            v662.Base.BackgroundColor3 = typeof(v) == "Color3" and v and v or Color3.fromRGB(31, 31, 31);
        end;
    end;
end;

local function getColorSequence(p663) -- Line: 3692
    local v664 = nil;

    if typeof(p663) == "table" then
        local v665 = #p663;

        if v665 > 1 then
            v664 = {};

            for i, v in ipairs(p663) do
                table.insert(v664, ColorSequenceKeypoint.new((i - 1) / (v665 - 1), v));
            end;
        elseif v665 == 1 then
            v664 = p663[1];
        end;
    elseif typeof(p663) == "Color3" then
        v664 = p663;
    end;

    local v666 = v664 or Color3.new(1, 1, 1);

    return ColorSequence.new(v666);
end;

local function getSpeakInfo(p667: userdata, p668: userdata) -- Line: 3711
    -- upvalues: ReplicatedStorage (copy), getColorSequence (copy)
    local v669 = require(ReplicatedStorage.wiki.styles)[p668:GetAttribute("style")];

    if not v669 then
        return {
            Text = ""
        };
    end;

    local Value = p667.Value;

    if p667:GetAttribute("spaceAfter") then
        Value = `{Value} `;
    end;

    local v670 = {
        Text = Value,
        TextStrokeColor = p667:GetAttribute("StrokeColor") or Color3.new(0, 0, 0),
        Bold = p667:GetAttribute("Bold") == true,
        Italic = p667:GetAttribute("Italic") == true
    };

    if p667:FindFirstChild("Color") then
        local v671 = {};

        for i = 1, #p667.Color:GetChildren() do
            local v672 = p667.Color:FindFirstChild(i);
            local v673;

            if v672 then
                table.insert(v671, v672.Value);
                v673 = i;
            else
                v673 = i;
            end;
        end;

        v670.Color = getColorSequence(v671);
    else
        v670.Color = ColorSequence.new(v669.color or Color3.new(0, 0, 0), Color3.new(1, 1, 1));
    end;

    if p667:FindFirstChild("Shake") then
        v670.Shake = {
            Enabled = p667.Shake.Value,
            Intensity = p667.Shake:GetAttribute("Intensity") or 1,
            Lifetime = p667.Shake:GetAttribute("Lifetime") or 1
        };
    end;

    return v670;
end;

local function getVoiceDialogue(p674: userdata, p675: userdata) -- Line: 3747
    -- upvalues: ReplicatedStorage (copy), getColorSequence (copy), getSpeakInfo (copy)
    local v676 = {};
    local Dialogue = p674:FindFirstChild("Dialogue");

    if Dialogue and Dialogue:IsA("ModuleScript") then
        local v677 = require(Dialogue);

        for i, v in ipairs(v677) do
            local v678 = v.delay or 0;
            local v679 = {};

            for _, v2 in ipairs(v.dialogue or {}) do
                local v680 = require(ReplicatedStorage.wiki.styles)[p675:GetAttribute("style")];
                local v681 = {
                    Text = v2.text or "",
                    TextStrokeColor = v2.strokeColor or Color3.new(0, 0, 0),
                    Bold = v2.bold == true,
                    Italic = v2.italic == true
                };

                if v2.color then
                    v681.Color = getColorSequence(v2.color);
                elseif v680 then
                    v681.Color = ColorSequence.new(v680.color or Color3.new(0, 0, 0), Color3.new(1, 1, 1));
                else
                    v681.Color = ColorSequence.new(Color3.new(1, 1, 1));
                end;

                if v2.typespeed then
                    v681.TypeSpeed = v2.typespeed;
                end;

                if v2.shake then
                    v681.Shake = {
                        Enabled = v2.shake.enabled,
                        Intensity = v2.shake.intensity or 1,
                        Lifetime = v2.shake.lifetime or 1
                    };
                end;

                table.insert(v679, v681);
            end;

            if not p674.IsLoaded then
                p674.Loaded:Wait();
            end;

            local _ = p674.TimeLength;
            table.insert(v676, {
                v678,
                { p675, v679, p674.TimeLength - (v678 - (i == #v677 and 0 or 0.2)) }
            });
        end;
    elseif Dialogue and Dialogue:IsA("Folder") then
        local Children = Dialogue:GetChildren();

        for i, v in ipairs(Children) do
            local v682 = tonumber(v.Name) or 0;
            local v683 = {};
            local v684 = getSpeakInfo(v, p675);

            if v684 then
                table.insert(v683, v684);
            end;

            local v685 = {};

            for _, child in ipairs(v:GetChildren()) do
                if child.Name:sub(1, 6) == "extra." then
                    local v686 = tonumber(child.Name:sub(7, -1));

                    if v686 then
                        table.insert(v685, { child, v686 });
                    end;
                end;
            end;

            table.sort(v685, function(p687, p688) -- Line: 3808
                return p687[2] < p688[2];
            end);

            for _, v2 in ipairs(v685) do
                local v689 = getSpeakInfo(v2[1], p675);
                table.insert(v683, v689);
            end;

            if not p674.IsLoaded then
                p674.Loaded:Wait();
            end;

            print((`"{v683}": {p674.TimeLength}`));
            table.insert(v676, {
                v682,
                { p675, v683, p674.TimeLength - (v682 - (i == #Children and 0 or 0.2)) }
            });
        end;
    end;

    table.sort(v676, function(p690, p691) -- Line: 3823
        return p690[1] > p691[1];
    end);

    return v676;
end;

function u4.localvoice(p692: string, p693: any, u694: boolean?) -- Line: 3869
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), SoundService (copy), soundUtil (copy), getVoiceDialogue (copy), trove (copy), RunService (copy), TekrinnDialogue (copy)
    local v695 = p693 or LocalPlayer;
    local Character = v695.Character;
    local Attribute = v695:GetAttribute("style");

    if not Attribute then
        return;
    end;

    local v696 = ReplicatedStorage.Resources:FindFirstChild(Attribute);

    if not v696 then
        return;
    end;

    local Voicelines = v696:FindFirstChild("Voicelines");

    if not Voicelines then
        return;
    end;

    local u697 = Voicelines:FindFirstChild(p692);

    if not u697 then
        return;
    end;

    if Attribute == "exe" and (p692 == "fight" or (p692 == "rules" or (p692 == "dare" or p692 == "fate"))) then
        local Children = Voicelines.moreExeVoicelines:GetChildren();
        table.insert(Children, u697);
        u697 = Children[math.random(#Children)];
    elseif not u697:IsA("Sound") then
        u697 = u697:GetChildren()[math.random(#u697:GetChildren())];
    end;

    if not u697 then
        return;
    end;

    pcall(game.Destroy, SoundService:FindFirstChild("StyleVoice"));
    local disabled = ReplicatedStorage.workspace.disabled;
    local u698 = soundUtil:play(u697, SoundService, {
        Name = "StyleVoice",
        Character = Character
    });
    u698.Playing = u694 or not disabled.Value;
    local u699 = 0;
    local u700 = getVoiceDialogue(u698, v695);
    local u701 = trove.new();
    u701:AttachToInstance(u698);
    u701:AttachToInstance(Character);
    u701:Add(u698);
    u701:Add(RunService.Heartbeat:Connect(function(p702) -- Line: 3909
        -- upvalues: Character (copy), u701 (copy), u694 (copy), disabled (copy), u698 (copy), u699 (ref), u697 (ref), u700 (copy), TekrinnDialogue (ref)
        if not (Character and Character:IsDescendantOf(workspace)) then
            u701:Destroy();

            return;
        end;

        if not u694 then
            if disabled.Value then
                if u698.Playing == disabled.Value then
                    u698.Playing = not disabled.Value;
                end;

                return;
            end;

            if u698.Playing == disabled.Value then
                u698.Playing = not disabled.Value;
                u698.TimePosition = u699;
            end;
        end;

        u699 = u699 + p702;

        if u699 >= u697.TimeLength then
            u701:Destroy();

            return;
        end;

        for i = #u700, 1, -1 do
            local v703 = u700[i];

            if u699 < v703[1] then
                break;
            end;

            TekrinnDialogue.Speak(table.unpack(v703[2]));
            table.remove(u700, i);
            local _ = i;
        end;
    end));
end;

function u4.EnableMapLights(p704: boolean) -- Line: 3939
    for _, descendant in workspace:FindFirstChild("map"):GetDescendants() do
        if descendant:IsA("PointLight") then
            if not descendant:GetAttribute("originalstatus") then
                descendant:SetAttribute("originalstatus", descendant.Enabled);
            end;

            if descendant:GetAttribute("originalstatus") == true then
                descendant.Enabled = p704;
            end;
        end;
    end;
end;

function u4.stadiumLights(p705: boolean) -- Line: 3953
    local Light = workspace.map.map:FindFirstChild("Light");

    if Light then
        for _, descendant in Light:GetDescendants() do
            local v706 = descendant:IsA("ParticleEmitter");

            if descendant:IsA("Beam") or v706 then
                descendant.Enabled = p705;

                if v706 and not p705 then
                    descendant:Clear();
                end;
            end;
        end;
    end;
end;

function u4.biggershockwave(p707) -- Line: 3968
    -- upvalues: u4 (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    if shared.allvfxcheck and shared.allvfxcheck() then
        return;
    end;

    u4.Emit(p707, ReplicatedStorage.Resources.PunchImpact2, 3);
    local v708 = ReplicatedStorage.Resources.Cylinder:Clone();
    v708.Parent = workspace.Effects;
    v708.CFrame = p707.CFrame;
    TweenService:Create(v708, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(50, 50, 150),
        CFrame = v708.CFrame * CFrame.new(0, 0, -65) * CFrame.Angles(0, 0, -3.141592653589793)
    }):Play();
    Debris:AddItem(v708, 1);
end;

return u4;