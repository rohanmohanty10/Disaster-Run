 

 

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");

local function release(u1, u2) -- Line: 22
    -- upvalues: CollectionService (copy)
    task.delay(5, function() -- Line: 23
        -- upvalues: u2 (copy), CollectionService (ref), u1 (copy)
        local u3 = {};

        for _, v in u2 or {} do
            for _, v2 in CollectionService:GetTagged(v) do
                table.insert(u3, v2);
            end;
        end;

        local function isKept(p4) -- Line: 30
            -- upvalues: u2 (ref), CollectionService (ref)
            for _, v in u2 or {} do
                if CollectionService:HasTag(p4, v) then
                    return true;
                end;
            end;

            return false;
        end;

        local function holdsKept(p5) -- Line: 38
            -- upvalues: u3 (copy)
            for _, v in u3 do
                if v:IsDescendantOf(p5) then
                    return true;
                end;
            end;

            return false;
        end;

        local u6 = {};

        local function add(p7, p8) -- Line: 47
            -- upvalues: isKept (copy), u3 (copy), add (copy), u6 (copy)
            if isKept(p7) then
                return;
            end;

            local v9 = false;

            for _, v in u3 do
                if v:IsDescendantOf(p7) then
                    v9 = true;
                    break;
                end;
            end;

            if v9 or p8 < 3 and (p7:IsA("Folder") or #p7:GetDescendants() > 150) then
                for _, child in p7:GetChildren() do
                    add(child, p8 + 1);
                end;
            end;

            if not v9 then
                table.insert(u6, p7);
            end;
        end;

        for _, v in CollectionService:GetTagged(u1) do
            add(v, 0);
        end;

        for _, v in u6 do
            if v.Parent then
                v:Destroy();
                task.wait(0.05);
            end;
        end;
    end);
end;

local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));

if FFlags.NoUI then
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
    local u10 = {
        TouchGui = true,
        Freecam = true
    };
    PlayerGui.ChildAdded:Connect(function(p11) -- Line: 81, Name: drop
        -- upvalues: u10 (copy)
        if p11:IsA("ScreenGui") and not u10[p11.Name] then
            p11:Destroy();
        end;
    end);

    for _, child in PlayerGui:GetChildren() do
        if child:IsA("ScreenGui") and not u10[child.Name] then
            child:Destroy();
        end;
    end;

    local LegacyUI = ChickenOrHero:FindFirstChild("LegacyUI");

    if LegacyUI then
        LegacyUI = LegacyUI:FindFirstChild("Screens");
    end;

    if LegacyUI then
        LegacyUI:Destroy();
    end;

    return;
end;

local v12 = FFlags.awaitUIVersion();

if v12 ~= "OldUIReskin" then
    local u13 = nil;
    local u14 = "OldUIReskinOnly";
    task.delay(5, function() -- Line: 23
        -- upvalues: u13 (copy), CollectionService (copy), u14 (copy)
        local u15 = {};

        for _, v in u13 or {} do
            for _, v2 in CollectionService:GetTagged(v) do
                table.insert(u15, v2);
            end;
        end;

        local function u17(p16) -- Line: 30
            -- upvalues: u13 (ref), CollectionService (ref)
            for _, v in u13 or {} do
                if CollectionService:HasTag(p16, v) then
                    return true;
                end;
            end;

            return false;
        end;

        local function _(p18) -- Line: 38
            -- upvalues: u15 (copy)
            for _, v in u15 do
                if v:IsDescendantOf(p18) then
                    return true;
                end;
            end;

            return false;
        end;

        local u19 = {};

        local function u23(p20, p21) -- Line: 47
            -- upvalues: u17 (copy), u15 (copy), u23 (copy), u19 (copy)
            if u17(p20) then
                return;
            end;

            local v22 = false;

            for _, v in u15 do
                if v:IsDescendantOf(p20) then
                    v22 = true;
                    break;
                end;
            end;

            if v22 or p21 < 3 and (p20:IsA("Folder") or #p20:GetDescendants() > 150) then
                for _, child in p20:GetChildren() do
                    u23(child, p21 + 1);
                end;
            end;

            if not v22 then
                table.insert(u19, p20);
            end;
        end;

        for _, v in CollectionService:GetTagged(u14) do
            u23(v, 0);
        end;

        for _, v in u19 do
            if v.Parent then
                v:Destroy();
                task.wait(0.05);
            end;
        end;
    end);
end;

if v12 == "NewGui" then
    local u24 = nil;
    local u25 = "LegacyUIOnly";
    task.delay(5, function() -- Line: 23
        -- upvalues: u24 (copy), CollectionService (copy), u25 (copy)
        local u26 = {};

        for _, v in u24 or {} do
            for _, v2 in CollectionService:GetTagged(v) do
                table.insert(u26, v2);
            end;
        end;

        local function u28(p27) -- Line: 30
            -- upvalues: u24 (ref), CollectionService (ref)
            for _, v in u24 or {} do
                if CollectionService:HasTag(p27, v) then
                    return true;
                end;
            end;

            return false;
        end;

        local function _(p29) -- Line: 38
            -- upvalues: u26 (copy)
            for _, v in u26 do
                if v:IsDescendantOf(p29) then
                    return true;
                end;
            end;

            return false;
        end;

        local u30 = {};

        local function u34(p31, p32) -- Line: 47
            -- upvalues: u28 (copy), u26 (copy), u34 (copy), u30 (copy)
            if u28(p31) then
                return;
            end;

            local v33 = false;

            for _, v in u26 do
                if v:IsDescendantOf(p31) then
                    v33 = true;
                    break;
                end;
            end;

            if v33 or p32 < 3 and (p31:IsA("Folder") or #p31:GetDescendants() > 150) then
                for _, child in p31:GetChildren() do
                    u34(child, p32 + 1);
                end;
            end;

            if not v33 then
                table.insert(u30, p31);
            end;
        end;

        for _, v in CollectionService:GetTagged(u25) do
            u34(v, 0);
        end;

        for _, v in u30 do
            if v.Parent then
                v:Destroy();
                task.wait(0.05);
            end;
        end;
    end);

    return;
end;

local u35 = v12 == "OldUIReskin" and { "OldUIReskinKeeps", "OldUIKeeps" } or { "OldUIKeeps" };
local u36 = "NewUIOnly";
task.delay(5, function() -- Line: 23
    -- upvalues: u35 (copy), CollectionService (copy), u36 (copy)
    local u37 = {};

    for _, v in u35 or {} do
        for _, v2 in CollectionService:GetTagged(v) do
            table.insert(u37, v2);
        end;
    end;

    local function u39(p38) -- Line: 30
        -- upvalues: u35 (ref), CollectionService (ref)
        for _, v in u35 or {} do
            if CollectionService:HasTag(p38, v) then
                return true;
            end;
        end;

        return false;
    end;

    local function _(p40) -- Line: 38
        -- upvalues: u37 (copy)
        for _, v in u37 do
            if v:IsDescendantOf(p40) then
                return true;
            end;
        end;

        return false;
    end;

    local u41 = {};

    local function u45(p42, p43) -- Line: 47
        -- upvalues: u39 (copy), u37 (copy), u45 (copy), u41 (copy)
        if u39(p42) then
            return;
        end;

        local v44 = false;

        for _, v in u37 do
            if v:IsDescendantOf(p42) then
                v44 = true;
                break;
            end;
        end;

        if v44 or p43 < 3 and (p42:IsA("Folder") or #p42:GetDescendants() > 150) then
            for _, child in p42:GetChildren() do
                u45(child, p43 + 1);
            end;
        end;

        if not v44 then
            table.insert(u41, p42);
        end;
    end;

    for _, v in CollectionService:GetTagged(u36) do
        u45(v, 0);
    end;

    for _, v in u41 do
        if v.Parent then
            v:Destroy();
            task.wait(0.05);
        end;
    end;
end);

if FFlags.UIPerPlayer then
    for i = 1, 100 do
        if ChickenOrHero:GetAttribute("UIVersion") then
            break;
        end;

        task.wait(0.1);
        local _ = i;
    end;
end;

if v12 == "OldUIReskin" and ChickenOrHero:GetAttribute("UIVersion") == "Switchable" then
    local v46, v47 = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("UIVersionSwap")).swapIn(ChickenOrHero);

    if not v46 then
        warn("LegacyUIClient: " .. v47 .. ", so the original old UI runs");
    end;
end;

local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local LegacyUI = ChickenOrHero:WaitForChild("LegacyUI");
local u48 = {
    Hud = true,
    UI = true
};

local function arrived(p49) -- Line: 132
    -- upvalues: u48 (copy), LegacyUI (copy)
    if not p49:IsA("ScreenGui") then
        return;
    end;

    if u48[p49.Name] then
        p49:Destroy();

        return;
    end;

    if p49.Name == "HUD" then
        for _, child in LegacyUI.HUD:GetChildren() do
            if not p49:FindFirstChild(child.Name) then
                child:Clone().Parent = p49;
            end;
        end;
    end;
end;

PlayerGui.ChildAdded:Connect(arrived);

for _, child in PlayerGui:GetChildren() do
    arrived(child);
end;

for _, child in LegacyUI.Screens:GetChildren() do
    if not PlayerGui:FindFirstChild(child.Name) and child:GetAttribute("LoadOnOpen") ~= true then
        child:Clone().Parent = PlayerGui;
    end;
end;

local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts");
PlayerScripts:WaitForChild("TopbarPlus");

for _, child in LegacyUI.PlayerScripts:GetChildren() do
    child:Clone().Parent = PlayerScripts;
end;