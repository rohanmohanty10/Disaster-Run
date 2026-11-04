 

 

local v1 = {};
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u2;

if LocalPlayer then
    u2 = LocalPlayer.PlayerGui;
else
    u2 = LocalPlayer;
end;

local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local u3 = { "BlurEffect", "ColorCorrectionEffect", "SunRaysEffect" };

local function getAvailableSpot(p4, p5, p6) -- Line: 16
    -- upvalues: getAvailableSpot (copy)
    if p4[p5 .. (p6 or "")] then
        return getAvailableSpot(p4, p5, p6 and p6 + 1 or 1);
    end;

    return p6;
end;

local function addChildren(p7, p8, p9) -- Line: 23
    -- upvalues: Util (copy), addChildren (copy)
    for _, child in p7:GetChildren() do
        table.insert(p8[p9], child);
        table.insert(p8.All, child);

        if child:GetAttribute("MeshEmitter") then
            Util.AttributeTween(child);
        end;

        addChildren(child, p8, p9);
    end;
end;

local function addVFX(p10, p11, p12, p13, p14) -- Line: 34
    -- upvalues: Util (copy), getAvailableSpot (copy), addChildren (copy)
    if p14 then
        if not p12.Victim then
            p12.Victim = {};
        end;

        if not p13.Victim then
            p13.Victim = {};
        end;

        p12 = p12.Victim;
        p13 = p13.Victim;
    end;

    for _, child in p11:GetChildren() do
        local v15 = p10:FindFirstChild(child.Name);

        if v15 then
            if not p12[v15.Name] then
                p12[v15.Name] = {};
            end;

            if not p13[v15.Name] then
                p13[v15.Name] = {};
            end;

            if not p13.All then
                p13.All = {};
            end;

            for _, child2 in child:GetChildren() do
                if child2:IsA("Motor6D") or child2:IsA("Weld") then
                    if not p12.Motors then
                        p12.Motors = {};
                    end;

                    child2.Part0 = v15;
                    child2.Part1 = child2.Part1 and (p11:FindFirstChild(child2.Part1.Name) or p10:FindFirstChild(child2.Part1.Name)) or child2.Part1;
                    child2.Parent = v15;
                    table.insert(p12.Motors, child2);
                else
                    child2.Parent = v15;

                    if child2:GetAttribute("MeshEmitter") then
                        Util.AttributeTween(child2);
                    end;

                    local v16 = p12[v15.Name];
                    local Name = child2.Name;
                    local v17;

                    if v16[Name .. ""] then
                        v17 = getAvailableSpot(v16, Name, 1);
                    else
                        v17 = nil;
                    end;

                    p12[v15.Name][child2.Name .. (v17 or "")] = child2;
                    table.insert(p13[v15.Name], child2);
                    table.insert(p13.All, child2);
                    addChildren(child2, p13, v15.Name);
                end;
            end;
        else
            if not p12[child.Name] then
                p12[child.Name] = {};
            end;

            child.Parent = p10;
            p12[child.Name] = child;
        end;
    end;

    p11:Destroy();
end;

local function addMeshes(p18, p19, p20, p21) -- Line: 96
    -- upvalues: Util (copy)
    local PrimaryPart = p18.PrimaryPart;
    local _ = p19.PrimaryPart;

    if not p20[p19.Name] then
        p20[p19.Name] = {};
    end;

    for _, descendant in p19:GetDescendants() do
        if descendant:GetAttribute("MeshEmitter") then
            Util.AttributeTween(descendant);
        end;
    end;

    p19:PivotTo(PrimaryPart.CFrame * (p21 or CFrame.new()));
    p19.Parent = workspace.Effects;
    table.insert(p20[p19.Name], p19);

    return p19;
end;

local function addMeshEmit(p22, p23, p24, p25) -- Line: 118
    -- upvalues: vfxUtil (copy), Players (copy), Util (copy), u3 (copy), u2 (copy)
    if vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        return;
    end;

    local PrimaryPart = p22.PrimaryPart;
    local _ = p23.PrimaryPart;

    if not p24[p23.Name] then
        p24[p23.Name] = {};
    end;

    p23:PivotTo(PrimaryPart.CFrame * (p25 or CFrame.new()));
    p23.Parent = workspace.Effects;

    for _, descendant in p23:GetDescendants() do
        Util.AttributeTween(descendant);

        if table.find(u3, descendant.ClassName) then
            descendant.Parent = game.Lighting;
            table.insert(p24[p23.Name], descendant);
        elseif descendant:IsA("ScreenGui") then
            descendant.Parent = u2;
            table.insert(p24[p23.Name], descendant);
        end;
    end;

    table.insert(p24[p23.Name], p23);
end;

local function getMaxDuration(p26) -- Line: 144
    local v27 = 0;

    for i, _ in p26 do
        if v27 < i then
            v27 = i;
        end;
    end;

    return v27;
end;

local function destroy(p28, p29, u30, p31) -- Line: 152
    if p28 then
        p28:Disconnect();
    end;

    local function remove(p32) -- Line: 157
        -- upvalues: remove (copy)
        for i, v in p32 do
            if i == "Victim" and typeof(v) == "table" then
                remove(v);
            elseif typeof(v) == "Instance" then
                v:Destroy();
            else
                for _, v2 in v do
                    v2:Destroy();
                end;
            end;
        end;
    end;

    remove(p29);
    task.spawn(function() -- Line: 175
        -- upvalues: u30 (copy)
        for _, v in u30.Cache or {} do
            if v.Destroy then
                v:Destroy();
            end;
        end;
    end);
    table.clear(p31);
    table.clear(p29);
    table.clear(u30);
end;

function v1.createEffect(u33, p34, u35, ...) -- Line: 188
    -- upvalues: addVFX (copy), addMeshes (copy), addMeshEmit (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), destroy (copy)
    local Character = u33.Character;
    local Victim = u33.Victim;
    local PrimaryPart = Character.PrimaryPart;
    local _ = u33.Parameters;
    local v36 = script[p34];
    local Model = v36.Model;
    print(u33.Character, u33.Victim);
    local v37 = Model:Clone();
    local v38 = Model:FindFirstChild("Player") and v37:WaitForChild("Player");
    local v39 = Model:FindFirstChild("Victim") and v37:WaitForChild("Victim");
    local v40 = Model:FindFirstChild("Meshes") and v37:WaitForChild("Meshes");
    local u41 = Model:FindFirstChild("MeshEmitter") and v37:WaitForChild("MeshEmitter");
    local u42 = nil;
    local u43 = {};
    local u44 = {
        All = {}
    };

    if v38 then
        addVFX(Character, v38, u43, u44);
    end;

    if v39 and Victim then
        addVFX(Victim, v39, u43, u44, true);
    end;

    if v40 then
        u42 = addMeshes(Character, v40, u43, u35);
    end;

    if u41 then
        addMeshEmit(Character, u41, u43, u35);
    end;

    if (Character:GetAttribute("ReoCopy") or Character:GetAttribute("CustomColor")) and (LocalPlayer and not (Character:GetAttribute("CustomColor") and (Character ~= LocalPlayer.Character and LocalPlayer:FindFirstChild("setting"):FindFirstChild("CustomVFXEnabled").Value == false))) then
        for _, v in u43 do
            if typeof(v) == "Instance" and (v:IsA("Model") or (v:IsA("BasePart") or v:IsA("Folder"))) then
                vfxUtil.LeanTowardsColor(v, Character:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Character:GetAttribute("CustomAlpha") or 0.985);
            end;
        end;
    end;

    local u45 = require(v36);
    local os_clock_ret = os.clock();
    local u46 = 0;
    local u47 = {};

    for i, _ in u45 do
        if u46 < i then
            u46 = i;
        end;
    end;

    u33.MeshEmit = u41;
    u33.Meshes = u42;
    u33.Cache = {};
    local u49 = RunService.PreAnimation:Connect(function() -- Line: 251
        -- upvalues: os_clock_ret (copy), u42 (ref), PrimaryPart (copy), u35 (copy), u41 (copy), u45 (copy), u47 (copy), u33 (copy), u43 (copy), u44 (copy)
        local v48 = os.clock() - os_clock_ret;

        if u42 then
            u42:PivotTo(PrimaryPart.CFrame * (u35 or CFrame.new()));
        end;

        if u41 then
            u41:PivotTo(PrimaryPart.CFrame * (u35 or CFrame.new()));
        end;

        for i, v in u45 do
            if i <= v48 and not u47[i] then
                u47[i] = true;
                local success, result = pcall(v, u33, u43, u44);

                if not success then
                    warn(result);
                end;
            end;
        end;
    end);
    local task_delay_ret = task.delay(u46, function() -- Line: 275
        -- upvalues: u47 (copy), u46 (copy), u45 (copy), u33 (copy), u43 (copy), u44 (copy), destroy (ref), u49 (copy)
        if not u47[u46] then
            u47[u46] = true;
            local success, result = pcall(u45[u46], u33, u43, u44);

            if not success then
                warn(result);
            end;
        end;

        destroy(u49, u43, u33, u44);
    end);

    return {
        Destroy = function() -- Line: 288, Name: Destroy
            -- upvalues: task_delay_ret (copy), destroy (ref), u49 (copy), u43 (copy), u33 (copy), u44 (copy)
            if coroutine.status(task_delay_ret) == "suspended" then
                task.cancel(task_delay_ret);
            end;

            destroy(u49, u43, u33, u44);
        end
    };
end;

return v1;