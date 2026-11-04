 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local trove = require(ReplicatedStorage.forum.trove);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local v1 = {
    __index = {}
};
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local u3 = {};

local function onDestructiveImpulsesFrontend(p4: boolean) -- Line: 16
end;

local function applyBarState(p5: userdata, p6: number) -- Line: 19
    local Frame = p5:FindFirstChild("Frame");
    local v7;

    if Frame then
        v7 = Frame:FindFirstChild("BarFrame"):FindFirstChild("Bar");
    else
        v7 = Frame;
    end;

    if Frame and Frame:IsA("GuiObject") then
        Frame.Visible = true;
    end;

    if v7 and v7:IsA("Frame") then
        v7.Size = UDim2.new(1, 0, -math.clamp(p6 / 100, 0, 1), 0);
    end;
end;

local function getRinBarTemplate() -- Line: 32
    -- upvalues: vfxUtil (copy)
    local rin2 = vfxUtil.getResources():FindFirstChild("rin2");

    if not rin2 then
        return nil;
    end;

    local RinBar = rin2:FindFirstChild("RinBar");

    if RinBar and RinBar:IsA("BillboardGui") then
        return RinBar;
    end;

    return nil;
end;

local function unbindRinBar(p8: userdata) -- Line: 47
    -- upvalues: u3 (copy), u2 (copy)
    local v9 = u3[p8];

    if v9 then
        v9:Destroy();
        u3[p8] = nil;
    end;

    local v10 = u2[p8];

    if v10 then
        v10:Destroy();
        u2[p8] = nil;
    end;
end;

local function bindRinBar(u11: userdata, p12: any) -- Line: 61
    -- upvalues: LocalPlayer (copy), u3 (copy), u2 (copy), vfxUtil (copy), trove (copy), applyBarState (copy)
    if LocalPlayer:GetAttribute("style") ~= "rin2" then
        return;
    end;

    local HumanoidRootPart = u11:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v13 = u3[u11];

    if v13 then
        v13:Destroy();
        u3[u11] = nil;
    end;

    local v14 = u2[u11];

    if v14 then
        v14:Destroy();
        u2[u11] = nil;
    end;

    local rin2 = vfxUtil.getResources():FindFirstChild("rin2");
    local v15;

    if rin2 then
        v15 = rin2:FindFirstChild("RinBar");

        if not (v15 and v15:IsA("BillboardGui")) then
            v15 = nil;
        end;
    else
        v15 = nil;
    end;

    if not v15 then
        return;
    end;

    local u16 = v15:Clone();
    u16.Name = "RinBarActive";
    u16.Adornee = HumanoidRootPart;
    u16.Parent = HumanoidRootPart;
    u2[u11] = u16;
    local v17 = p12 or trove.new();

    if not p12 then
        u3[u11] = v17;
        v17:AttachToInstance(u11);
    end;

    v17:Add(u16);

    local function update() -- Line: 92
        -- upvalues: applyBarState (ref), u16 (copy), u11 (copy)
        applyBarState(u16, u11:GetAttribute("RinRage") or 0);
    end;

    local u18 = u11:GetAttribute("DestructiveImpulses") == true;
    v17:Add(u11:GetAttributeChangedSignal("RinRage"):Connect(update));
    v17:Add(u11:GetAttributeChangedSignal("DestructiveImpulses"):Connect(function() -- Line: 98
        -- upvalues: u11 (copy), u18 (ref), applyBarState (ref), u16 (copy)
        local v19 = u11:GetAttribute("DestructiveImpulses") == true;

        if v19 ~= u18 then
            u18 = v19;
        end;

        applyBarState(u16, u11:GetAttribute("RinRage") or 0);
    end));
    v17:Add(LocalPlayer:GetAttributeChangedSignal("style"):Connect(function() -- Line: 106
        -- upvalues: LocalPlayer (ref), u11 (copy), u3 (ref), u2 (ref)
        if LocalPlayer:GetAttribute("style") ~= "rin2" then
            local v20 = u11;
            local v21 = u3[v20];

            if v21 then
                v21:Destroy();
                u3[v20] = nil;
            end;

            local v22 = u2[v20];

            if v22 then
                v22:Destroy();
                u2[v20] = nil;
            end;
        end;
    end));
    applyBarState(u16, u11:GetAttribute("RinRage") or 0);
end;

function v1.bind(p23: userdata, p24: any) -- Line: 115
    -- upvalues: bindRinBar (copy)
    bindRinBar(p23, p24);
end;

function v1.Tspecialer(p25) -- Line: 119
    if p25.character:GetAttribute("DestructiveImpulses") then
        return;
    end;

    if (p25.character:GetAttribute("RinRage") or 0) <= 0 then
        return;
    end;

    p25:senduse({ "Tspecialer" });
end;

function v1.modetoggle(p26) -- Line: 132
    -- upvalues: actionUtil (copy)
    if p26.character:GetAttribute("DestructiveImpulses") then
        return;
    end;

    local setting = p26.player:FindFirstChild("setting");

    if not setting then
        return;
    end;

    local Value = setting.customKeybinds.modetoggle.Value;

    if Enum.KeyCode[Value or "E"] and (Enum.KeyCode[Value or "E"] == Enum.KeyCode.E and actionUtil.checkball(p26.character)) then
        return;
    end;

    if p26.player.UserId == 3928166028 then
        return;
    end;

    p26:senduse({ "changeMode" });
end;

function v1.skill2(p27) -- Line: 156
    local v28 = p27.humanoidRootPart.CFrame:VectorToObjectSpace(p27.human.MoveDirection);
    p27:senduse({ "skill2", math.round(v28.X) == -1 and "left" or (math.round(v28.X) == 1 and "right" or (math.round(v28.Z) == 1 and "back" or "front")) });
end;

local function tryAutoBind(p29: userdata?) -- Line: 173
    -- upvalues: LocalPlayer (copy), u2 (copy), bindRinBar (copy)
    if not (p29 and p29.Parent) then
        return;
    end;

    if LocalPlayer:GetAttribute("style") ~= "rin2" then
        return;
    end;

    if u2[p29] then
        return;
    end;

    bindRinBar(p29);
end;

task.defer(function() -- Line: 186
    -- upvalues: LocalPlayer (copy), u2 (copy), bindRinBar (copy), u3 (copy)
    if LocalPlayer.Character then
        local Character = LocalPlayer.Character;

        if Character and (Character.Parent and (LocalPlayer:GetAttribute("style") == "rin2" and not u2[Character])) then
            bindRinBar(Character);
        end;
    end;

    LocalPlayer.CharacterAdded:Connect(function(p30) -- Line: 191
        -- upvalues: LocalPlayer (ref), u2 (ref), bindRinBar (ref)
        p30:WaitForChild("HumanoidRootPart", 10);

        if p30 then
            if not p30.Parent then
                return;
            end;

            if LocalPlayer:GetAttribute("style") ~= "rin2" then
                return;
            end;

            if u2[p30] then
                return;
            end;

            bindRinBar(p30);
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("style"):Connect(function() -- Line: 196
        -- upvalues: LocalPlayer (ref), u2 (ref), bindRinBar (ref), u3 (ref)
        if LocalPlayer:GetAttribute("style") == "rin2" then
            local Character = LocalPlayer.Character;

            if Character then
                if not Character.Parent then
                    return;
                end;

                if LocalPlayer:GetAttribute("style") ~= "rin2" then
                    return;
                end;

                if u2[Character] then
                    return;
                end;

                bindRinBar(Character);
            end;
        elseif LocalPlayer.Character then
            local Character = LocalPlayer.Character;
            local v31 = u3[Character];

            if v31 then
                v31:Destroy();
                u3[Character] = nil;
            end;

            local v32 = u2[Character];

            if v32 then
                v32:Destroy();
                u2[Character] = nil;
            end;
        end;
    end);
end);

return v1;