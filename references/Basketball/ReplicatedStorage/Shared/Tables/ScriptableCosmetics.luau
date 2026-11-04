 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local GetHumDescription = require(ReplicatedStorage.Shared.Utility.GetHumDescription);

local function SetupMascot(p1: userdata, u2: userdata, p3: any) -- Line: 13
    if u2:FindFirstChild("Head") and not u2:FindFirstChild("Head"):GetAttribute("KeepHead") then
        for _, child in p1:GetChildren() do
            if child:IsA("Accessory") then
                local Transparency = child.Handle.Transparency;

                if Transparency ~= 1 then
                    child.Handle.Transparency = 1;
                    p3:Add(function() -- Line: 22
                        -- upvalues: child (copy), Transparency (copy)
                        child.Handle.Transparency = Transparency;
                    end);
                end;
            end;
        end;

        local Head = p1:FindFirstChild("Head");

        if Head then
            local Transparency = Head.Transparency;

            if Transparency ~= 1 then
                Head.Transparency = 1;
                p3:Add(function() -- Line: 34
                    -- upvalues: Head (copy), Transparency (copy)
                    Head.Transparency = Transparency;
                end);
            end;

            local face = Head:FindFirstChild("face");

            if face then
                local Transparency2 = face.Transparency;

                if Transparency2 ~= 1 then
                    face.Transparency = 1;
                    p3:Add(function() -- Line: 45
                        -- upvalues: face (copy), Transparency2 (copy)
                        face.Transparency = Transparency2;
                    end);
                end;
            end;
        end;
    end;

    for _, child in u2:GetChildren() do
        local v4 = child;

        for _, child2 in child:GetChildren() do
            if child2 ~= v4.Main then
                local v5 = p3:Add(Instance.new("WeldConstraint"));
                v5.Parent = child2;
                v5.Part0 = v4.Main;
                v5.Part1 = child2;
            end;
        end;

        v4.Main.CFrame = p1:FindFirstChild(v4.Name).CFrame;
        local v6 = p3:Add(Instance.new("WeldConstraint"));
        v6.Parent = v4.Main;
        v6.Part0 = p1:FindFirstChild(v4.Name);
        v6.Part1 = v4.Main;
    end;

    local PlayerFromCharacter = game:GetService("Players"):GetPlayerFromCharacter(p1);

    if PlayerFromCharacter ~= nil then
        for _, descendant in u2:GetDescendants() do
            if descendant:IsA("SurfaceAppearance") and descendant.Parent.Name == "Jersey" then
                descendant.Color = PlayerFromCharacter.Team:GetAttribute("Color");
            end;
        end;

        p3:Add(PlayerFromCharacter:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 82
            -- upvalues: u2 (copy), PlayerFromCharacter (copy)
            for _, descendant in u2:GetDescendants() do
                if descendant:IsA("SurfaceAppearance") and descendant.Parent.Name == "Jersey" then
                    descendant.Color = PlayerFromCharacter.Team:GetAttribute("Color");
                end;
            end;
        end));
    end;
end;

local function SetupRankedBadge(p7: userdata, p8: userdata, p9: any) -- Line: 92
    -- upvalues: ReplicatedStorage (copy)
    local v10 = ReplicatedStorage.Assets.Misc.RankedBadgeVisuals:Clone();
    v10.Parent = p8;
    v10.Enabled = true;
end;

local function SetupSwirlAura(p11: userdata, p12: userdata, p13: any) -- Line: 98
    -- upvalues: ReplicatedStorage (copy), Essentials (copy)
    local v14 = ReplicatedStorage.Assets.Misc.SwirlVisuals:Clone();
    v14.Parent = p12.Swirl;
    v14.Enabled = true;
    p12.Root.CFrame = p11.HumanoidRootPart.CFrame;
    Essentials:Weld(p12.Root, p11.HumanoidRootPart);
end;

local function SetupAura(p15: userdata, p16: userdata, p17: any) -- Line: 107
    -- upvalues: Essentials (copy)
    for _, child in p16:GetChildren() do
        local v18 = p15:FindFirstChild(child.Name);

        if v18 then
            child.CFrame = v18.CFrame;
            Essentials:Weld(child, v18);
        end;
    end;
end;

local function SetupHat(p19: userdata, p20: userdata, p21: any) -- Line: 116
    -- upvalues: Essentials (copy)
    p20.Handle:PivotTo(p19.Head.CFrame);
    p21:Add(Essentials:Weld(p19.Head, p20.Handle));
end;

local function SetupBackpack(p22: userdata, p23: userdata, p24: any) -- Line: 121
    -- upvalues: Essentials (copy)
    p23.Handle:PivotTo(p22.Torso.CFrame);
    p24:Add(Essentials:Weld(p22.Torso, p23.Handle));
end;

local function SetupTattoo(p25: userdata, p26: userdata, p27: any) -- Line: 126
    p26.WeldLeftArm.Weld.Part0 = p25["Left Arm"];
    p26.WeldRightArm.Weld.Part0 = p25["Right Arm"];
    p26.WeldTorso.Weld.Part0 = p25.Torso;
end;

return {
    Tentacles = function(p28: userdata, p29: any, p30: any) -- Line: 142
        -- upvalues: Essentials (copy)
        local Torso = p28:FindFirstChild("Torso");

        for i = 1, 4 do
            local v31 = p29:FindFirstChild((`tentacle{i}`));
            v31.Cylinder.CFrame = Torso.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
            p30:Add(Essentials:Weld(Torso, v31.Cylinder));
            p30:Add(v31.AnimationController.Animator:LoadAnimation(p29.Anims:FindFirstChild((tostring(i))))):Play(0);
            local _ = i;
        end;
    end,

    Clouds = function(p32: userdata, p33: any, p34: any) -- Line: 156
        -- upvalues: Essentials (copy)
        for _, child in p33:GetChildren() do
            local v35 = p32:FindFirstChild(child.Name);
            child.CFrame = v35.CFrame;
            p34:Add(Essentials:Weld(v35, child));
        end;
    end,

    ["Psychic Jacket"] = function(p36: userdata, p37: any, p38: any) -- Line: 166
        -- upvalues: Essentials (copy)
        for _, child in p37:GetChildren() do
            local v39 = p36:FindFirstChild(child.Name);
            child.CFrame = v39.CFrame;
            p38:Add(Essentials:Weld(v39, child));
        end;
    end,

    ["Cyber Jacket"] = function(p40: userdata, p41: any, p42: any) -- Line: 176
        -- upvalues: Essentials (copy)
        for _, child in p41:GetChildren() do
            local v43 = p40:FindFirstChild(child.Name);
            child.CFrame = v43.CFrame;
            p42:Add(Essentials:Weld(v43, child));
        end;
    end,

    ["Brother Duo"] = function(p44: userdata, p45: any, p46: any) -- Line: 186
        -- upvalues: Players (copy), GetHumDescription (copy), Essentials (copy), ReplicatedStorage (copy)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p44);
        local v47 = nil;
        local v48;

        if PlayerFromCharacter == nil then
            v48 = v47;
        else
            local v49;
            v49, v48 = pcall(function() -- Line: 191
                -- upvalues: Players (ref), PlayerFromCharacter (copy)
                local CurrentPage = Players:GetFriendsAsync(PlayerFromCharacter.UserId):GetCurrentPage();

                return CurrentPage[Random.new():NextInteger(1, #CurrentPage)].Id;
            end);

            if v49 ~= true then
                v48 = v47;
            end;
        end;

        local v50 = p46:Add(GetHumDescription.FromUserId(v48, true));
        p45.Humanoid:ApplyDescriptionReset(v50);
        p45:ScaleTo(0.66);
        p45.HumanoidRootPart.CFrame = p44.HumanoidRootPart.CFrame * CFrame.new(0.2, 0.47, 0.35);
        p46:Add(Essentials:Weld(p44.HumanoidRootPart, p45.HumanoidRootPart));
        p45.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.TodoReceiver):Play(0);
    end,

    ["Sun Man"] = SetupMascot,
    ["Dog Mascot"] = SetupMascot,
    ["Chrollo Mascot"] = SetupMascot,
    ["Hawk Mascot"] = SetupMascot,
    ["Duck Mascot"] = SetupMascot,
    ["BlueBee Mascot"] = SetupMascot,
    ["Bull Mascot"] = SetupMascot,
    ["Teddy Mascot"] = SetupMascot,
    ["Jofu Mascot"] = SetupMascot,
    ["Tatlis Mascot"] = SetupMascot,

    ["Straw Hat"] = function(p51: userdata, p52: userdata, p53: any) -- Line: 225
        -- upvalues: Essentials (copy)
        p52.Handle:PivotTo(p51.Head.CFrame);
        p53:Add(Essentials:Weld(p51.Head, p52.Handle));
    end,

    ["Pineapple Head"] = function(p54: userdata, p55: userdata, p56: any) -- Line: 230
        if not p54:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p55.Handle;
        Handle.Parent = p54;
        p55:Destroy();
        Handle:PivotTo(p54.Torso.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p54.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Current Cape"] = function(p57: userdata, p58: userdata, p59: any) -- Line: 248
        if not p57:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p57.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p59:Add(function() -- Line: 270
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p58.Handle;
        Handle.Parent = p57;
        p58:Destroy();
        Handle:PivotTo(p57.Torso.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.141592653589793, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p57.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Phoenix Cape"] = function(p60: userdata, p61: userdata, p62: any) -- Line: 278
        if not p60:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p60.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p62:Add(function() -- Line: 300
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p61.Handle;
        Handle.Parent = p60;
        p61:Destroy();
        Handle:PivotTo(p60.Torso.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p60.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Golden Backpack"] = function(p63: userdata, p64: userdata, p65: any) -- Line: 308
        if not p63:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p64.Handle;
        Handle.Parent = p63;
        p64:Destroy();
        Handle:PivotTo(p63.Torso.BodyBackAttachment.WorldCFrame * CFrame.new(0, 0.114, 0.03) * CFrame.Angles(0, 3.141592653589793, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p63.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Demon Dog"] = SetupTattoo,

    ["Meteor Aura"] = function(p66: userdata, p67: userdata, p68: any) -- Line: 328
        p67.Root.Value = p66.HumanoidRootPart;
    end,

    Skateboard = function(p69: userdata, p70: userdata, p71: any) -- Line: 332
        -- upvalues: Essentials (copy)
        p70.Handle.CFrame = p69.Torso.CFrame * CFrame.new(0, 0, 0.5) * p70.Handle.BodyBackAttachment.CFrame:Inverse();
        Essentials:Weld(p70.Handle, p69.Torso);
    end,

    ["Cat!"] = function(p72: userdata, p73: userdata, p74: any) -- Line: 338
        -- upvalues: Essentials (copy)
        local u75 = p73.AnimationController.Animator:LoadAnimation(p73.Animation);
        u75:Play();
        p73.Cat.CFrame = p72.Torso.CFrame * CFrame.new(0, 0.2, 0.55) * CFrame.fromEulerAngles(0, 3.141592653589793, 0);
        Essentials:Weld(p73.Cat, p72.Torso);
        p74:Add(function() -- Line: 346
            -- upvalues: u75 (copy)
            u75:Destroy();
        end);
    end,

    Unlimited = function(p76: userdata, p77: userdata, p78: any) -- Line: 351
        -- upvalues: Essentials (copy), VfxManager (copy)
        local u79 = p77.AnimationController.Animator:LoadAnimation(p77.Animation);
        u79:Play();
        p77.Icosphere.CFrame = p76.Torso.CFrame * CFrame.new(0, 0, 1);
        Essentials:Weld(p77.Icosphere, p76.Torso);
        VfxManager.Enable(p77, true);
        p78:Add(function() -- Line: 365
            -- upvalues: u79 (copy)
            u79:Destroy();
        end);
    end,

    Winner = function(p80: userdata, u81: userdata, p82: any) -- Line: 374
        -- upvalues: Essentials (copy), TweenService (copy)
        u81.Parent = workspace;
        u81.CFrame = p80["Right Arm"].CFrame * CFrame.new(0.35, 0, 0) * CFrame.fromEulerAnglesXYZ(0, -1.5707963267948966, 0);
        Essentials:Weld(u81, p80["Right Arm"]);
        p82:Add(task.spawn(function() -- Line: 381
            -- upvalues: TweenService (ref), u81 (copy)
            local v83 = 0;

            while task.wait(1) do
                v83 = (v83 + 20) % 360;
                local Color3_fromHSV_ret = Color3.fromHSV(v83 / 360, 0.7, 0.7);
                local v84 = Color3_fromHSV_ret.R * 20;
                local v85 = Color3_fromHSV_ret.G * 20;
                local v86 = Color3_fromHSV_ret.B * 20;
                TweenService:Create(u81.Mesh, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    VertexColor = Vector3.new(v84, v85, v86)
                }):Play();
            end;
        end));
    end,

    ["Oni\'s Wrath"] = SetupTattoo,

    ["Vampire Cape"] = function(p87: userdata, p88: any, p89: any) -- Line: 399
        if not p87:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p87.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p89:Add(function() -- Line: 421
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p88.Handle;
        Handle.Parent = p87;
        p88:Destroy();
        Handle:PivotTo(p87.Torso.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p87.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Emperor Cape"] = function(p90: userdata, p91: any, p92: any) -- Line: 429
        if not p90:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p90.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p92:Add(function() -- Line: 451
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p91.Handle;
        Handle.Parent = p90;
        p91:Destroy();
        Handle:PivotTo(p90.Torso.CFrame * CFrame.new(0, -0.7, 0.65) * CFrame.Angles(1.5707963267948966, 0, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p90.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Cherry Blossom Cape"] = function(p93: userdata, p94: any, p95: any) -- Line: 459
        if not p93:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p93.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p95:Add(function() -- Line: 481
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p94.Handle;
        Handle.Parent = p93;
        p94:Destroy();
        Handle:PivotTo(p93.Torso.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p93.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Gold Cape"] = function(p96: userdata, p97: any, p98: any) -- Line: 489
        if not p96:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p96.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p98:Add(function() -- Line: 511
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p97.Handle;
        Handle.Parent = p96;
        p97:Destroy();
        Handle:PivotTo(p96.Torso.CFrame * CFrame.new(0, -0.6, 1.15) * CFrame.fromEulerAnglesYXZ(1.5707963267948966, 3.141592653589793, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p96.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    Model = function(p99: userdata, p100: any, p101: any) -- Line: 519
        -- upvalues: Essentials (copy)
        p100.CFrame = p99.HumanoidRootPart.CFrame;
        Essentials:Weld(p100, p99.HumanoidRootPart);
    end,

    ["Perfect Wings"] = function(p102: userdata, p103: any, p104: any) -- Line: 524
        -- upvalues: Essentials (copy)
        local u105 = p103.AnimationController.Animator:LoadAnimation(p103.Animation);
        u105:Play();
        p103:PivotTo(p102.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, 3.141592653589793, 0));
        Essentials:Weld(p103["Plane.001"], p102.Torso);
        p104:Add(function() -- Line: 532
            -- upvalues: u105 (copy)
            u105:Destroy();
        end);
    end,

    ["Rulebook Backpack"] = function(p106: userdata, p107: userdata, p108: any) -- Line: 537
        if not p106:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p107.Handle;
        Handle.Parent = p106;
        p107:Destroy();
        Handle:PivotTo(p106.Torso.BodyBackAttachment.WorldCFrame * CFrame.new(-0.375, -0.05, 0) * CFrame.Angles(0, -1.5707963267948966, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p106.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Referee Cape"] = function(p109: userdata, p110: any, p111: any) -- Line: 555
        if not p109:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p109.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p111:Add(function() -- Line: 577
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p110.Handle;
        Handle.Parent = p109;
        p110:Destroy();
        Handle:PivotTo(p109.Torso.CFrame * CFrame.new(0, -0.6, 0.5) * CFrame.Angles(0, -1.5707963267948966, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p109.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Referee Hat"] = function(p112: userdata, p113: userdata, p114: any) -- Line: 585
        -- upvalues: Essentials (copy)
        p113.Handle:PivotTo(p112.Head.CFrame);
        p114:Add(Essentials:Weld(p112.Head, p113.Handle));
    end,

    ["Old Radio"] = function(p115: userdata, p116: userdata, p117: any) -- Line: 590
        if not p115:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p116.Handle;
        Handle.Parent = p115;
        p116:Destroy();
        Handle:PivotTo(p115.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-0.55, 1, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p115.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Duck Hat"] = function(p118: userdata, p119: userdata, p120: any) -- Line: 608
        -- upvalues: Essentials (copy)
        p119.Handle:PivotTo(p118.Head.CFrame);
        p120:Add(Essentials:Weld(p118.Head, p119.Handle));
    end,

    ["Heart Balloon"] = function(p121: userdata, p122: userdata, p123: any) -- Line: 613
        if not p121:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p122.Handle;
        Handle.Parent = p121;
        p122:Destroy();
        Handle:PivotTo(p121.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(0.75, 0.25, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p121.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Joker Cape"] = function(p124: userdata, p125: any, p126: any) -- Line: 631
        if not p124:IsDescendantOf(workspace.Lobby.Limiteds) then
            for _, v in { p124.Torso } do
                v:SetAttribute("ColliderKey", "Cape");
                v:SetAttribute("ColliderShape", "Box");
                v:AddTag("SmartCollider");
                p126:Add(function() -- Line: 653
                    -- upvalues: v (copy)
                    v:SetAttribute("ColliderKey", nil);
                    v:SetAttribute("ColliderShape", nil);
                    v:RemoveTag("SmartCollider");
                end);
            end;

            return;
        end;

        local Handle = p125.Handle;
        Handle.Parent = p124;
        p125:Destroy();
        Handle:PivotTo(p124.Torso.CFrame * CFrame.new(0, -0.477, 0.897) * CFrame.Angles(0, 1.5707963267948966, -0.2617993877991494));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p124.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Wazzup! Mask"] = function(p127: userdata, p128: userdata, p129: any) -- Line: 661
        -- upvalues: Essentials (copy)
        p128.Handle:PivotTo(p127.Head.CFrame);
        p129:Add(Essentials:Weld(p127.Head, p128.Handle));
    end,

    ["Ghost Mask"] = function(p130: userdata, p131: userdata, p132: any) -- Line: 666
        -- upvalues: Essentials (copy)
        p131.Handle:PivotTo(p130.Head.CFrame);
        p132:Add(Essentials:Weld(p130.Head, p131.Handle));
    end,

    ["Cyber Glasses"] = function(p133: userdata, p134: userdata, p135: any) -- Line: 671
        -- upvalues: Essentials (copy)
        p134.Handle:PivotTo(p133.Head.CFrame);
        p135:Add(Essentials:Weld(p133.Head, p134.Handle));
    end,

    ["Cyber Helmet"] = function(p136: userdata, p137: userdata, p138: any) -- Line: 676
        -- upvalues: Essentials (copy)
        p137.Handle:PivotTo(p136.Head.CFrame);
        p138:Add(Essentials:Weld(p136.Head, p137.Handle));
    end,

    ["Cyber Wings"] = function(p139: userdata, p140: userdata, p141: any) -- Line: 681
        if not p139:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p140.Handle;
        Handle.Parent = p139;
        p140:Destroy();
        Handle:PivotTo(p139.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(1.05, 0.3, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p139.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Dino Backpack"] = function(p142: userdata, p143: userdata, p144: any) -- Line: 699
        if not p142:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p143.Handle;
        Handle.Parent = p142;
        p143:Destroy();
        Handle:PivotTo(p142.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(0.34, 0.25, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p142.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Popstar Keytar"] = function(p145: userdata, p146: userdata, p147: any) -- Line: 717
        if not p145:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p146.Handle;
        Handle.Parent = p145;
        p146:Destroy();
        Handle:PivotTo(p145.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, 1.5707963267948966, 0.7853981633974483) * CFrame.new(-0.125, -1, 0.25));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p145.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Popstar Guitar"] = function(p148: userdata, p149: userdata, p150: any) -- Line: 735
        if not p148:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p149.Handle;
        Handle.Parent = p148;
        p149:Destroy();
        Handle:PivotTo(p148.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, 1.5707963267948966, 0.7853981633974483) * CFrame.new(-0.3, -1.4, 0.1));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p148.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Popstar Backpack"] = function(p151: userdata, p152: userdata, p153: any) -- Line: 753
        if not p151:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p152.Handle;
        Handle.Parent = p151;
        p152:Destroy();
        Handle:PivotTo(p151.Torso.CFrame);
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p151.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Hanging Shoes"] = function(p154: userdata, p155: userdata, p156: any) -- Line: 771
        if not p154:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p155.Handle;
        Handle.Parent = p154;
        p155:Destroy();
        Handle:PivotTo(p154.Torso.BodyBackAttachment.WorldCFrame * CFrame.new(0, 0.1, 0.175));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p154.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["King\'s Crown"] = function(p157: userdata, p158: userdata, p159: any) -- Line: 789
        -- upvalues: Essentials (copy)
        p158.Handle:PivotTo(p157.Head.CFrame);
        p159:Add(Essentials:Weld(p157.Head, p158.Handle));
    end,

    ["Air\'s Trophy"] = function(p160: userdata, p161: userdata, p162: any) -- Line: 794
        if not p160:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p161.Handle;
        Handle.Parent = p160;
        p161:Destroy();
        Handle:PivotTo(p160.Torso.BodyFrontAttachment.WorldCFrame * CFrame.Angles(0, 0, 0.5235987755982988) * CFrame.new(0, 0.5, 0.5));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p160.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Samurai Hat"] = function(p163: userdata, p164: userdata, p165: any) -- Line: 812
        -- upvalues: Essentials (copy)
        p164.Handle:PivotTo(p163.Head.CFrame);
        p165:Add(Essentials:Weld(p163.Head, p164.Handle));
    end,

    ["Dual Katanas"] = function(p166: userdata, p167: userdata, p168: any) -- Line: 817
        if not p166:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p167.Handle;
        Handle.Parent = p166;
        p167:Destroy();
        Handle:PivotTo(p166.Torso.CFrame);
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p166.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Dragon Wrap"] = function(p169: userdata, p170: userdata, p171: any) -- Line: 835
        if not p169:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p170.Handle;
        Handle.Parent = p169;
        p170:Destroy();
        Handle:PivotTo(p169.Torso.BodyFrontAttachment.WorldCFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(-0.3, -0.45, 0.85));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p169.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    Viki = function(p172: userdata, p173: userdata, p174: any) -- Line: 853
        if not p172:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p173.Handle;
        Handle.Parent = p172;
        p173:Destroy();
        Handle:PivotTo(p172.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-0.058, -0.067, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p172.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Ace Backpack"] = function(p175: userdata, p176: userdata, p177: any) -- Line: 871
        if not p175:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p176.Handle;
        Handle.Parent = p175;
        p176:Destroy();
        Handle:PivotTo(p175.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(-0.28, 0.062, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p175.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Crystal Arms"] = function(p178: userdata, p179: userdata, p180: any) -- Line: 889
        for _, child in p179:GetChildren() do
            child.Weld.Part0 = p178:FindFirstChild(child.Name);
        end;
    end,

    ["Arm Wraps"] = function(p181: userdata, p182: userdata, p183: any) -- Line: 895
        for _, child in p182:GetChildren() do
            child.Weld.Part0 = p181:FindFirstChild(child.Name);
        end;
    end,

    ["Witch Hat"] = function(p184: userdata, p185: userdata, p186: any) -- Line: 901
        -- upvalues: Essentials (copy)
        p185.Handle:PivotTo(p184.Head.CFrame);
        p186:Add(Essentials:Weld(p184.Head, p185.Handle));
    end,

    ["Arm Band"] = function(p187: userdata, p188: userdata, p189: any) -- Line: 906
        p188.Weld.Part0 = p187:FindFirstChild("Left Arm");
    end,

    ["Demon Wings"] = function(p190: userdata, p191: userdata, p192: any) -- Line: 910
        if not p190:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p191.Handle;
        Handle.Parent = p190;
        p191:Destroy();
        Handle:PivotTo(p190.Torso.BodyBackAttachment.WorldCFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(1.09, 1.4, 0));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p190.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Ancient Vines"] = function(p193: userdata, p194: userdata, p195: any) -- Line: 928
        for _, child in p194:GetChildren() do
            child.Weld.Part0 = p193:FindFirstChild(child.Name);
        end;
    end,

    ["Watcher Eye"] = function(p196: userdata, p197: userdata, p198: any) -- Line: 934
        -- upvalues: Essentials (copy)
        p197.Handle:PivotTo(p196.Head.CFrame);
        p198:Add(Essentials:Weld(p196.Head, p197.Handle));
    end,

    ["Giant Tongue"] = function(p199: userdata, p200: userdata, p201: any) -- Line: 939
        -- upvalues: Essentials (copy)
        p200.Handle:PivotTo(p199.Head.CFrame);
        p201:Add(Essentials:Weld(p199.Head, p200.Handle));
    end,

    ["0 IQ"] = function(p202: userdata, p203: userdata, p204: any) -- Line: 944
        -- upvalues: Essentials (copy)
        p203.Handle:PivotTo(p202.Head.CFrame);
        p204:Add(Essentials:Weld(p202.Head, p203.Handle));
    end,

    ["Obsessed Octopus"] = function(p205: userdata, p206: userdata, p207: any) -- Line: 949
        -- upvalues: Essentials (copy)
        p206.Handle:PivotTo(p205.Head.CFrame);
        p207:Add(Essentials:Weld(p205.Head, p206.Handle));
    end,

    ["Magma Arms"] = function(p208: userdata, p209: userdata, p210: any) -- Line: 954
        for _, child in p209:GetChildren() do
            child.Weld.Part0 = p208:FindFirstChild(child.Name);
        end;
    end,

    Glitchy = function(p211: userdata, p212: userdata, p213: any) -- Line: 960
        for _, child in p212:GetChildren() do
            child.Weld.Part0 = p211:FindFirstChild(child.Name);
        end;
    end,

    ["Death Book"] = function(p214: userdata, p215: userdata, p216: any) -- Line: 966
        -- upvalues: Essentials (copy)
        local v217 = p214:FindFirstChild("Left Leg");
        p215.Handle.CFrame = v217.CFrame;
        Essentials:Weld(p215.Handle, v217);
    end,

    Mech = function(p218: userdata, p219: userdata, p220: any) -- Line: 973
        for _, child in p219:GetChildren() do
            local u221 = p218:FindFirstChild(child.Name);

            if u221 then
                child.Weld.Part0 = u221;
                u221.Transparency = 1;
                p220:Add(function() -- Line: 979
                    -- upvalues: u221 (copy)
                    u221.Transparency = 0;
                end);
            end;
        end;
    end,

    ["Love Chain"] = function(p222: userdata, p223: userdata, p224: any) -- Line: 986
        if not p222:IsDescendantOf(workspace.Lobby.Limiteds) then
            return;
        end;

        local Handle = p223.Handle;
        Handle.Parent = p222;
        p223:Destroy();
        Handle:PivotTo(p222.Torso.BodyBackAttachment.WorldCFrame * CFrame.new(0, 0.565, -0.588));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p222.Torso;
        WeldConstraint.Part1 = Handle;
        WeldConstraint.Parent = Handle;
    end,

    ["Glacier Arms"] = function(p225: userdata, p226: userdata, p227: any) -- Line: 1004
        for _, child in p226:GetChildren() do
            child.Weld.Part0 = p225:FindFirstChild(child.Name);
        end;
    end,

    ["Bunny Ears"] = SetupHat,
    ["Prince Hat"] = SetupHat,
    ["Inflatable Flamingo"] = SetupBackpack,
    ["Giant Mouth"] = SetupHat,
    ["Chicken Hat"] = SetupHat,
    ["Honored One Suit"] = SetupMascot,
    ["Six Eyes"] = SetupHat,
    ["Chrollo Plush"] = SetupBackpack,
    ["Tatlis Plush"] = SetupBackpack,
    ["Judgement Gavel"] = SetupBackpack,
    ["Blossom Skull"] = SetupTattoo,
    ["Rose Grave"] = SetupTattoo,
    ["Koi Tide"] = SetupTattoo,
    ["Sea Of Dragon"] = SetupTattoo,
    ["Stone Bloom"] = SetupTattoo,
    ["Tiger Garden"] = SetupTattoo,
    ["Combat Vest"] = SetupBackpack,
    ["Jetpack Backpack"] = SetupBackpack,
    ["MVP Chain"] = SetupBackpack,
    ["Duffel Bag"] = SetupBackpack,
    ["Black Mask"] = SetupHat,
    ["White Mask"] = SetupHat,
    ["Gold Mask"] = SetupHat,
    ["Red Mask"] = SetupHat,
    ["Locked In Mask"] = SetupHat,
    ["Johnny\'s Beanie"] = SetupHat,
    Tusk = SetupBackpack,
    ["D4C Ears"] = SetupHat,
    ["Valentine Jacket"] = SetupTattoo,
    ["Paper Bag Mask"] = SetupHat,
    ["Shark Fin Backpack"] = SetupBackpack,
    ["Chef Hat"] = SetupHat,
    Menacing = SetupBackpack,
    ["Golden Aura"] = SetupAura,
    ["Current. Suit"] = SetupMascot,
    ["Michael\'s Smooth Suit"] = SetupMascot,
    ["Michael\'s Thrilling Suit"] = SetupMascot,
    ["The Moonwalker"] = SetupMascot,
    ["Thief Jacket"] = SetupTattoo,
    ["Alien Head"] = SetupMascot,
    ["New York Crown"] = SetupHat,
    ["Golden Shades"] = SetupHat,
    ["Golden Sleeves"] = SetupTattoo,

    ["Requiem Aura"] = function(p228: userdata, p229: userdata, p230: any) -- Line: 1054
        local Torso = p228:FindFirstChild("Torso");

        if not Torso then
            return;
        end;

        p229.Fish1.Handle.Part0 = Torso;
        p229.Fish2.Handle.Part0 = Torso;
        p229.Fish1.AnimationController.Animator:LoadAnimation(p229.Fish1.Animation):Play();
        p229.Fish2.AnimationController.Animator:LoadAnimation(p229.Fish2.Animation):Play();
    end,

    ["Glitchy Cubes"] = SetupMascot,
    ["Scary Monster Jacket"] = SetupTattoo,
    ["Perfect Jacket"] = SetupTattoo,
    ["Stardust Jacket"] = SetupTattoo,
    ["Stardust Hat"] = SetupHat,

    Arrow = function(p231: userdata, p232: userdata, p233: any) -- Line: 1070
        -- upvalues: Essentials (copy)
        p232.Handle.CFrame = p231.Torso.CFrame * CFrame.new(0, 0, 0.5) * p232.Handle.BodyBackAttachment.CFrame:Inverse();
        Essentials:Weld(p232.Handle, p231.Torso);
    end,

    ["Nine Tails"] = function(p234: userdata, p235: userdata, p236: any) -- Line: 1076
        local Torso = p234:FindFirstChild("Torso");

        if not Torso then
            return;
        end;

        p235.Handle.Part0 = Torso;
        p235.AnimationController.Animator:LoadAnimation(p235.Animation):Play();
    end,

    ["Ninja Cloak"] = SetupBackpack,
    ["Evil Pumpkin Head"] = SetupHat,

    ["Bat Wings"] = function(p237: userdata, p238: userdata, p239: any) -- Line: 1087
        local Torso = p237:FindFirstChild("Torso");

        if not Torso then
            return;
        end;

        p238.Handle.Part0 = Torso;
    end,

    Killer = SetupBackpack,
    Reaper = SetupBackpack,
    ["Head Cover"] = SetupHat,

    ["Sneaky Trails"] = function(p240: userdata, p241: userdata, p242: any) -- Line: 1099
        -- upvalues: Essentials (copy), RunService (copy)
        for _, child in p241:GetChildren() do
            local v243 = p240:FindFirstChild(child.Name);

            if v243 then
                child.CFrame = v243.CFrame;
                Essentials:Weld(child, v243);
            end;
        end;

        local u244 = {};
        local u245 = {};
        local u246 = {};

        for _, descendant in p241:GetDescendants() do
            if descendant:IsA("BasePart") and string.find(descendant.Name, "Arm") or string.find(descendant.Name, "Leg") then
                table.insert(u244, descendant);
                local v247 = {};

                for _, descendant2 in descendant:GetDescendants() do
                    if descendant2:IsA("Trail") then
                        table.insert(v247, descendant2);
                    end;
                end;

                u245[descendant] = v247;
            end;
        end;

        p242:Connect(RunService.Heartbeat, function(p248) -- Line: 1125
            -- upvalues: u244 (copy), u246 (copy), u245 (copy)
            for _, v in u244 do
                local Position = v.Position;
                local v249 = u246[v] or Position;
                local v250 = v;

                for _, v2 in u245[v] do
                    if p248 < (v249 - Position).Magnitude then
                        v2.Enabled = true;
                    else
                        v2.Enabled = false;
                    end;
                end;

                u246[v250] = v250.Position;
            end;
        end);
    end,

    ["S1 Bronze Badge"] = SetupRankedBadge,
    ["S1 Silver Badge"] = SetupRankedBadge,
    ["S1 Gold Badge"] = SetupRankedBadge,
    ["S1 Iron Badge"] = SetupRankedBadge,
    ["S1 Diamond Badge"] = SetupRankedBadge,
    ["S1 Platinum Badge"] = SetupRankedBadge,
    ["S1 Champion Badge"] = SetupRankedBadge,
    ["S8 Bronze Back Trophy"] = SetupBackpack,
    ["S8 Silver Back Trophy"] = SetupBackpack,
    ["S8 Gold Back Trophy"] = SetupBackpack,
    ["S8 Iron Back Trophy"] = SetupBackpack,
    ["S8 Diamond Back Trophy"] = SetupBackpack,
    ["S8 Platinum Back Trophy"] = SetupBackpack,
    ["S8 Master Back Trophy"] = SetupBackpack,
    ["S8 Champion Back Trophy"] = SetupBackpack,
    ["S8 Legend Back Trophy"] = SetupBackpack,
    ["S9 Bronze Staff"] = SetupBackpack,
    ["S9 Silver Staff"] = SetupBackpack,
    ["S9 Gold Staff"] = SetupBackpack,
    ["S9 Iron Staff"] = SetupBackpack,
    ["S9 Diamond Staff"] = SetupBackpack,
    ["S9 Platinum Staff"] = SetupBackpack,
    ["S9 Master Staff"] = SetupBackpack,
    ["S9 Champion Staff"] = SetupBackpack,
    ["S9 Legend Staff"] = SetupBackpack,
    ["S12 Bronze Aura"] = SetupSwirlAura,
    ["S12 Silver Aura"] = SetupSwirlAura,
    ["S12 Gold Aura"] = SetupSwirlAura,
    ["S12 Iron Aura"] = SetupSwirlAura,
    ["S12 Diamond Aura"] = SetupSwirlAura,
    ["S12 Platinum Aura"] = SetupSwirlAura,
    ["S12 Master Aura"] = SetupSwirlAura,
    ["S12 Champion Aura"] = SetupSwirlAura,
    ["S12 Legend Aura"] = SetupSwirlAura,
    ["Current. Aura"] = SetupAura,
    ["Seiryū Aura"] = SetupAura,
    ["Raikami Aura"] = SetupAura,
    ["Kumajin Aura"] = SetupAura,
    ["Taurajin Aura"] = SetupAura,
    ["Fukurōkai Aura"] = SetupAura,
    ["Leorai Aura"] = SetupAura,
    ["Raidenuma Aura"] = SetupAura,
    ["Orochii Aura"] = SetupAura,
    ["San Diego Orcas Aura"] = SetupAura,
    ["Madrid Warriors Aura"] = SetupAura,
    ["BBZ Belt"] = SetupBackpack,
    ["Slaying Moon"] = SetupBackpack,
    ["Dark Scythe"] = SetupBackpack,
    ["Demon Slayer"] = SetupBackpack,
    ["Fairy Wings"] = SetupBackpack,
    ["Dark Fairy Wings"] = SetupBackpack,
    ["Dark Cloak"] = SetupAura,
    ["Demon Lord Aura"] = SetupAura,
    ["Black Shock Aura"] = SetupAura,
    ["Chrollo Aura"] = SetupAura,
    ["Perfection Aura"] = SetupAura,
    ["Mist Aura"] = SetupAura,
    ["Money Aura"] = SetupAura,
    ["Shadow Katana"] = SetupBackpack,
    ["Snow Katana"] = SetupBackpack,
    ["Thunder Katana"] = SetupBackpack,

    ["Chaos Aura"] = function(u251: userdata, p252: userdata, p253: any) -- Line: 1230
        -- upvalues: SetupAura (copy)
        SetupAura(u251, p252, p253);
        u251:SetAttribute("Chaos", true);
        p253:Add(function() -- Line: 1234
            -- upvalues: u251 (copy)
            u251:SetAttribute("Chaos", nil);
        end);
    end,

    ["Vampire Aura"] = function(p254: userdata, p255: any, p256: any) -- Line: 1239
        -- upvalues: Essentials (copy)
        p255.CFrame = p254.Torso.CFrame;
        Essentials:Weld(p255, p254.Torso);
    end,

    ["Storm Aura"] = SetupAura,
    ["Thunder Aura"] = SetupAura,
    ["Gold Eye Aura"] = SetupHat,
    ["White Eye Aura"] = SetupHat,
    ["Black Eye Aura"] = SetupHat,
    ["Skarp Eye Aura"] = SetupHat,

    ["All Star Model"] = function(p257: userdata, p258: any, p259: any) -- Line: 1252
        -- upvalues: Essentials (copy)
        p258.CFrame = p257.HumanoidRootPart.CFrame;
        Essentials:Weld(p258, p257.HumanoidRootPart);
    end,

    ["Water Model"] = function(p260: userdata, p261: any, p262: any) -- Line: 1257
        -- upvalues: Essentials (copy)
        p261.CFrame = p260.HumanoidRootPart.CFrame;
        Essentials:Weld(p261, p260.HumanoidRootPart);
    end,

    ["Number Aura"] = function(p263: userdata, p264: userdata, p265: any) -- Line: 1262
        -- upvalues: Essentials (copy)
        p264.CFrame = p263.HumanoidRootPart.CFrame;
        Essentials:Weld(p264, p263.HumanoidRootPart);
    end,

    ["Butler\'s Energy"] = function(p266: userdata, p267: userdata, p268: any) -- Line: 1267
        for _, child in p267:GetChildren() do
            child.Weld.Part0 = p266:FindFirstChild(child.Name);
        end;
    end,

    ["Love Aura"] = SetupAura,
    ["Love Scythe"] = SetupBackpack,
    ["Papaya Aura"] = SetupAura,
    ["AMG Aura"] = SetupAura,

    ["Cursed Energy"] = function(p269: userdata, p270: userdata, p271: any) -- Line: 1279
        for _, child in p270:GetChildren() do
            child.Weld.Part0 = p269:FindFirstChild(child.Name);
        end;
    end,

    ["Cursed Menacing"] = function(p272: userdata, p273: any, p274: any) -- Line: 1285
        -- upvalues: Essentials (copy)
        p273.CFrame = p272.Torso.CFrame;
        Essentials:Weld(p273, p272.Torso);
    end,

    ["Cursed Vampire Aura"] = function(p275: userdata, p276: any, p277: any) -- Line: 1290
        -- upvalues: Essentials (copy)
        p276.CFrame = p275.Torso.CFrame;
        Essentials:Weld(p276, p275.Torso);
    end,

    ["Cursed Scythe"] = SetupBackpack,
    ["Cursed Cloak"] = SetupAura,

    ["Cursed Arm"] = function(p278: userdata, p279: any, p280: any) -- Line: 1298
        local u281 = p278:FindFirstChild("Highlight") or p278:WaitForChild("Highlight", 2);

        if u281 then
            u281.OutlineColor = Color3.fromRGB(255, 255, 255);
            p280:Add(function() -- Line: 1303
                -- upvalues: u281 (ref)
                if u281 then
                    u281.OutlineColor = Color3.fromRGB(0, 0, 0);
                end;
            end);
        else
            local v282 = p280:Add(Instance.new("Highlight"));
            v282.FillColor = Color3.fromRGB(255, 255, 255);
            v282.OutlineColor = Color3.fromRGB(255, 255, 255);
            v282.FillTransparency = 1;
            v282.OutlineTransparency = 0;
        end;

        local u283 = p278:FindFirstChild("Left Arm");

        if u283 then
            u283.Transparency = 0.999;
            p280:Add(function() -- Line: 1320
                -- upvalues: u283 (copy)
                u283.Transparency = 0;
            end);
        end;
    end,

    ["Cursed Skateboard"] = function(p284: userdata, p285: userdata, p286: any) -- Line: 1326
        -- upvalues: Essentials (copy)
        p285.Handle.CFrame = p284.Torso.CFrame * CFrame.new(0, 0, 0.5) * p285.Handle.BodyBackAttachment.CFrame:Inverse();
        Essentials:Weld(p285.Handle, p284.Torso);
    end,

    ["Cursed Arrow"] = function(p287: userdata, p288: userdata, p289: any) -- Line: 1332
        -- upvalues: Essentials (copy)
        p288.Handle.CFrame = p287.Torso.CFrame * CFrame.new(0, 0, 0.5) * p288.Handle.BodyBackAttachment.CFrame:Inverse();
        Essentials:Weld(p288.Handle, p287.Torso);
    end,

    ["Cursed Model"] = function(p290: userdata, p291: any, p292: any) -- Line: 1338
        -- upvalues: Essentials (copy)
        p291.CFrame = p290.HumanoidRootPart.CFrame;
        Essentials:Weld(p291, p290.HumanoidRootPart);
    end,

    ["Emr4n\'s Playtoy"] = function(p293: userdata, p294: any, p295: any) -- Line: 1343
        local Head = p293:FindFirstChild("Head");

        if Head then
            Head.Transparency = 1;
            p295:Add(function() -- Line: 1348
                -- upvalues: Head (copy)
                Head.Transparency = 0;
            end);
            local face = Head:FindFirstChild("face");

            if face then
                face.Transparency = 1;
                p295:Add(function() -- Line: 1356
                    -- upvalues: face (copy)
                    face.Transparency = 0;
                end);
            end;
        end;

        local u296 = p293:FindFirstChild("Right Leg");

        if u296 then
            local v297 = nil;

            for _, child in p293:GetChildren() do
                if child:IsA("CharacterMesh") and child.MeshId == 101851696 then
                    v297 = true;
                    break;
                end;
            end;

            if not v297 then
                u296.Transparency = 1;
                p295:Add(function() -- Line: 1378
                    -- upvalues: u296 (copy)
                    u296.Transparency = 0;
                end);
            end;
        end;
    end
};