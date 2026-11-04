 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ContentProvider = game:GetService("ContentProvider");
local u1 = require("@game/ReplicatedStorage/util/vfxUtil");
local u2 = require("@game/ReplicatedStorage/util/animationUtil");
local u3 = require("@game/ReplicatedStorage/util/soundUtil");
local u4 = require("@game/ReplicatedStorage/util/MoonPropertyAnimator");
local u5 = require("@game/ReplicatedStorage/forum/trove");
local LocalPlayer = Players.LocalPlayer;
local u6 = {
    MoonAnimatorEffects = true
};
local v7 = {};
task.spawn(function() -- Line: 21
    -- upvalues: u1 (copy), ContentProvider (copy)
    ContentProvider:PreloadAsync({ (u1.getResources():WaitForChild("MatchIntros")) });
end);

local function hide_ui(p8) -- Line: 26
    -- upvalues: LocalPlayer (copy), u6 (copy)
    for _, child in LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("ScreenGui") and (child.Enabled and not u6[child.Name]) then
            child.Enabled = false;
            p8:Add(function() -- Line: 30
                -- upvalues: child (copy)
                child.Enabled = true;
            end);
        end;
    end;
end;

local function new_blackout() -- Line: 37
    -- upvalues: LocalPlayer (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "MatchIntroFade";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 1000;
    ScreenGui.ResetOnSpawn = false;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    ScreenGui.Parent = LocalPlayer.PlayerGui;

    return ScreenGui, Frame;
end;

local function dress_rig(p9: userdata, p10: userdata) -- Line: 55
    for _, child in p9:GetChildren() do
        if child:IsA("Accessory") or (child:IsA("Clothing") or (child:IsA("ShirtGraphic") or (child:IsA("CharacterMesh") or child:IsA("BodyColors")))) then
            child:Destroy();
        end;
    end;

    for _, child in p10:GetChildren() do
        if child:IsA("Accessory") then
            local v11 = child:Clone();
            local Handle = v11:FindFirstChild("Handle");
            local v12;

            if Handle then
                v12 = Handle:FindFirstChildOfClass("Attachment");
            else
                v12 = Handle;
            end;

            local v13;

            if v12 then
                v13 = p9:FindFirstChild(v12.Name, true);
            else
                v13 = v12;
            end;

            if v13 then
                for _, child2 in Handle:GetChildren() do
                    if child2:IsA("JointInstance") then
                        child2:Destroy();
                    end;
                end;

                local Weld = Instance.new("Weld");
                Weld.Part0 = Handle;
                Weld.Part1 = v13.Parent;
                Weld.C0 = v12.CFrame;
                Weld.C1 = v13.CFrame;
                Weld.Parent = Handle;
                v11.Parent = p9;
            end;
        elseif child:IsA("Clothing") or (child:IsA("ShirtGraphic") or child:IsA("CharacterMesh")) then
            child:Clone().Parent = p9;
        elseif child:IsA("BasePart") then
            local v14 = p9:FindFirstChild(child.Name);

            if v14 and v14:IsA("BasePart") then
                v14.Color = child.Color;
            end;
        end;
    end;

    local Head = p9.Head;
    local v15 = p10.Head:Clone();

    for _, child in v15:GetChildren() do
        if child:IsA("Decal") then
            child.Transparency = 0;
        elseif not (child:IsA("DataModelMesh") or (child:IsA("FaceControls") or child:IsA("SurfaceAppearance"))) then
            child:Destroy();
        end;
    end;

    v15.Name = "HeadCopy";
    v15.Anchored = false;
    v15.CanCollide = false;
    v15.CanQuery = false;
    v15.CanTouch = false;
    v15.Massless = true;
    v15.Transparency = Head.Transparency;
    v15.CFrame = Head.CFrame;
    local Weld = Instance.new("Weld");
    Weld.Part0 = Head;
    Weld.Part1 = v15;
    Weld.Parent = v15;
    v15.Parent = p9;
    Head.Transparency = 1;

    for _, child in Head:GetChildren() do
        if child:IsA("Decal") then
            child.Transparency = 1;
        end;
    end;
end;

local function build_scene(p16: userdata, p17, p18: any) -- Line: 124
    -- upvalues: LocalPlayer (copy)
    local v19 = {};
    local v20 = {};

    for _, descendant in p16:GetDescendants() do
        if descendant:IsA("Model") and (descendant:FindFirstChildOfClass("Humanoid") or descendant:FindFirstChildOfClass("AnimationController")) then
            v19[descendant.Name] = descendant;
        elseif descendant:IsA("SurfaceGui") and descendant.Adornee then
            v20[descendant.Name] = descendant;
        elseif descendant:IsA("ViewportFrame") and descendant:GetAttribute("CameraCFrame") then
            local Camera = Instance.new("Camera");
            Camera.CFrame = descendant:GetAttribute("CameraCFrame");
            Camera.FieldOfView = descendant:GetAttribute("CameraFOV");
            Camera.Parent = descendant;
            descendant.CurrentCamera = Camera;
        end;
    end;

    for _, v in v20 do
        v.Parent = LocalPlayer.PlayerGui;
        p18:Add(v);
    end;

    p16:PivotTo(p17);
    p16.Parent = workspace.Effects;

    return v19, v20;
end;

local function hide_character(p21: userdata, p22: any) -- Line: 151
    for _, descendant in p21:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            p22:Add(function() -- Line: 156
                -- upvalues: descendant (copy), Transparency (copy)
                descendant.Transparency = Transparency;
            end);
        end;
    end;
end;

local function play_cutscene(p23: userdata, p24: userdata, p25: any, p26: number, p27) -- Line: 163
    -- upvalues: ReplicatedStorage (copy), build_scene (copy), dress_rig (copy), hide_character (copy), u2 (copy), u1 (copy), u4 (copy), u3 (copy)
    local Part = Instance.new("Part");
    Part.Name = "MatchIntroRoot";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.CFrame = p27;
    Part.Parent = workspace.Effects;
    p25:Add(Part);
    local Animations = p23:FindFirstChild("Animations");
    local v28 = {
        CurrentCamera = workspace.CurrentCamera,
        Lighting = game:GetService("Lighting")
    };
    local v29 = {};
    local v30, v31;

    if Animations and (Animations:FindFirstChild("Cam") and p23:FindFirstChild("Cam")) then
        local v32;
        v30, v32, v31 = require(ReplicatedStorage.client.replication.mainreplication).cutsceneCamRigWithLetterBox(Part, Animations.Cam, p23:FindFirstChild("FOV"), nil, p23:GetAttribute("CamOffset"), p23.Cam, p23:GetAttribute("CamPart") or "Camera", "All");
        p25:Add(v32);
        table.insert(v29, v31);
        v28[p23.Cam:GetAttribute("MoonName") or p23.Cam.Name] = v30;
    else
        v30 = nil;
        v31 = nil;
    end;

    local v33, v34, v35;

    if p23:FindFirstChild("VFX") then
        v33 = p25:Clone(p23.VFX);
        v34, v35 = build_scene(v33, Part.CFrame, p25);

        for _, v in v34 do
            if v:GetAttribute("CopyPlayer") then
                dress_rig(v, p24);
            end;
        end;

        v28.Workspace = v33;

        for _, child in v33:GetChildren() do
            v28[child.Name] = child;
        end;

        for i, v in v35 do
            v28[i] = v;
        end;
    else
        v34 = {};
        v35 = {};
        v33 = nil;
    end;

    if p23:GetAttribute("HideCharacter") then
        hide_character(p24, p25);
    end;

    if Animations then
        for _, child in Animations:GetChildren() do
            local v36;

            if child.Name == "User" then
                v36 = p24;
            else
                v36 = v34[child.Name];
            end;

            if v36 then
                local v37 = u2:loadAnimation(v36, child);
                table.insert(v29, p25:Add(v37, "Stop"));
            end;
        end;
    end;

    local Lighting = p23:FindFirstChild("Lighting");

    if Lighting and Lighting:GetAttribute("Replace") then
        local Attributes = Lighting:GetAttributes();
        Attributes.Replace = nil;
        u1.cutscene_lighting(p25, v28, Lighting, Attributes);
    elseif Lighting then
        u1.contain_lighting(p25, v28, Lighting);
    end;

    local v38;

    if p23:FindFirstChild("Moon") then
        v38 = p25:Construct(u4);
        v38:LoadAndConvertSave(p23.Moon, v28);

        if v33 then
            v38:SetOriginalRoot(p23.VFX:GetPivot());
        end;

        v38:SetRoot(Part);
    else
        v38 = nil;
    end;

    local v39 = os.clock() + 2;

    for _, v in v29 do
        while v.Length == 0 and os.clock() < v39 do
            task.wait();
        end;
    end;

    for _, v in v29 do
        if v == v31 then
            v.TimePosition = 0;
        else
            v:Play(0);
        end;
    end;

    if v38 then
        v38:PlayAll();
    end;

    if p23:FindFirstChild("SFX") then
        u3:play(p23.SFX, "default");
    end;

    if p23:FindFirstChild("Compiled") then
        u1.execute_compiled(p23.Compiled, p25, v33, p24, v30, v35);
    end;

    if p23:FindFirstChild("Intro") then
        task.spawn(require(p23.Intro), {
            character = p24,
            root = Part,
            folder = p23,
            container = p25,
            vfx = v33,
            cam = v30,
            guis = v35,
            length = p26
        });
    end;
end;

function v7.match_intro(u40: string, u41: userdata, u42, u43: number, u44: number, u45: number, u46: number, u47: number) -- Line: 290
    -- upvalues: u1 (copy), ReplicatedStorage (copy), u5 (copy), new_blackout (copy), TweenService (copy), hide_ui (copy), play_cutscene (copy)
    local u48 = u1.getResources().MatchIntros:FindFirstChild(u40);
    local replication = require(ReplicatedStorage.client.replication);
    local u49 = u5.new();
    local u50 = u5.new();
    local u51, u52 = new_blackout();
    local os_clock_ret = os.clock();

    local function wait_until(p53: number) -- Line: 299
        -- upvalues: os_clock_ret (copy)
        task.wait(os_clock_ret + p53 - os.clock());
    end;

    local function fade(p54: number, p55: number) -- Line: 303
        -- upvalues: TweenService (ref), u52 (copy)
        local v56 = TweenService:Create(u52, TweenInfo.new(p55), {
            BackgroundTransparency = p54
        });
        v56:Play();

        return v56;
    end;

    task.spawn(function() -- Line: 309
        -- upvalues: u44 (copy), TweenService (ref), u52 (copy), os_clock_ret (copy), hide_ui (ref), u49 (copy), replication (copy), u41 (copy), u50 (copy), play_cutscene (ref), u48 (copy), u43 (copy), u42 (copy), u40 (copy), u45 (copy), u46 (copy), u47 (copy), u51 (copy)
        TweenService:Create(u52, TweenInfo.new(u44), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(os_clock_ret + u44 - os.clock());
        hide_ui(u49);
        replication.sceneEnabled(true);
        u49:Add(function() -- Line: 315
            -- upvalues: replication (ref)
            replication.sceneEnabled(false);
        end);

        if u41.Parent then
            u50:AttachToInstance(u41);
            local success, result = pcall(play_cutscene, u48, u41, u50, u43, u42);

            if not success then
                warn("match intro \'" .. u40 .. "\' failed: " .. tostring(result));
                u50:Clean();
            end;
        end;

        local v57 = u44 + (u48:GetAttribute("SetupHold") or 0.35);
        task.wait(os_clock_ret + v57 - os.clock());
        local v58 = u48:GetAttribute("Reveal") or 0.4;
        TweenService:Create(u52, TweenInfo.new(v58), {
            BackgroundTransparency = 1
        }):Play();
        task.wait(os_clock_ret + (u44 + u43) - os.clock());
        TweenService:Create(u52, TweenInfo.new(u45), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(os_clock_ret + (u44 + u43 + u45) - os.clock());
        u50:Destroy();
        task.wait(os_clock_ret + (u44 + u43 + u45 + u46) - os.clock());
        u49:Destroy();
        replication.start(0, nil, nil, true);
        local v59 = TweenService:Create(u52, TweenInfo.new(u47), {
            BackgroundTransparency = 1
        });
        v59:Play();
        v59.Completed:Wait();
        u51:Destroy();
    end);
end;

return v7;