 
 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local CollectionService = game:GetService("CollectionService");
local u1 = require("@game/ReplicatedStorage/util/soundUtil");
local u2 = require("@game/ReplicatedStorage/util/vfxUtil");
local u3 = require("@game/ReplicatedStorage/util/animationUtil");
local u4 = require("@game/ReplicatedStorage/util/MoonPropertyAnimator");
local u5 = require("@game/ReplicatedStorage/util/raycast");
local u6 = require("@game/ReplicatedStorage/forum/trove");
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);
local roland = u2.getResources().roland;
local v7 = {};
local u8 = {
    AllasWorkshop = {
        name = "Allas Workshop",
        page = "AllasPage",
        diceMin = 5,
        diceMax = 19,
        statuses = { "Pierce", "Pierce", "Pierce", "Pierce" }
    },
    AtelierShotgun = {
        name = "Atelier Logic: Shotgun",
        page = "AtelierShotgunPage",
        diceMin = 7,
        diceMax = 22,
        statuses = { "Pierce", "Pierce", "Blunt" }
    },
    MookQuickdraw = {
        name = "Mook Workshop: Quickdraw",
        page = "MookWorkshopTPPage",
        diceMin = 8,
        diceMax = 25,
        statuses = { "Slash", "Slash" }
    },
    CrystalReversal = {
        name = "Crystal Atelier: Reversal",
        page = "CrystalAtelierTrapPage",
        diceMin = 7,
        diceMax = 19,
        statuses = { "Slash", "Slash", "Slash" }
    },
    CrystalWaltz = {
        name = "Crystal Atelier: Waltz",
        page = "CrystalAtelierTrapPage",
        diceMin = 8,
        diceMax = 20,
        statuses = { "Blunt", "Slash", "Slash" }
    },
    AtelierPistols = {
        name = "Atelier Logic: Pistol",
        page = "AtelierPistolPage",
        diceMin = 4,
        diceMax = 18,
        statuses = { "Pierce", "Pierce", "Blunt" }
    },
    WheelsIndustry = {
        name = "Wheels Industry",
        page = "WheelsPage",
        diceMin = 14,
        diceMax = 24,
        statuses = { "Slash", "Blunt", "Slash" }
    },
    ZelkovaCounter = {
        name = "Zelkova Workshop: Ranga Counter",
        page = "ZelkovaCounterPage",
        diceMin = 4,
        diceMax = 18,
        statuses = { "Slash", "Blunt" }
    },
    DurandalSever = {
        name = "Durandal: Sever",
        page = "DurandalPage",
        diceMin = 5,
        diceMax = 19,
        statuses = { "Blunt", "Pierce", "Slash" }
    },
    DurandalBreakthrough = {
        name = "Durandal: Breakthrough",
        page = "DurandalPage",
        diceMin = 9,
        diceMax = 23,
        statuses = { "Slash", "Blunt" }
    }
};

local function talk(p9: any, p10: userdata, u11: string) -- Line: 96
    -- upvalues: roland (copy), TweenService (copy)
    local RNPDialogue = roland.Misc:FindFirstChild("RNPDialogue");

    if not (RNPDialogue and RNPDialogue:IsA("BillboardGui")) then
        return;
    end;

    local RNPDialogue2 = p9:FindFirstChild("RNPDialogue");

    if RNPDialogue2 then
        RNPDialogue2:Destroy();
    end;

    local u12 = RNPDialogue:Clone();
    u12.Name = "RNPDialogue";
    u12.Adornee = p10;
    u12.Parent = p9;
    local Background = u12:FindFirstChild("Background");
    local Dialogue = u12:FindFirstChild("Dialogue");

    if not (Background and (Background:IsA("ImageLabel") and (Dialogue and Dialogue:IsA("TextLabel")))) then
        u12:Destroy();

        return;
    end;

    local u13 = Dialogue:FindFirstChildOfClass("UIStroke");
    local ImageTransparency = Background.ImageTransparency;
    Dialogue.Text = u11;
    Dialogue.MaxVisibleGraphemes = 0;
    Dialogue.TextTransparency = 0;

    if u13 then
        u13.Transparency = 0;
    end;

    Background.ImageTransparency = 1;
    TweenService:Create(Background, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = ImageTransparency
    }):Play();
    task.spawn(function() -- Line: 134
        -- upvalues: u11 (copy), u12 (copy), Dialogue (copy), TweenService (ref), Background (copy), u13 (copy)
        for i = 1, utf8.len(u11) or #u11 do
            if not u12.Parent then
                return;
            end;

            Dialogue.MaxVisibleGraphemes = i;
            task.wait(0.035);
            local _ = i;
        end;

        if not u12.Parent then
            return;
        end;

        Dialogue.MaxVisibleGraphemes = -1;
        task.wait(2.75);

        if not u12.Parent then
            return;
        end;

        TweenService:Create(Background, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Dialogue, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1
        }):Play();

        if u13 then
            TweenService:Create(u13, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end;

        task.wait(0.4);

        if u12.Parent then
            u12:Destroy();
        end;
    end);
end;

local function dress_rig(p14: userdata, p15: userdata) -- Line: 173
    for _, child in p14:GetChildren() do
        if child:IsA("Accessory") or (child:IsA("Clothing") or (child:IsA("ShirtGraphic") or (child:IsA("CharacterMesh") or child:IsA("BodyColors")))) then
            child:Destroy();
        end;
    end;

    for _, child in p15:GetChildren() do
        if child:IsA("Accessory") then
            local v16 = child:Clone();
            local Handle = v16:FindFirstChild("Handle");
            local v17;

            if Handle then
                v17 = Handle:FindFirstChildOfClass("Attachment");
            else
                v17 = Handle;
            end;

            local v18;

            if v17 then
                v18 = p14:FindFirstChild(v17.Name, true);
            else
                v18 = v17;
            end;

            if v18 then
                for _, child2 in Handle:GetChildren() do
                    if child2:IsA("JointInstance") then
                        child2:Destroy();
                    end;
                end;

                local Weld = Instance.new("Weld");
                Weld.Part0 = Handle;
                Weld.Part1 = v18.Parent;
                Weld.C0 = v17.CFrame;
                Weld.C1 = v18.CFrame;
                Weld.Parent = Handle;
                v16.Parent = p14;
            end;
        elseif child:IsA("Clothing") or (child:IsA("ShirtGraphic") or child:IsA("CharacterMesh")) then
            child:Clone().Parent = p14;
        elseif child:IsA("BasePart") then
            local v19 = p14:FindFirstChild(child.Name);

            if v19 and v19:IsA("BasePart") then
                v19.Color = child.Color;
            end;
        end;
    end;

    local Head = p14.Head;
    local v20 = p15.Head:Clone();

    for _, child in v20:GetChildren() do
        if child:IsA("Decal") then
            child.Transparency = 0;
        elseif not (child:IsA("DataModelMesh") or (child:IsA("FaceControls") or child:IsA("SurfaceAppearance"))) then
            child:Destroy();
        end;
    end;

    v20.Name = "HeadCopy";
    v20.Anchored = false;
    v20.CanCollide = false;
    v20.CanQuery = false;
    v20.CanTouch = false;
    v20.Massless = true;
    v20.Transparency = Head.Transparency;
    v20.CFrame = Head.CFrame;
    local Weld = Instance.new("Weld");
    Weld.Part0 = Head;
    Weld.Part1 = v20;
    Weld.Parent = v20;
    v20.Parent = p14;
    Head.Transparency = 1;

    for _, child in Head:GetChildren() do
        if child:IsA("Decal") then
            child.Transparency = 1;
        end;
    end;
end;

local TweenInfo_new_ret = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local UDim2_fromScale_ret = UDim2.fromScale(0.35, 0);
local TweenInfo_new_ret2 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local UDim2_fromScale_ret2 = UDim2.fromScale(0, 0.35);
local TweenInfo_new_ret3 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret4 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);

local function fade_in(p21: userdata, p22: userdata) -- Line: 250
    -- upvalues: TweenService (copy)
    local u23 = {};

    local function track(p24: userdata, p25: string) -- Line: 252
        -- upvalues: u23 (copy)
        local v26 = p24[p25];

        if v26 < 1 then
            table.insert(u23, { p24, p25, v26 });
            p24[p25] = 1;
        end;
    end;

    local function collect(p27: userdata) -- Line: 260
        -- upvalues: u23 (copy)
        if p27:IsA("GuiObject") then
            local BackgroundTransparency = p27.BackgroundTransparency;

            if BackgroundTransparency < 1 then
                table.insert(u23, { p27, "BackgroundTransparency", BackgroundTransparency });
                p27.BackgroundTransparency = 1;
            end;
        end;

        if p27:IsA("ImageLabel") or (p27:IsA("ImageButton") or p27:IsA("ViewportFrame")) then
            local ImageTransparency = p27.ImageTransparency;

            if ImageTransparency < 1 then
                table.insert(u23, { p27, "ImageTransparency", ImageTransparency });
                p27.ImageTransparency = 1;
            end;
        end;

        if p27:IsA("TextLabel") or p27:IsA("TextButton") then
            local TextTransparency = p27.TextTransparency;

            if TextTransparency < 1 then
                table.insert(u23, { p27, "TextTransparency", TextTransparency });
                p27.TextTransparency = 1;
            end;

            local TextStrokeTransparency = p27.TextStrokeTransparency;

            if TextStrokeTransparency < 1 then
                table.insert(u23, { p27, "TextStrokeTransparency", TextStrokeTransparency });
                p27.TextStrokeTransparency = 1;
            end;
        end;

        if p27:IsA("UIStroke") then
            local Transparency = p27.Transparency;

            if Transparency < 1 then
                table.insert(u23, { p27, "Transparency", Transparency });
                p27.Transparency = 1;
            end;
        end;
    end;

    collect(p21);

    for _, descendant in p21:GetDescendants() do
        collect(descendant);
    end;

    for _, v in u23 do
        TweenService:Create(v[1], p22, {
            [v[2]] = v[3]
        }):Play();
    end;
end;

local TweenInfo_new_ret5 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local UDim2_fromScale_ret3 = UDim2.fromScale(0.25, 0);
local UDim2_fromScale_ret4 = UDim2.fromScale(0, 0.25);

local function fade_out(p28: userdata, u29: userdata) -- Line: 290
    -- upvalues: TweenService (copy)
    local function v32(p30: userdata) -- Line: 291
        -- upvalues: TweenService (ref), u29 (copy)
        local v31 = {};

        if p30:IsA("GuiObject") and p30.BackgroundTransparency < 1 then
            v31.BackgroundTransparency = 1;
        end;

        if (p30:IsA("ImageLabel") or (p30:IsA("ImageButton") or p30:IsA("ViewportFrame"))) and p30.ImageTransparency < 1 then
            v31.ImageTransparency = 1;
        end;

        if p30:IsA("TextLabel") or p30:IsA("TextButton") then
            if p30.TextTransparency < 1 then
                v31.TextTransparency = 1;
            end;

            if p30.TextStrokeTransparency < 1 then
                v31.TextStrokeTransparency = 1;
            end;
        end;

        if p30:IsA("UIStroke") and p30.Transparency < 1 then
            v31.Transparency = 1;
        end;

        if next(v31) then
            TweenService:Create(p30, u29, v31):Play();
        end;
    end;

    v32(p28);

    for _, descendant in p28:GetDescendants() do
        v32(descendant);
    end;
end;

local function slide_out(p33: userdata, p34, p35: userdata) -- Line: 320
    -- upvalues: TweenService (copy)
    TweenService:Create(p33, p35, {
        Position = p33.Position + p34
    }):Play();
end;

local function slide_in(p36: userdata, p37, p38: userdata) -- Line: 324
    -- upvalues: TweenService (copy)
    local Position = p36.Position;
    p36.Position = Position + p37;
    TweenService:Create(p36, p38, {
        Position = Position
    }):Play();
end;

local function pop_scale(p39: userdata) -- Line: 330
    -- upvalues: TweenService (copy), TweenInfo_new_ret3 (copy), TweenInfo_new_ret4 (copy)
    local u40 = p39:FindFirstChildOfClass("UIScale");

    if not u40 then
        return;
    end;

    local Attribute = u40:GetAttribute("BaseScale");

    if Attribute == nil then
        Attribute = u40.Scale;
        u40:SetAttribute("BaseScale", Attribute);
    end;

    local v41 = TweenService:Create(u40, TweenInfo_new_ret3, {
        Scale = Attribute * 1.6
    });
    v41.Completed:Once(function() -- Line: 341
        -- upvalues: u40 (copy), TweenService (ref), TweenInfo_new_ret4 (ref), Attribute (ref)
        if u40.Parent then
            TweenService:Create(u40, TweenInfo_new_ret4, {
                Scale = Attribute
            }):Play();
        end;
    end);
    v41:Play();
end;

local u42 = {};
local TweenInfo_new_ret6 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret7 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out);

local function set_move_status(p43: any, p44: number) -- Line: 355
    -- upvalues: u42 (copy), TweenService (copy), TweenInfo_new_ret6 (copy), TweenInfo_new_ret7 (copy)
    local v45 = u42[p43];

    if v45 then
        v45 = v45[2]:FindFirstChild("CardStatus", true);
    end;

    if not v45 then
        return;
    end;

    for _, child in v45:GetChildren() do
        if child:IsA("Frame") and child.Visible then
            local v46 = child.LayoutOrder == p44;
            TweenService:Create(child.ImageLabel, TweenInfo_new_ret6, {
                ImageTransparency = v46 and 0 or 0.7
            }):Play();

            if v46 then
                local v47 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v47.Scale = 1.5;
                v47.Parent = child;
                TweenService:Create(v47, TweenInfo_new_ret7, {
                    Scale = 1
                }):Play();
            end;
        end;
    end;
end;

local function show_move_ui(p48: any, u49: any, p50: userdata, u51: any, p52: number?) -- Line: 378
    -- upvalues: roland (copy), u2 (copy), u42 (copy), fade_out (copy), TweenInfo_new_ret5 (copy), UDim2_fromScale_ret3 (copy), TweenService (copy), UDim2_fromScale_ret4 (copy), fade_in (copy), TweenInfo_new_ret2 (copy), UDim2_fromScale_ret2 (copy), pop_scale (copy), dress_rig (copy), u3 (copy), TweenInfo_new_ret (copy), UDim2_fromScale_ret (copy)
    if u49:GetAttribute("RinNoPlay") then
        return;
    end;

    local Misc = roland:FindFirstChild("Misc");
    local v53;

    if Misc then
        v53 = Misc:FindFirstChild("Pages");
    else
        v53 = Misc;
    end;

    if v53 then
        v53 = v53:FindFirstChild(u51.page);
    end;

    if Misc then
        Misc = Misc:FindFirstChild("DiceRoll");
    end;

    if not (v53 and (v53:IsA("BillboardGui") and (Misc and Misc:IsA("BillboardGui")))) then
        return;
    end;

    local PlayerGui = u2.getPlayerGui();
    local v54 = u42[u49];

    if v54 then
        for _, v in v54 do
            v:Destroy();
        end;

        u42[u49] = nil;
    end;

    local u55 = v53:Clone();
    u55.Name = `RolandMovePage_{u49.Name}`;
    u55.Enabled = false;
    u55.Adornee = p50;
    u55.MaxDistance = (1 / 0);
    u55.Parent = PlayerGui;
    local u56 = Misc:Clone();
    u56.Name = `RolandDiceRoll_{u49.Name}`;
    u56.Adornee = p50;
    u56.MaxDistance = (1 / 0);
    u56.Parent = PlayerGui;
    local u57 = { u55, u56 };
    u42[u49] = u57;
    u49.Destroying:Once(function() -- Line: 416
        -- upvalues: u42 (ref), u49 (copy), u57 (copy), u55 (copy), u56 (copy)
        if u42[u49] == u57 then
            u42[u49] = nil;
        end;

        u55:Destroy();
        u56:Destroy();
    end);
    p48:Add(function() -- Line: 424
        -- upvalues: u55 (copy), fade_out (ref), TweenInfo_new_ret5 (ref), UDim2_fromScale_ret3 (ref), TweenService (ref), u56 (copy), UDim2_fromScale_ret4 (ref), u42 (ref), u49 (copy), u57 (copy)
        local v58 = u55.Parent and u55:FindFirstChildWhichIsA("GuiObject");

        if v58 then
            fade_out(v58, TweenInfo_new_ret5);
            TweenService:Create(v58, TweenInfo_new_ret5, {
                Position = v58.Position + UDim2_fromScale_ret3
            }):Play();
        end;

        if u56.Parent then
            local CardProfile = u56:FindFirstChild("CardProfile");

            if CardProfile and CardProfile:IsA("GuiObject") then
                TweenService:Create(CardProfile, TweenInfo_new_ret5, {
                    Position = CardProfile.Position + UDim2_fromScale_ret4
                }):Play();
            end;

            fade_out(u56, TweenInfo_new_ret5);
        end;

        task.delay(TweenInfo_new_ret5.Time, function() -- Line: 439
            -- upvalues: u42 (ref), u49 (ref), u57 (ref), u55 (ref), u56 (ref)
            if u42[u49] == u57 then
                u42[u49] = nil;
            end;

            u55:Destroy();
            u56:Destroy();
        end);
    end);
    local CardProfile = u56:FindFirstChild("CardProfile");
    local v59;

    if CardProfile then
        v59 = CardProfile:FindFirstChild("CardName");
    else
        v59 = CardProfile;
    end;

    local v60;

    if CardProfile then
        v60 = CardProfile:FindFirstChild("CardStatus");
    else
        v60 = CardProfile;
    end;

    if v59 and v59:IsA("TextLabel") then
        v59.Text = u51.name;
    end;

    if v60 and v60:IsA("Frame") then
        for i, v in u51.statuses do
            local v61 = v60:FindFirstChild(v);

            if v61 and v61:IsA("GuiObject") then
                local v62 = v61:Clone();
                v62.Name = `{v}{i}`;
                v62.LayoutOrder = i;
                v62.Visible = true;
                v62.ImageLabel.ImageTransparency = 0.7;
                v62.Parent = v60;
            end;
        end;
    end;

    if CardProfile and CardProfile:IsA("GuiObject") then
        fade_in(CardProfile, TweenInfo_new_ret2);
        local Position = CardProfile.Position;
        CardProfile.Position = Position + UDim2_fromScale_ret2;
        TweenService:Create(CardProfile, TweenInfo_new_ret2, {
            Position = Position
        }):Play();
    end;

    local Dice1 = u56:FindFirstChild("Dice1");
    local v63;

    if Dice1 then
        v63 = Dice1:FindFirstChild("MaxAndMinDice");
    else
        v63 = Dice1;
    end;

    if Dice1 then
        Dice1 = Dice1:FindFirstChild("DiceNumber");
    end;

    if v63 and v63:IsA("TextLabel") then
        v63.Text = `{u51.diceMin} ~ {u51.diceMax}`;
    end;

    if Dice1 and Dice1:IsA("TextLabel") then
        local Random_new_ret = Random.new();
        local u64 = p52 or Random_new_ret:NextInteger(u51.diceMin, u51.diceMax);
        task.spawn(function() -- Line: 481
            -- upvalues: Dice1 (copy), Random_new_ret (copy), u51 (copy), u64 (copy), pop_scale (ref)
            for i = 1, 8 do
                if not Dice1.Parent then
                    return;
                end;

                Dice1.Text = tostring(Random_new_ret:NextInteger(u51.diceMin, u51.diceMax));
                task.wait(0.04);
                local _ = i;
            end;

            if Dice1.Parent then
                Dice1.Text = tostring(u64);
                pop_scale(Dice1);
            end;
        end);
    end;

    local v65 = u55:FindFirstChildWhichIsA("ViewportFrame", true);
    local v66;

    if v65 then
        v66 = v65:FindFirstChildWhichIsA("WorldModel");
    else
        v66 = v65;
    end;

    local v67;

    if v66 then
        v67 = v66:FindFirstChild("PlayerRig");
    else
        v67 = v66;
    end;

    if v66 and not v67 then
        for _, child in v66:GetChildren() do
            if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then
                v67 = child;
                break;
            end;
        end;
    end;

    if v65 and v66 then
        v65.CurrentCamera = v66:FindFirstChildWhichIsA("Camera");
    end;

    if v67 then
        dress_rig(v67, u49);
        local Idle = v67:FindFirstChild("Idle");
        local v68 = Idle and (Idle:IsA("Animation") and u3:loadAnimation(v67, Idle));

        if v68 then
            v68.Looped = true;
            v68:Play(0);
            p48:Add(v68, "Stop");
        end;
    end;

    if u55.Parent then
        local v69 = u55:FindFirstChildWhichIsA("GuiObject");

        if v69 then
            fade_in(v69, TweenInfo_new_ret);
            local Position = v69.Position;
            v69.Position = Position + UDim2_fromScale_ret;
            TweenService:Create(v69, TweenInfo_new_ret, {
                Position = Position
            }):Play();
        end;

        u55.Enabled = true;
    end;
end;

local u70 = {};

function v7.roland_allas(p71: any, p72: number) -- Line: 535
    -- upvalues: u2 (copy), RunService (copy), u3 (copy), show_move_ui (copy), u8 (copy), u70 (copy), u4 (copy)
    local Root = u2.getRoot(p71);
    local v73 = u2.character_trove(p71);
    local AllasWorkshop = u2.getResources().roland.AllasWorkshop;
    local u74 = v73:Clone(AllasWorkshop.VFX);
    u74.Parent = workspace.Effects;
    v73:Add(RunService.RenderStepped:Connect(function() -- Line: 542
        -- upvalues: u74 (copy), Root (copy)
        if u74 then
            u74:PivotTo(Root.CFrame);
        end;
    end));
    v73:Add(u3:loadAnimation(p71, AllasWorkshop.Animation), "Stop"):Play(0);
    local buildFromRig = u2.buildFromRig;
    local v75;

    if p71:GetAttribute("RinNoPlay") then
        v75 = AllasWorkshop.RigRNP;
    else
        v75 = AllasWorkshop.Rig;
    end;

    local v76, v77 = buildFromRig(p71, v75);
    v73:Add(v76);
    u2.execute_compiled(AllasWorkshop.Compiled, v73, u74, p71);
    v73:Add(task.delay(2, v73.Destroy, v73));
    task.spawn(show_move_ui, v73, p71, Root, u8.AllasWorkshop);
    u70[p71] = 0;
    local v78 = nil;

    for _, v in v77 do
        if v:IsA("Highlight") then
            v78 = v;
            break;
        end;
    end;

    local v79 = p71:FindFirstChild("Right Arm") and p71["Right Arm"]:FindFirstChild("Allas");

    if v79 then
        v79 = v79:FindFirstChildWhichIsA("Highlight");
    end;

    local v80 = v73:Construct(u4);
    v80:LoadSave(AllasWorkshop.Moon, {
        [2] = v79,
        [3] = v78
    });
    v80:SetRoot(Root);
    v80:PlayAll();
end;

function v7.roland_shotgun(p81: any, p82: number) -- Line: 581
    -- upvalues: u2 (copy), RunService (copy), u3 (copy), show_move_ui (copy), u8 (copy), set_move_status (copy)
    local Root = u2.getRoot(p81);
    local v83 = u2.character_trove(p81);
    local AtelierShotgun = u2.getResources().roland.AtelierShotgun;
    local u84 = v83:Clone(AtelierShotgun.VFX);
    u84.Parent = workspace.Effects;
    v83:Add(RunService.RenderStepped:Connect(function() -- Line: 588
        -- upvalues: u84 (copy), Root (copy)
        if u84 then
            u84:PivotTo(Root.CFrame);
        end;
    end));
    v83:Add((u2.buildFromRig(p81, AtelierShotgun.Rig)));
    v83:Add(u3:loadAnimation(p81, AtelierShotgun.Animation), "Stop"):Play(0, 1, 1.2);
    u2.execute_compiled_ex(AtelierShotgun.Compiled, v83, 72, u84, p81);
    v83:Add(task.delay(2.8472222222222223, v83.Destroy, v83));
    task.spawn(show_move_ui, v83, p81, Root, u8.AtelierShotgun, p82);
    set_move_status(p81, 1);
    v83:Add(task.delay(1.1666666666666667, set_move_status, p81, 2));
    v83:Add(task.delay(2.3333333333333335, set_move_status, p81, 3));
end;

local u85 = { {
        sound = "RNPMarkOne",
        text = "One."
    }, {
        sound = "RNPMarkTwo",
        text = "Two."
    }, {
        sound = "RNPMarkThree",
        text = "Trois."
    }, {
        sound = "RNPMarkFour",
        text = "Four."
    }, {
        sound = "RNPMarkFive",
        text = "Five."
    }, {
        sound = "RNPMarkSix",
        text = "Six."
    }, {
        sound = "RNPMarkSeven",
        text = "Seven. Two to go."
    }, {
        sound = "RNPMarkEight",
        text = "Eight. One left."
    }, {
        sound = "RNPMarkNine",
        text = "Neuf. Executed."
    } };

function v7.roland_rnp_mark(p86: any, p87: number) -- Line: 620
    -- upvalues: u2 (copy), u85 (copy), u1 (copy), roland (copy), talk (copy)
    local Root = u2.getRoot(p86);
    local v88 = u85[p87];
    u1:play(roland.Misc[v88.sound], Root);
    talk(p86, Root, v88.text);
end;

function v7.roland_scythe_equip(p89) -- Line: 629
    -- upvalues: u2 (copy), u1 (copy), roland (copy), talk (copy)
    local Root = u2.getRoot(p89);
    local v90 = u2.character_trove(p89);
    u1:play(roland.Misc["Scythe Summon"], Root);
    talk(p89, Root, "....If I let you go here, you will never come home again.");
    v90:Clone(roland.Misc.handleappear).Parent = p89["Right Arm"];
    local v91 = v90:Clone(roland.Misc.ScytheVFX);
    v91:PivotTo(Root.CFrame);
    local RienScythe = p89:FindFirstChild("RienScythe");

    for _, v in v91:QueryDescendants("Weld") do
        if RienScythe then
            v.Part0 = RienScythe.Handle;
        else
            v.Part1.Anchored = true;
        end;
    end;

    v91.Parent = workspace.Effects;
    u2.execute_compiled(roland.Misc.Scythe_C, v90, v91, p89);
    v90:Add(task.delay(2, v90.Destroy, v90));
end;

local u92 = {};

function v7.roland_flow(u93) -- Line: 660
    -- upvalues: u2 (copy), roland (copy), u92 (copy), u3 (copy), u4 (copy)
    local Root = u2.getRoot(u93);
    local Startup = roland.Flow:FindFirstChild("Startup");

    if not (Root and Startup) then
        return;
    end;

    local Lighting2 = game:GetService("Lighting");
    local u94 = require("@game/ReplicatedStorage/client/replication/mainreplication");
    local u95 = u2.character_trove(u93);
    u92[u93] = u95;
    u95:Add(function() -- Line: 672
        -- upvalues: u92 (ref), u93 (copy), u95 (copy)
        if u92[u93] == u95 then
            u92[u93] = nil;
        end;
    end);
    u94.sceneEnabled(true);
    u95:Add(function() -- Line: 679
        -- upvalues: u94 (copy)
        u94.sceneEnabled(false);
    end);
    local v96, v97 = u94.cutsceneCamRigWithLetterBox(Root, Startup.Animations.Cam, Startup.FOV, nil, CFrame.identity, Startup.Cam, "Torso");

    if v97 then
        u95:Add(v97);
    end;

    local v98 = u95:Clone(Startup.Angeler);
    v98:PivotTo(Root.CFrame);
    v98.Parent = workspace.Effects;
    u95:Add(u3:loadAnimation(v98, Startup.Animations.Angela), "Stop"):Play(0);
    local u99 = Startup.VFX:Clone();
    u99:PivotTo(Root.CFrame);
    u99.Parent = workspace.Effects;
    u95:Add(function() -- Line: 703
        -- upvalues: u99 (copy)
        for _, child in u99:GetChildren() do
            if child.Name ~= "End" and child ~= u99.PrimaryPart then
                child:Destroy();
            end;
        end;

        for _, descendant in u99:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Light")) then
                descendant.Enabled = false;
            end;
        end;

        task.delay(1.5, function() -- Line: 714
            -- upvalues: u99 (ref)
            u99:Destroy();
        end);
    end);
    local v100 = {
        Workspace = u99,
        Angeler = v98,
        Lighting = Lighting2
    };
    u2.cutscene_lighting(u95, v100, Startup:FindFirstChild("Lighting"));
    local v101 = u95:Construct(u4);
    v101:LoadAndConvertSave(Startup.Moon, v100);
    v101:SetOriginalRoot(Startup.VFX:GetPivot());
    v101:SetRoot(Root);
    v101:PlayAll();
    u2.execute_compiled(Startup.Compiled, u95, u99, u93, v98, v96);
    u95:Add(task.delay(7.083333333333333, u95.Destroy, u95));
end;

function v7.roland_offball_run(p102) -- Line: 738
    -- upvalues: u92 (copy)
    local v103 = u92[p102];

    if v103 then
        v103:Destroy();
    end;
end;

local function offball_scene(p104: any, p105: userdata, p106: number, p107: string) -- Line: 750
    -- upvalues: u2 (copy)
    local Root = u2.getRoot(p104);
    local u108 = require("@game/ReplicatedStorage/client/replication/mainreplication");
    local v109 = u2.character_trove(p104);
    u108.sceneEnabled(true);
    v109:Add(function() -- Line: 756
        -- upvalues: u108 (copy)
        u108.sceneEnabled(false);
    end);
    local v110, v111 = u108.cutsceneCamRigWithLetterBox(Root, p105.Animations.Cam, p105.FOV, nil, p105.Cam:GetAttribute("Offset"), p105.Cam, p107);

    if v111 then
        v109:Add(v111);
    end;

    local v112 = v109:Clone(p105.VFX);
    v112:PivotTo(Root.CFrame);
    v112.Parent = workspace.Effects;
    v109:Add((u2.buildFromRig(p104, p105.Rig)));
    local v113 = {
        Workspace = v112,
        MoonAnimatorEffects = v109:Add(u2.getMoonEffects())
    };
    u2.cutscene_lighting(v109, v113, p105.Lighting, p105.Lighting:GetAttributes());
    v109:Add(task.delay(p106, v109.Destroy, v109));

    return v109, v112, v110, v113;
end;

function v7.roland_offball_battle(p114, p115) -- Line: 781
    -- upvalues: roland (copy), offball_scene (copy), u4 (copy), u2 (copy)
    local Battle = roland.Flow.OffBall.Battle;
    local v116, v117, v118, v119 = offball_scene(p114, Battle, 15.583333333333334, "Bone");
    v119.DurandalRig = p114;
    v119.NewAZLBallRig = p115;
    v119.CameraRig = v118;
    local v120 = v116:Construct(u4);
    v120:LoadAndConvertSave(Battle.Moon, v119);
    v120:PlayAll();
    u2.execute_compiled(Battle.Compiled, v116, v117, p114);

    if v118 then
        u2.execute_compiled(Battle.CamCompiled, v116, v118);
    end;
end;

function v7.roland_offball_outcome(p121: any, u122: any, p123: boolean) -- Line: 799
    -- upvalues: roland (copy), offball_scene (copy), u2 (copy), u4 (copy)
    local v124 = roland.Flow.OffBall[p123 and "Win" or "Lose"];
    local u125, v126, v127, v128 = offball_scene(p121, v124, p123 and 7 or 10, "Torso");

    if not p123 then
        u125:Add((u2.buildFromRig(u122, v124.VictimRig)));
    end;

    v128.Roland = p121;
    v128.victim = u122;
    v128.CameraRigV5 = v127;
    local v129 = u125:Construct(u4);
    v129:LoadAndConvertSave(v124.Moon, v128);
    v129:PlayAll();
    u2.execute_compiled(v124.Compiled, u125, v126, p121, u122);

    if p123 then
        local function hide(p130: number) -- Line: 818
            -- upvalues: u122 (copy)
            for _, descendant in u122:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                    descendant.LocalTransparencyModifier = p130;
                end;
            end;
        end;

        u125:Add(task.delay(5.333333333333333, function() -- Line: 825
            -- upvalues: hide (copy), u125 (copy)
            hide(1);
            u125:Add(function() -- Line: 827
                -- upvalues: hide (ref)
                hide(0);
            end);
        end));
    end;
end;

local u131 = {
    DashL = {
        push = 1.1666666666666667,
        arrive = 1.5666666666666667
    },
    DashR = {
        push = 1.1,
        arrive = 1.5
    }
};
local u132 = {};

local function wheels_ui_hold(u133: any, p134: number) -- Line: 852
    -- upvalues: u132 (copy)
    local u135 = u132[u133];

    if not u135 then
        return;
    end;

    if u135.thread then
        pcall(task.cancel, u135.thread);
    end;

    u135.thread = task.delay(p134, function() -- Line: 860
        -- upvalues: u132 (ref), u133 (copy), u135 (copy)
        if u132[u133] == u135 then
            u132[u133] = nil;
        end;

        u135.trove:Destroy();
    end);
end;

local function wheels_ui_close(p136) -- Line: 868
    -- upvalues: u132 (copy)
    local v137 = u132[p136];

    if not v137 then
        return;
    end;

    u132[p136] = nil;

    if v137.thread then
        pcall(task.cancel, v137.thread);
    end;

    v137.trove:Destroy();
end;

local function wheels_ui_start(p138: any, p139: userdata, p140: number, p141: any) -- Line: 880
    -- upvalues: u132 (copy), u6 (copy), wheels_ui_hold (copy), show_move_ui (copy)
    local v142 = u132[p138];

    if v142 then
        if v142.thread then
            pcall(task.cancel, v142.thread);
        end;

        v142.trove:Destroy();
    end;

    local v143 = u6.new();
    v143:AttachToInstance(p138);
    u132[p138] = {
        trove = v143
    };
    wheels_ui_hold(p138, p140);
    task.spawn(show_move_ui, v143, p138, p139, p141);
end;

local function wheels_lerp_to(p144: any, u145: userdata, u146: vector) -- Line: 895
    -- upvalues: RunService (copy)
    local u148 = p144:Add(RunService.RenderStepped:Connect(function(p147) -- Line: 896
        -- upvalues: u145 (copy), u146 (copy)
        if not u145:IsDescendantOf(game) then
            return;
        end;

        u145.CFrame = u145.CFrame:Lerp(CFrame.new(u146, u146 + u145.CFrame.LookVector), math.min(p147, 0.03333333333333333) * 10);
    end));
    p144:Add(task.delay(0.4, function() -- Line: 902
        -- upvalues: u148 (copy)
        u148:Disconnect();
    end));
end;

local function wheels_target(p149: userdata, p150: vector) -- Line: 907
    -- upvalues: u5 (copy)
    local v151 = u5(p149.Position, p150);

    if v151 then
        return v151.Position;
    end;

    return p149.Position + p150;
end;

local function wheels_dash_offset(p152: userdata, p153: userdata) -- Line: 912
    local path = p152:FindFirstChild("path");

    if not path then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0);
    end;

    local v154 = p153.CFrame:ToObjectSpace(path.CFrame);
    local v155 = v154 * Vector3.new(0, 0, path.Size.Z / 2);
    local v156 = v154 * Vector3.new(0, 0, -path.Size.Z / 2);

    if v155.Z > v156.Z then
        v156 = v155;
    end;

    local Vector3_new_ret = Vector3.new(-v156.X, 0, -v156.Z);

    return (Vector3_new_ret.Magnitude <= 0 and Vector3.new(0, 0, 0) or Vector3_new_ret.Unit) * 32, Vector3_new_ret;
end;

local function wheels_travel(p157: any, u158: userdata, u159: vector, u160: vector, u161: number) -- Line: 926
    -- upvalues: RunService (copy), TweenService (copy)
    local u162 = 0;
    local u163 = nil;
    u163 = p157:Add(RunService.RenderStepped:Connect(function(p164) -- Line: 929
        -- upvalues: u158 (copy), u162 (ref), u161 (copy), TweenService (ref), u159 (copy), u160 (copy), u163 (ref)
        if not u158:IsDescendantOf(game) then
            return;
        end;

        u162 = math.min(u162 + p164, u161);
        local v165 = u159:Lerp(u160, (TweenService:GetValue(u162 / u161, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)));
        local CFrame2 = u158.CFrame;
        u158.CFrame = CFrame2.Rotation + Vector3.new(v165.X, CFrame2.Position.Y, v165.Z);
        u158.AssemblyLinearVelocity = Vector3.new(0, u158.AssemblyLinearVelocity.Y, 0);

        if u161 <= u162 then
            u163:Disconnect();
        end;
    end));
end;

local function wheels_phase(p166: any, p167: userdata, p168: number) -- Line: 945
    -- upvalues: u2 (copy), RunService (copy), u3 (copy)
    local Root = u2.getRoot(p166);
    local v169 = u2.character_trove(p166);
    local WheelsIndustry = u2.getResources().roland.WheelsIndustry;
    local u170 = v169:Clone(WheelsIndustry.VFX);
    u170.Parent = workspace.Effects;
    v169:Add(RunService.RenderStepped:Connect(function() -- Line: 952
        -- upvalues: u170 (copy), Root (copy)
        if u170 then
            u170:PivotTo(Root.CFrame);
        end;
    end));
    v169:Add(u3:loadAnimation(p166, p167.Animation), "Stop"):Play(0);
    v169:Add(task.delay(p168, v169.Destroy, v169));

    return v169, Root, u170, WheelsIndustry;
end;

local function wheels_rig(p171: any, p172: any, p173: any, p174: boolean?) -- Line: 964
    -- upvalues: u2 (copy)
    local buildFromRig = u2.buildFromRig;
    local v175;

    if p172:GetAttribute("RinNoPlay") then
        v175 = p173.RigRNP;
    else
        v175 = p173.Rig;
    end;

    local v176, v177 = buildFromRig(p172, v175);
    p171:Add(v176);

    for _, v in v177 do
        if v:IsA("BasePart") and v.Name ~= "WheelsVFX" then
            if v:GetAttribute("BaseTransparency") == nil then
                v:SetAttribute("BaseTransparency", v.Transparency);
            end;

            v.Transparency = p174 and (v:GetAttribute("BaseTransparency") or 0) or 1;
        end;
    end;
end;

function v7.roland_wheels_dash(p178: any, p179: boolean, u180) -- Line: 977
    -- upvalues: u2 (copy), u131 (copy), wheels_dash_offset (copy), u5 (copy), RunService (copy), u3 (copy), wheels_ui_start (copy), u8 (copy), set_move_status (copy)
    local Root = u2.getRoot(p178);
    local v181 = u2.character_trove(p178);
    local WheelsIndustry = u2.getResources().roland.WheelsIndustry;
    local v182 = p179 and "DashL" or "DashR";
    local v183 = WheelsIndustry[v182];
    local v184 = u131[v182];
    local v185 = v181:Clone(WheelsIndustry.VFX);
    local v186 = CFrame.new(Root.Position) * u180.Rotation;
    Root.CFrame = v186;
    local v187, v188 = wheels_dash_offset(v185[v182], v185.Root);
    local v189 = v186:VectorToWorldSpace(v187);
    local v190 = u5(Root.Position, v189);
    local v191;

    if v190 then
        v191 = v190.Position;
    else
        v191 = Root.Position + v189;
    end;

    local _ = v186.Rotation + Vector3.new(v191.X, v186.Position.Y, v191.Z);

    for _, descendant in v185:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    v185:PivotTo(v186);
    local v192 = v185[v182];
    v192:PivotTo((v186 + v186:VectorToWorldSpace(v188)) * v186:ToObjectSpace(v192:GetPivot()));
    v185.Parent = workspace.Effects;
    local Ball = p178:FindFirstChild("Ball");

    if Ball then
        Ball = Ball:FindFirstChild("ball");
    end;

    if Ball and Ball:IsA("Motor6D") then
        local C0 = Ball.C0;
        Ball.C0 = CFrame.new(C0.Position) * CFrame.fromOrientation(0, -1.5707963267948966, 0);
        v181:Add(function() -- Line: 1007
            -- upvalues: Ball (copy), C0 (copy)
            if Ball.Parent then
                Ball.C0 = C0;
            end;
        end);
    end;

    if u2.isLocalPlayer(p178) then
        local u193 = p178:FindFirstChildOfClass("Humanoid");
        u193.AutoRotate = false;
        local u194 = false;
        local u195 = nil;
        u195 = v181:Add(RunService.RenderStepped:Connect(function() -- Line: 1019
            -- upvalues: Root (copy), u194 (ref), u195 (ref), u193 (copy), u180 (copy)
            local wheelsIndustryFacing = Root:FindFirstChild("wheelsIndustryFacing");
            u194 = u194 or wheelsIndustryFacing ~= nil;

            if not u194 or wheelsIndustryFacing then
                Root.CFrame = CFrame.new(Root.Position) * u180.Rotation;

                return;
            end;

            u195:Disconnect();
            u193.AutoRotate = true;
        end));
        v181:Add(function() -- Line: 1029
            -- upvalues: u193 (copy)
            u193.AutoRotate = true;
        end);
    end;

    v181:Add(u3:loadAnimation(p178, v183.Animation), "Stop"):Play(0);
    u2.execute_compiled(v183.Compiled, v181, v185, p178);
    v181:Add(task.delay(2, v181.Destroy, v181));
    wheels_ui_start(p178, Root, 2, u8.WheelsIndustry);
    v181:Add(task.delay(v184.push, set_move_status, p178, 1));
end;

function v7.roland_wheels_slam(p196) -- Line: 1043
    -- upvalues: u2 (copy), wheels_phase (copy), wheels_ui_hold (copy), set_move_status (copy), wheels_rig (copy)
    local WheelsIndustry = u2.getResources().roland.WheelsIndustry;
    local v197, _, v198 = wheels_phase(p196, WheelsIndustry.Slam, 3.3);
    wheels_ui_hold(p196, 3.3);
    v197:Add(task.delay(1.7, set_move_status, p196, 2));
    wheels_rig(v197, p196, WheelsIndustry);
    u2.execute_compiled(WheelsIndustry.Slam.Compiled, v197, v198, p196);
end;

function v7.roland_wheels_lunge(u199) -- Line: 1052
    -- upvalues: u2 (copy), wheels_phase (copy), wheels_ui_hold (copy), set_move_status (copy), wheels_rig (copy), u132 (copy), RunService (copy)
    local WheelsIndustry = u2.getResources().roland.WheelsIndustry;
    local v200, u201, v202 = wheels_phase(u199, WheelsIndustry.Lunge, 3);
    wheels_ui_hold(u199, 3.4);
    set_move_status(u199, 3);
    wheels_rig(v200, u199, WheelsIndustry, true);
    u2.execute_compiled(WheelsIndustry.Lunge.Compiled, v200, v202, u199);
    local u203 = os.clock() + 3 - 0.05;
    v200:Add(function() -- Line: 1061
        -- upvalues: u203 (copy), u199 (copy), u132 (ref)
        if os.clock() < u203 then
            local v204 = u199;
            local v205 = u132[v204];

            if not v205 then
                return;
            end;

            u132[v204] = nil;

            if v205.thread then
                pcall(task.cancel, v205.thread);
            end;

            v205.trove:Destroy();
        end;
    end);
    local u206 = require("@game/ReplicatedStorage/client/replication/mainreplication").bodyVelocity(u201, 1, 0.16, nil, nil, true);

    if u206 then
        u206.MaxForce = Vector3.new(300000, 300000, 300000);
        v200:Add(RunService.RenderStepped:Connect(function() -- Line: 1071
            -- upvalues: u206 (copy), u201 (copy)
            if u206:IsDescendantOf(game) then
                u206.Velocity = u201.CFrame.LookVector * 190 + u201.CFrame.UpVector * 20;
            end;
        end));
    end;
end;

function v7.roland_wheels_drop(p207) -- Line: 1079
    -- upvalues: u2 (copy), u5 (copy), wheels_lerp_to (copy)
    local Root = u2.getRoot(p207);
    local v208 = u2.character_trove(p207);
    local v209 = p207:FindFirstChildOfClass("Humanoid");
    local LookVector = Root.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
    local v210 = (Vector3_new_ret.Magnitude <= 0 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit) * 85;
    local v211 = u5(Root.Position, v210);
    local v212;

    if v211 then
        v212 = v211.Position;
    else
        v212 = Root.Position + v210;
    end;

    local v213 = u5(v212, Vector3.new(0, -200, 0));

    if v213 then
        v212 = Vector3.new(v212.X, v213.Position.Y + (Root.Size.Y / 2 + (not v209 and 2 or v209.HipHeight)), v212.Z);
    end;

    if u2.isLocalPlayer(p207) then
        wheels_lerp_to(v208, Root, v212);
    end;

    v208:Add(task.delay(0.4, v208.Destroy, v208));
end;

local CFrame_Angles_ret = CFrame.Angles(0, 3.141592653589793, 0);

function v7.roland_allas_burst(p214) -- Line: 1101
    -- upvalues: u2 (copy), u70 (copy), set_move_status (copy), CFrame_Angles_ret (copy)
    local Root = u2.getRoot(p214);
    local BurstVFX = u2.getResources().roland.AllasWorkshop:FindFirstChild("BurstVFX");

    if not (Root and BurstVFX) then
        return;
    end;

    u70[p214] = (u70[p214] or 0) + 1;
    set_move_status(p214, u70[p214]);
    local v215 = BurstVFX:Clone();
    v215:PivotTo(Root.CFrame * CFrame_Angles_ret);
    v215.Parent = workspace.Effects;
    shared.vfx.emit(v215);
    task.delay(3, v215.Destroy, v215);
end;

local TweenInfo_new_ret8 = TweenInfo.new(0.85, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u216 = {};

local function ranga_phase(p217: any, p218: userdata, p219: number) -- Line: 1127
    -- upvalues: u2 (copy), RunService (copy), u3 (copy)
    local Root = u2.getRoot(p217);
    local v220 = u2.character_trove(p217);
    local ZelkovaCounter = u2.getResources().roland.ZelkovaCounter;
    local u221 = v220:Clone(ZelkovaCounter.VFX);
    u221.Parent = workspace.Effects;
    v220:Add(RunService.RenderStepped:Connect(function() -- Line: 1134
        -- upvalues: u221 (copy), Root (copy)
        if u221 then
            u221:PivotTo(Root.CFrame);
        end;
    end));
    v220:Add((u2.buildFromRig(p217, ZelkovaCounter.Rig)));
    v220:Add(u3:loadAnimation(p217, p218.Animation), "Stop"):Play(0);
    v220:Add(task.delay(p219, v220.Destroy, v220));

    return v220, Root, u221, ZelkovaCounter;
end;

function v7.roland_ranga_start(u222) -- Line: 1149
    -- upvalues: u2 (copy), ranga_phase (copy), u6 (copy), u216 (copy), show_move_ui (copy), u8 (copy)
    local ZelkovaCounter = u2.getResources().roland.ZelkovaCounter;
    local u223, v224, v225 = ranga_phase(u222, ZelkovaCounter.Start, 1.25);
    local u226 = u6.new();
    u226:AttachToInstance(u222);
    u216[u222] = {
        container = u223,
        ui = u226
    };
    u223:Add(function() -- Line: 1156
        -- upvalues: u216 (ref), u222 (copy), u223 (copy), u226 (copy)
        local v227 = u216[u222];

        if v227 and v227.container == u223 then
            u216[u222] = nil;
            u226:Destroy();
        end;
    end);
    u2.execute_compiled(ZelkovaCounter.Start.Compiled, u223, v225, u222);
    task.spawn(show_move_ui, u226, u222, v224, u8.ZelkovaCounter);
end;

function v7.roland_ranga_hit(p228, p229) -- Line: 1168
    -- upvalues: u2 (copy), u216 (copy), ranga_phase (copy), u6 (copy), show_move_ui (copy), u8 (copy), u3 (copy), Lighting (copy), TweenService (copy), TweenInfo_new_ret8 (copy), set_move_status (copy), BackgroundHighlight (copy)
    local ZelkovaCounter = u2.getResources().roland.ZelkovaCounter;
    local v230 = u216[p228];
    u216[p228] = nil;

    if v230 then
        v230.container:Destroy();
    end;

    local v231, v232, v233 = ranga_phase(p228, ZelkovaCounter.Hit, 4.716666666666667);

    if v230 then
        v230 = v230.ui;
    end;

    if not v230 then
        v230 = u6.new();
        task.spawn(show_move_ui, v230, p228, v232, u8.ZelkovaCounter);
    end;

    v231:Add(v230);
    v231:Add((u2.buildFromRig(p229, ZelkovaCounter.VictimRig)));
    local v234 = v231:Add(u3:loadAnimation(p229, ZelkovaCounter.Hit.Victim), "Stop");
    v234:Play(0);
    v231:Add(task.delay(1.8666666666666667, v234.Stop, v234, 0));
    local v235 = v231:Clone(ZelkovaCounter.ColorCorrection);
    v235.Parent = Lighting;
    TweenService:Create(v235, TweenInfo_new_ret8, {
        Brightness = 0
    }):Play();
    v231:Add(task.delay(1, set_move_status, p228, 1));
    v231:Add(task.delay(1.8666666666666667, set_move_status, p228, 2));
    v231:Add(task.delay(3.7, BackgroundHighlight, {
        ImageTransparency = 0.7,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.07,
        Count = 14,
        Whitelist = { p228 },
        Color = Color3.fromRGB(1000, 1000, 1000),
        Color2 = Color3.fromRGB(255, 255, 255)
    }));
    u2.execute_compiled(ZelkovaCounter.Hit.Compiled, v231, v233, p228, p229);
end;

local u236 = {};

local function durandal_phase(u237: any, p238: userdata, p239: number) -- Line: 1227
    -- upvalues: u2 (copy), roland (copy), RunService (copy), u236 (copy), u3 (copy)
    local Root = u2.getRoot(u237);
    local v240 = u2.character_trove(u237);
    local u241 = roland.Durandal.VFX:Clone();

    if not u2.isLocalPlayer(u237) then
        for _, descendant in u241:GetDescendants() do
            if descendant.Name == "ShakeOnce" or descendant.Name == "Misc" then
                descendant:Destroy();
            end;
        end;
    end;

    u241:PivotTo(Root.CFrame);
    u241.Parent = workspace.Effects;
    task.delay(p239 + 2, u241.Destroy, u241);
    v240:Add(RunService.RenderStepped:Connect(function() -- Line: 1242
        -- upvalues: u241 (copy), Root (copy)
        u241:PivotTo(Root.CFrame);
    end));
    local v242 = u236[u237];
    local u243 = {
        container = v240,
        vfx = u241
    };
    u236[u237] = u243;

    if v242 then
        v242.container:Destroy();
    end;

    v240:Add(function() -- Line: 1252
        -- upvalues: u236 (ref), u237 (copy), u243 (copy)
        if u236[u237] == u243 then
            u236[u237] = nil;
        end;
    end);
    v240:Add(u3:loadAnimation(u237, p238.Animation), "Stop"):Play(0);
    u2.execute_compiled(p238.Compiled, v240, u241, u237);
    v240:Add(task.delay(p239, v240.Destroy, v240));

    return v240, Root;
end;

function v7.roland_sever_kick(p244) -- Line: 1265
    -- upvalues: durandal_phase (copy), roland (copy), wheels_ui_start (copy), u8 (copy), set_move_status (copy)
    local v245, v246 = durandal_phase(p244, roland.Durandal.Kick, 0.7);
    wheels_ui_start(p244, v246, 3.7, u8.DurandalSever);
    v245:Add(task.delay(0.36666666666666664, set_move_status, p244, 1));
end;

function v7.roland_sever_slide(p247) -- Line: 1271
    -- upvalues: durandal_phase (copy), roland (copy), wheels_ui_hold (copy), set_move_status (copy)
    durandal_phase(p247, roland.Durandal.Slide, 1.9666666666666666);
    wheels_ui_hold(p247, 1.9666666666666666);
    set_move_status(p247, 2);
end;

function v7.roland_sever_control(p248) -- Line: 1277
    -- upvalues: u236 (copy)
    local v249 = u236[p248].vfx.Root.control:Clone();
    v249.CFrame = CFrame.identity;
    v249.Parent = p248.Ball;
    shared.vfx.emit(v249);
    task.delay(2, v249.Destroy, v249);
end;

function v7.roland_sever_feint(p250) -- Line: 1285
    -- upvalues: durandal_phase (copy), roland (copy), wheels_ui_hold (copy)
    durandal_phase(p250, roland.Durandal.Feint, 1.8833333333333333);
    wheels_ui_hold(p250, 1.8833333333333333);
end;

function v7.roland_sever_shot(p251) -- Line: 1290
    -- upvalues: durandal_phase (copy), roland (copy), u2 (copy), wheels_ui_hold (copy), set_move_status (copy)
    local v252 = durandal_phase(p251, roland.Durandal.Shot, 4.166666666666667);
    v252:Add((u2.buildFromRig(p251, roland.Durandal.Rig)));
    wheels_ui_hold(p251, 4.166666666666667);
    v252:Add(task.delay(3.183333333333333, set_move_status, p251, 3));
end;

function v7.roland_breakthrough(p253) -- Line: 1297
    -- upvalues: durandal_phase (copy), roland (copy), u2 (copy), show_move_ui (copy), u8 (copy), set_move_status (copy)
    local v254, v255 = durandal_phase(p253, roland.Durandal.Breakthrough, 1.8333333333333333);
    v254:Add((u2.buildFromRig(p253, roland.Durandal.Rig)));
    task.spawn(show_move_ui, v254, p253, v255, u8.DurandalBreakthrough);
    v254:Add(task.delay(0.7, set_move_status, p253, 1));
    v254:Add(task.delay(0.95, set_move_status, p253, 2));
end;

local u256 = {};

function v7.roland_pistols(u257: any, p258: boolean) -- Line: 1313
    -- upvalues: u2 (copy), u256 (copy), roland (copy), RunService (copy), u3 (copy), show_move_ui (copy), u8 (copy), set_move_status (copy)
    local Root = u2.getRoot(u257);
    local u259 = u2.character_trove(u257);
    local v260 = u256[u257];
    u256[u257] = u259;

    if v260 then
        v260:Destroy();
    end;

    u259:Add(function() -- Line: 1322
        -- upvalues: u256 (ref), u257 (copy), u259 (copy)
        if u256[u257] == u259 then
            u256[u257] = nil;
        end;
    end);
    local AtelierPistols = roland.AtelierPistols;
    local v261 = AtelierPistols[p258 and "Fire" or "Miss"];
    local v262 = p258 and 2.5 or 2.3333333333333335;
    local u263 = AtelierPistols.VFX:Clone();
    u263:PivotTo(Root.CFrame);
    u263.Parent = workspace.Effects;
    task.delay(v262 + 2, u263.Destroy, u263);
    u259:Add(RunService.RenderStepped:Connect(function() -- Line: 1335
        -- upvalues: u263 (copy), Root (copy)
        u263:PivotTo(Root.CFrame);
    end));
    u259:Add((u2.buildFromRig(u257, AtelierPistols.Rig)));
    u259:Add(u3:loadAnimation(u257, v261.Animation), "Stop"):Play(0);
    u2.execute_compiled(v261.Compiled, u259, u263, u257);
    u259:Add(task.delay(v262, u259.Destroy, u259));
    task.spawn(show_move_ui, u259, u257, Root, u8.AtelierPistols);
    set_move_status(u257, 1);
end;

function v7.roland_pistols_lock(p264: any, p265: number) -- Line: 1348
    -- upvalues: u2 (copy), roland (copy), RunService (copy), set_move_status (copy)
    local v266 = u2.character_trove(p264);
    local u267 = v266:Clone(roland.AtelierPistols.Ball);
    u267.Impact:Destroy();

    local function follow() -- Line: 1353
        -- upvalues: u267 (copy)
        local Ball = workspace.Terrain:FindFirstChild("Ball");

        if Ball then
            u267.Position = Ball.Position;
        end;
    end;

    local Ball = workspace.Terrain:FindFirstChild("Ball");

    if Ball then
        u267.Position = Ball.Position;
    end;

    u267.Parent = workspace.Effects;
    v266:Add(RunService.RenderStepped:Connect(follow));
    v266:Add(task.delay(p265, v266.Destroy, v266));
    shared.vfx.emit(u267.LockOn);
    set_move_status(p264, 2);
end;

function v7.roland_pistols_freeze(p268: any, p269: number) -- Line: 1368
    -- upvalues: u1 (copy), u2 (copy), roland (copy)
    local v270 = require("@game/ReplicatedStorage/client/replication/mainreplication");
    v270.hitstopflash(p269, 0.3);
    v270.highlight(p268, Color3.new(1, 1, 1), p269, true, 0);
    u1:play(u2.getResources().hitstop, u2.getRoot(p268));
    local v271 = roland.AtelierPistols.Ball.FlashImpact:Clone();
    v271.Adornee = workspace.Terrain:FindFirstChild("Ball");
    v271.Enabled = true;
    v271.Parent = workspace.Effects;
    task.delay(p269, v271.Destroy, v271);
end;

function v7.roland_pistols_explode(p272: any, p273: vector) -- Line: 1381
    -- upvalues: roland (copy), set_move_status (copy)
    local v274 = roland.AtelierPistols.Ball:Clone();
    v274.LockOn:Destroy();
    v274.FlashImpact:Destroy();
    v274.Position = p273;
    v274.Parent = workspace.Effects;
    task.delay(10, v274.Destroy, v274);
    local FlashImpact = v274.Impact.FlashImpact;
    FlashImpact.Enabled = true;
    task.delay(0.1, function() -- Line: 1391
        -- upvalues: FlashImpact (copy)
        FlashImpact.Enabled = false;
    end);
    shared.vfx.emit(v274.Impact);
    set_move_status(p272, 3);
end;

local u275 = {};

local function stance_phase(u276: any, p277: userdata, p278: userdata, p279: number, p280: number?) -- Line: 1410
    -- upvalues: u2 (copy), RunService (copy), u275 (copy), u3 (copy)
    local Root = u2.getRoot(u276);
    local v281 = u2.character_trove(u276);
    local u282 = p277.VFX:Clone();
    u282:PivotTo(Root.CFrame);
    u282.Parent = workspace.Effects;
    task.delay(p279 + 2, u282.Destroy, u282);
    v281:Add(RunService.RenderStepped:Connect(function() -- Line: 1418
        -- upvalues: u282 (copy), Root (copy)
        u282:PivotTo(Root.CFrame);
    end));
    local v283 = u275[u276];
    local u284 = {
        container = v281,
        vfx = u282
    };
    u275[u276] = u284;

    if v283 then
        v283.container:Destroy();
        v283.vfx:Destroy();
    end;

    v281:Add(function() -- Line: 1429
        -- upvalues: u275 (ref), u276 (copy), u284 (copy)
        if u275[u276] == u284 then
            u275[u276] = nil;
        end;
    end);
    v281:Add((u2.buildFromRig(u276, p277.Rig)));
    local v285 = v281:Add(u3:loadAnimation(u276, p278.Animation), "Stop");
    v285:Play(0, 1, p280 or 1);
    u2.execute_compiled_ex(p278.Compiled, v281, 60 * (p280 or 1), u282, u276);
    v281:Add(task.delay(p279, v281.Destroy, v281));

    return v281, Root, v285;
end;

function v7.roland_reversal(u286) -- Line: 1444
    -- upvalues: stance_phase (copy), roland (copy), u3 (copy), wheels_ui_start (copy), u8 (copy), set_move_status (copy)
    local u287, v288 = stance_phase(u286, roland.CrystalAtelier, roland.CrystalAtelier.Windup, 2.8, 1.5);

    for _, v in { u286.RightHandle, u286.LeftHandle } do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 1;
            end;
        end;
    end;

    u287:Add(task.delay(0.8, function() -- Line: 1453
        -- upvalues: u287 (copy), u3 (ref), u286 (copy), roland (ref)
        u287:Add(u3:loadAnimation(u286, roland.CrystalAtelier.Idle.Animation), "Stop"):Play(0);
    end));
    wheels_ui_start(u286, v288, 2.8, u8.CrystalReversal);
    set_move_status(u286, 1);
end;

function v7.roland_reversal_hit(p289) -- Line: 1461
    -- upvalues: stance_phase (copy), roland (copy), wheels_ui_hold (copy), set_move_status (copy)
    local v290 = stance_phase(p289, roland.CrystalAtelier, roland.CrystalAtelier.Hit, 1.0333333333333334);
    wheels_ui_hold(p289, 1.0333333333333334);
    set_move_status(p289, 2);
    v290:Add(task.delay(0.6333333333333333, set_move_status, p289, 3));
end;

function v7.roland_reversal_parry(p291) -- Line: 1468
    -- upvalues: stance_phase (copy), roland (copy), wheels_ui_hold (copy), set_move_status (copy)
    stance_phase(p291, roland.CrystalAtelier, roland.CrystalAtelier.Parry, 1.9);
    wheels_ui_hold(p291, 1.9);
    set_move_status(p291, 3);
end;

function v7.roland_reversal_miss(p292) -- Line: 1474
    -- upvalues: stance_phase (copy), roland (copy), wheels_ui_hold (copy)
    stance_phase(p292, roland.CrystalAtelier, roland.CrystalAtelier.Miss, 0.6666666666666666);
    wheels_ui_hold(p292, 0.6666666666666666);
end;

local u293 = {};

local function waltz_phase(u294: any, p295: userdata, p296: number) -- Line: 1491
    -- upvalues: u2 (copy), u293 (copy), roland (copy), u3 (copy)
    local u297 = u2.character_trove(u294);
    local v298 = u293[u294];
    u293[u294] = u297;

    if v298 then
        v298:Destroy();
    end;

    u297:Add(function() -- Line: 1498
        -- upvalues: u293 (ref), u294 (copy), u297 (copy)
        if u293[u294] == u297 then
            u293[u294] = nil;
        end;
    end);
    u297:Add((u2.buildFromRig(u294, roland.CrystalAtelier.Waltz.Rig)));
    u297:Add(u3:loadAnimation(u294, p295), "Stop"):Play(0);
    u297:Add(task.delay(p296, u297.Destroy, u297));

    return u297;
end;

function v7.roland_waltz(u299) -- Line: 1510
    -- upvalues: roland (copy), u2 (copy), waltz_phase (copy), u3 (copy), wheels_ui_start (copy), u8 (copy), set_move_status (copy)
    local Waltz = roland.CrystalAtelier.Waltz;
    local Root = u2.getRoot(u299);
    local u300 = waltz_phase(u299, Waltz.Animations.Start, 5);
    u300:Add(task.delay(0.5833333333333334, function() -- Line: 1515
        -- upvalues: u300 (copy), u3 (ref), u299 (copy), Waltz (copy)
        u300:Add(u3:loadAnimation(u299, Waltz.Animations.Idle, 0.1, nil, true), "Stop"):Play(0.1);
    end));
    local WaltzCharge = u299.WaltzCharge;
    u300:Add(task.spawn(function() -- Line: 1520
        -- upvalues: WaltzCharge (copy)
        while true do
            shared.vfx.emit(WaltzCharge);
            task.wait(1);
        end;
    end));
    wheels_ui_start(u299, Root, 5, u8.CrystalWaltz);
    set_move_status(u299, 1);
end;

function v7.roland_waltz_pass(p301) -- Line: 1531
    -- upvalues: roland (copy), waltz_phase (copy), u2 (copy), wheels_ui_hold (copy), set_move_status (copy)
    local Waltz = roland.CrystalAtelier.Waltz;
    local v302 = waltz_phase(p301, Waltz.Animations.Pass, 3.8333333333333335);
    u2.execute_compiled(Waltz.PassCompiled, v302, p301);
    wheels_ui_hold(p301, 3.8333333333333335);
    v302:Add(task.delay(0.8333333333333334, set_move_status, p301, 2));
    v302:Add(task.delay(2.316666666666667, set_move_status, p301, 3));
end;

function v7.roland_waltz_shot(p303) -- Line: 1540
    -- upvalues: roland (copy), waltz_phase (copy), u2 (copy), wheels_ui_hold (copy), set_move_status (copy)
    local Waltz = roland.CrystalAtelier.Waltz;
    local v304 = waltz_phase(p303, Waltz.Animations.Feint, 2.5);
    u2.execute_compiled(Waltz.FeintCompiled, v304, p303);
    wheels_ui_hold(p303, 2.5);
    v304:Add(task.delay(1.5, set_move_status, p303, 2));
    v304:Add(task.delay(1.6666666666666667, set_move_status, p303, 3));
end;

function v7.roland_waltz_mark(p305: any, p306: number) -- Line: 1549
    -- upvalues: roland (copy)
    local v307 = roland.CrystalAtelier.Waltz.PassMark:Clone();
    v307.Parent = p305.Torso;

    for _, child in v307:GetChildren() do
        child:Emit(child:GetAttribute("EmitCount"));
        child.Enabled = true;
    end;

    task.delay(p306, v307.Destroy, v307);
end;

function v7.roland_quickdraw(p308) -- Line: 1566
    -- upvalues: stance_phase (copy), roland (copy), wheels_ui_start (copy), u8 (copy), set_move_status (copy)
    local v309, v310, v311 = stance_phase(p308, roland.MookWorkshop, roland.MookWorkshop.Start, 2.5);
    v309:Add(task.delay(0.9833333333333333, v311.AdjustSpeed, v311, 0));
    wheels_ui_start(p308, v310, 2.5, u8.MookQuickdraw);
    set_move_status(p308, 1);
end;

function v7.roland_quickdraw_tp(p312) -- Line: 1573
    -- upvalues: stance_phase (copy), roland (copy), wheels_ui_hold (copy), set_move_status (copy)
    stance_phase(p312, roland.MookWorkshop, roland.MookWorkshop.TP, 0.75);
    wheels_ui_hold(p312, 0.75);
    set_move_status(p312, 2);
end;

function v7.roland_quickdraw_miss(p313) -- Line: 1579
    -- upvalues: stance_phase (copy), roland (copy), wheels_ui_hold (copy)
    stance_phase(p313, roland.MookWorkshop, roland.MookWorkshop.Miss, 0.5333333333333333);
    wheels_ui_hold(p313, 0.5333333333333333);
end;

function v7.roland_quickdraw_hit(p314) -- Line: 1584
    -- upvalues: roland (copy), u2 (copy)
    local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
    local u315 = roland.MookWorkshop.Hit:Clone();
    u315.Parent = u2.getRoot(p314);
    task.delay(2, u315.Destroy, u315);
    u315.hitflash.Enabled = true;
    task.delay(0.1, function() -- Line: 1591
        -- upvalues: u315 (copy)
        u315.hitflash.Enabled = false;
    end);
    Part_Icles:AbsoluteEmit(u315);
end;

local u316 = {};

local function angelica_hidden() -- Line: 1605
    -- upvalues: u2 (copy)
    local Hotbar = u2.getPlayerGui():FindFirstChild("Hotbar");
    local v317;

    if Hotbar == nil then
        v317 = false;
    else
        v317 = Hotbar:GetAttribute("sceneEnabled") == true;
    end;

    return v317;
end;

local function angelica_apply(p318: userdata, p319: boolean) -- Line: 1610
    local Attribute = p318:GetAttribute("BaseTransparency");

    if Attribute then
        p318.Transparency = p319 and 1 or Attribute;

        return;
    end;

    if p318:GetAttribute("BaseEnabled") then
        p318.Enabled = not p319;
    end;
end;

local function angelica_track(u320: userdata) -- Line: 1619
    -- upvalues: u2 (copy)
    local v321 = u320:GetAttribute("BaseTransparency") and "Transparency" or (u320:GetAttribute("BaseEnabled") and "Enabled" or nil);

    if v321 then
        u320:GetPropertyChangedSignal(v321):Connect(function() -- Line: 1622
            -- upvalues: u320 (copy), u2 (ref)
            local v322 = u320;
            local Hotbar = u2.getPlayerGui():FindFirstChild("Hotbar");
            local v323;

            if Hotbar == nil then
                v323 = false;
            else
                v323 = Hotbar:GetAttribute("sceneEnabled") == true;
            end;

            local Attribute = v322:GetAttribute("BaseTransparency");

            if Attribute then
                v322.Transparency = v323 and 1 or Attribute;

                return;
            end;

            if v322:GetAttribute("BaseEnabled") then
                v322.Enabled = not v323;
            end;
        end);
        local Hotbar = u2.getPlayerGui():FindFirstChild("Hotbar");
        local v324;

        if Hotbar == nil then
            v324 = false;
        else
            v324 = Hotbar:GetAttribute("sceneEnabled") == true;
        end;

        local Attribute = u320:GetAttribute("BaseTransparency");

        if Attribute then
            u320.Transparency = v324 and 1 or Attribute;

            return;
        end;

        if u320:GetAttribute("BaseEnabled") then
            u320.Enabled = not v324;
        end;
    end;
end;

local function angelica_refresh() -- Line: 1629
    -- upvalues: u2 (copy), CollectionService (copy)
    local Hotbar = u2.getPlayerGui():FindFirstChild("Hotbar");
    local v325;

    if Hotbar == nil then
        v325 = false;
    else
        v325 = Hotbar:GetAttribute("sceneEnabled") == true;
    end;

    for _, v in CollectionService:GetTagged("RolandAngelica") do
        for _, descendant in v:GetDescendants() do
            local Attribute = descendant:GetAttribute("BaseTransparency");

            if Attribute then
                descendant.Transparency = v325 and 1 or Attribute;
            elseif descendant:GetAttribute("BaseEnabled") then
                descendant.Enabled = not v325;
            end;
        end;
    end;
end;

local function angelica_added(p326: userdata) -- Line: 1638
    -- upvalues: angelica_track (copy), u316 (copy)
    p326.DescendantAdded:Connect(angelica_track);

    for _, descendant in p326:GetDescendants() do
        angelica_track(descendant);
    end;

    local v327 = p326.Parent and p326.Parent:FindFirstChild("HumanoidRootPart");
    local v328;

    if v327 then
        v328 = v327:FindFirstChild("Stand2Human");
    else
        v328 = v327;
    end;

    if v328 then
        u316[p326] = {
            offset = Vector3.new(0, 0, 0),
            root = v327,
            motor = v328,
            base = v328.C0
        };
    end;
end;

CollectionService:GetInstanceAddedSignal("RolandAngelica"):Connect(angelica_added);
CollectionService:GetInstanceRemovedSignal("RolandAngelica"):Connect(function(p329) -- Line: 1658
    -- upvalues: u316 (copy)
    u316[p329] = nil;
end);

local function angelica_watch(p330: userdata) -- Line: 1651
    -- upvalues: angelica_refresh (copy)
    if p330.Name == "Hotbar" then
        p330:GetAttributeChangedSignal("sceneEnabled"):Connect(angelica_refresh);
    end;
end;

for _, v in CollectionService:GetTagged("RolandAngelica") do
    angelica_added(v);
end;

u2.getPlayerGui().ChildAdded:Connect(angelica_watch);

for _, child in u2.getPlayerGui():GetChildren() do
    if child.Name == "Hotbar" then
        child:GetAttributeChangedSignal("sceneEnabled"):Connect(angelica_refresh);
    end;
end;

RunService.RenderStepped:Connect(function(p331) -- Line: 1669
    -- upvalues: u316 (copy)
    local v332 = 1 - math.exp(-6 * p331);

    for _, v in u316 do
        local v333 = -v.root.CFrame:VectorToObjectSpace(v.root.AssemblyLinearVelocity) * 0.06;

        if v333.Magnitude > 2.5 then
            v333 = v333.Unit * 2.5;
        end;

        v.offset = v.offset:Lerp(v333, v332);
        v.motor.C0 = v.base * CFrame.new(v.offset) * CFrame.Angles(-v.offset.Z * 0.08, 0, v.offset.X * 0.08);
    end;
end);

return v7;