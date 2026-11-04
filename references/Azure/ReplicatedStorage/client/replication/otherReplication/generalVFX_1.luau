 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local Resources = vfxUtil.getResources();
local u1 = {};

local function addAmbience(p2, p3, p4) -- Line: 11
    if p4 then
        if game.Workspace.map.something:FindFirstChild("Ambience") then
            game.Workspace.map.something.Ambience:Destroy();
        end;

        if not p2 then
            return;
        end;
    end;

    local v5 = p3:Clone(p2);

    if workspace:GetAttribute("chaos") then
        v5.Size = v5.Size * Vector3.new(2.2, 1, 2.2);
    end;

    v5.Name = "Ambience";
    v5.Parent = game.Workspace.map.something;

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;
end;

function u1.makeFlowSpotlight(u6: any, p7: userdata) -- Line: 33
    -- upvalues: ReplicatedStorage (copy), vfxUtil (copy), trove (copy), u1 (copy), addAmbience (copy), Resources (copy), TweenService (copy)
    local disabled = ReplicatedStorage.workspace.disabled;
    local Root = vfxUtil.getRoot(u6);
    local u8 = trove.new();
    u8:AttachToInstance(u6);
    u1.destroyFlowSpotlight(u6);

    if p7 then
        addAmbience(p7, u8);
    end;

    local u9 = Resources.SpotlightPart:Clone();
    u9.Weld.Part0 = Root;
    u9.Parent = u6;
    local SpotLight = u9.SpotlightPart.SpotLight;
    SpotLight.Enabled = not disabled.Value;
    SpotLight.Brightness = u9:GetAttribute("Brightness") or 2;
    u8:Add(disabled.Changed:Connect(function(p10) -- Line: 54
        -- upvalues: SpotLight (copy)
        SpotLight.Enabled = not p10;
    end));
    u8:Add(function() -- Line: 58
        -- upvalues: u9 (copy), TweenService (ref), SpotLight (copy)
        u9:SetAttribute("Dying", true);
        local v11 = TweenService:Create(SpotLight, TweenInfo.new(2), {
            Brightness = 0
        });
        v11:Play();
        task.delay(v11.TweenInfo.Time, function() -- Line: 64
            -- upvalues: u9 (ref)
            u9:Destroy();
        end);
    end);

    if u6:GetAttribute("FlowActive") then
        u8:Add(u6:GetAttributeChangedSignal("FlowActive"):Connect(function() -- Line: 70
            -- upvalues: u6 (copy), u8 (copy)
            if not u6:GetAttribute("FlowActive") then
                u8:Destroy();
            end;
        end));

        return;
    end;

    u8:Destroy();
end;

function u1.destroyFlowSpotlight(p12) -- Line: 80
    pcall(game.Destroy, p12:FindFirstChild("SpotlightPart"));

    if game.Workspace.map.something:FindFirstChild("Ambience") then
        game.Workspace.map.something.Ambience:Destroy();
    end;
end;

local u13 = nil;

function u1.slenderman() -- Line: 89
    -- upvalues: ReplicatedStorage (copy), u13 (ref), trove (copy)
    if require(ReplicatedStorage.util.Util).isepilepsysafe() then
        return;
    end;

    if u13 then
        u13:Destroy();
    end;

    local u14 = trove.new();
    u13 = u14;
    local u15 = u14:Add(Instance.new("ScreenGui"));
    u15.Name = "Slenderman";
    u15.IgnoreGuiInset = true;
    u15.ScreenInsets = Enum.ScreenInsets.None;
    u15.DisplayOrder = 2147483647;
    u15.ResetOnSpawn = false;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BorderSizePixel = 0;
    Frame.Parent = u15;
    local VideoFrame = Instance.new("VideoFrame");
    VideoFrame.Size = UDim2.fromScale(1, 1);
    VideoFrame.BackgroundTransparency = 1;
    VideoFrame.Video = "rbxassetid://137677171199359";
    VideoFrame.Volume = 0;
    VideoFrame.Looped = false;
    VideoFrame.Parent = Frame;
    local u16 = u14:Add(Instance.new("Sound"));
    u16.Name = "SlendermanAudio";
    u16.SoundId = "rbxassetid://75999618858981";
    u16.Looped = false;
    u16.Parent = game:GetService("SoundService");
    u15.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");

    local function finish() -- Line: 130
        -- upvalues: u13 (ref), u14 (copy)
        if u13 == u14 then
            u13 = nil;
        end;

        u14:Destroy();
    end;

    task.spawn(function() -- Line: 137
        -- upvalues: VideoFrame (copy), u16 (copy), u15 (copy), u13 (ref), u14 (copy), finish (copy)
        local v17 = os.clock() + 10;

        while not (VideoFrame.IsLoaded and u16.IsLoaded or (os.clock() >= v17 or not u15.Parent)) do
            task.wait();
        end;

        if u13 ~= u14 or not u15.Parent then
            return;
        end;

        VideoFrame:Play();
        u16:Play();
        local math_max_ret = math.max(VideoFrame.TimeLength, u16.TimeLength);
        task.delay((math_max_ret <= 0 and 15 or math_max_ret) + 0.25, finish);
    end);
end;

return u1;