 

 

local ContentProvider = game:GetService("ContentProvider");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = { "rbxassetid://80653206136943", "rbxassetid://133415518959769", "rbxassetid://76704577445417", "rbxassetid://78015125767546", "rbxassetid://120836309864098", "rbxassetid://117969015259428", "rbxassetid://111318450934120", "rbxassetid://115082687783007", "rbxassetid://75028428814160", "rbxassetid://92301364800497", "rbxassetid://83807567312581", "rbxassetid://128435307414798", "rbxassetid://80189219900804" };

local function find_image_label(p3: userdata, p4: string) -- Line: 27
    local v5 = p3:FindFirstChild(p4);

    if v5 and v5:IsA("ImageLabel") then
        return v5;
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant.Name == p4 and descendant:IsA("ImageLabel") then
            return descendant;
        end;
    end;

    return nil;
end;

local function wait_for_template() -- Line: 40
    -- upvalues: vfxUtil (copy)
    local phainon = vfxUtil.getResources():WaitForChild("phainon", 30);

    if not phainon then
        return nil;
    end;

    local Misc = phainon:WaitForChild("Misc", 10);

    if not Misc then
        return nil;
    end;

    local PhainonCores = Misc:WaitForChild("PhainonCores", 10);

    if PhainonCores and PhainonCores:IsA("ScreenGui") then
        return PhainonCores;
    end;

    return nil;
end;

local function build_core_layers(p6: userdata) -- Line: 57
    -- upvalues: u2 (copy), ContentProvider (copy)
    local Parent = p6.Parent;
    local v7 = {};

    for i, v in u2 do
        local v8 = p6:Clone();
        v8.Name = `Core{i}`;
        v8.Image = v;
        v8.Visible = false;
        v8.Parent = Parent;
        v7[i] = v8;
    end;

    p6:Destroy();
    task.defer(ContentProvider.PreloadAsync, ContentProvider, v7);

    return v7;
end;

function v1.bind(u9: userdata, u10: any) -- Line: 76
    -- upvalues: LocalPlayer (copy), wait_for_template (copy), find_image_label (copy), build_core_layers (copy)
    if LocalPlayer:GetAttribute("style") ~= "phainon" then
        return;
    end;

    task.spawn(function() -- Line: 81
        -- upvalues: LocalPlayer (ref), wait_for_template (ref), u9 (copy), u10 (copy), find_image_label (ref), build_core_layers (ref)
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

        if PlayerGui and PlayerGui:FindFirstChild("PhainonCoresActive") then
            return;
        end;

        local v11 = wait_for_template();

        if not (v11 and u9.Parent) then
            return;
        end;

        if LocalPlayer:GetAttribute("style") ~= "phainon" then
            return;
        end;

        local u12 = v11:Clone();
        u12.Name = "PhainonCoresActive";
        u12.ResetOnSpawn = false;
        u12.Parent = LocalPlayer:WaitForChild("PlayerGui");
        u10:Add(u12);
        local u13 = find_image_label(u12, "Base");
        local v14 = find_image_label(u12, "Cores");

        if not (u13 and v14) then
            u12:Destroy();

            return;
        end;

        local u15 = build_core_layers(v14);

        local function update() -- Line: 111
            -- upvalues: u9 (ref), u13 (copy), u15 (copy)
            local v16 = u9:GetAttribute("Coreflame") or 0;
            u13.Visible = true;

            for i, v in u15 do
                v.Visible = i == v16;
            end;
        end;

        u10:Add(u9:GetAttributeChangedSignal("Coreflame"):Connect(update));
        u10:Add(LocalPlayer:GetAttributeChangedSignal("style"):Connect(function() -- Line: 120
            -- upvalues: LocalPlayer (ref), u12 (copy)
            if LocalPlayer:GetAttribute("style") ~= "phainon" then
                u12:Destroy();
            end;
        end));
        local v17 = u9:GetAttribute("Coreflame") or 0;
        u13.Visible = true;

        for i, v in u15 do
            v.Visible = i == v17;
        end;
    end);
end;

return v1;