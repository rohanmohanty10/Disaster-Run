  

game:GetService("UserInputService");
game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Players = game:GetService("Players");
local Parent = script.Parent.Parent;
local UtilityModules = Parent.UtilityModules;
local CoreRemotes = Parent.CoreRemotes;
local FastSignal = require(Parent.UtilityModules.FastSignal);
require(UtilityModules.Trove);
require(UtilityModules.t);
local script_ClientCharacterClass = require(script.ClientCharacterClass);
local GlobalConfig = require(Parent.Components.GlobalConfig);
local SharedComponent = require(Parent.Components.SharedComponent);
local u1 = {
    CharacterObjects = {},
    CharacterObjectAdded = FastSignal.new(),
    CharacterObjectRemoving = FastSignal.new()
};

function u1.GetCharacterObject(p2) -- Line: 35
    -- upvalues: u1 (copy)
    local v3;

    if p2 == nil then
        v3 = false;
    else
        v3 = u1.CharacterObjects[p2];
    end;

    return v3;
end;

function u1.GetVelocityForPlayer(p4: userdata, p5: any) -- Line: 39
    -- upvalues: u1 (copy)
    if p4:IsA("Player") then
        p4 = p4.Character or p4;
    end;

    if p4 == nil then
        return p5 and Vector3.new(0, 0, 0) or nil;
    end;

    local CharacterObject = u1.GetCharacterObject(p4);

    if CharacterObject == nil then
        return p5 and Vector3.new(0, 0, 0) or nil;
    end;

    local Velocity = CharacterObject:GetVelocity();

    if not Velocity then
        if p5 then
            return Vector3.new(0, 0, 0);
        end;

        Velocity = nil;
    end;

    return Velocity;
end;

function u1.AttachFlag(u6: userdata, u7: userdata, u8: table) -- Line: 49
    -- upvalues: GlobalConfig (copy)
    local function OnChange() -- Line: 50
        -- upvalues: u6 (copy), u7 (copy), GlobalConfig (ref), u8 (copy)
        local Attribute = u6:GetAttribute(u7);
        local v9 = GlobalConfig;

        for i = 1, #u8 - 1 do
            v9 = v9[u8[i]];
            local _ = i;
        end;

        v9[u8[#u8]] = Attribute;
    end;

    local Attribute = u6:GetAttribute(u7);
    local v10 = GlobalConfig;

    for i = 1, #u8 - 1 do
        v10 = v10[u8[i]];
        local _ = i;
    end;

    v10[u8[#u8]] = Attribute;
    u6:GetAttributeChangedSignal(u7):Connect(OnChange);
end;

function u1.Initiate() -- Line: 65
    -- upvalues: Players (copy), script_ClientCharacterClass (copy), u1 (copy), GlobalConfig (copy), SharedComponent (copy), CoreRemotes (copy)
    local function OnPlayerAdded(p11: userdata) -- Line: 66
        -- upvalues: Players (ref), script_ClientCharacterClass (ref), u1 (ref), GlobalConfig (ref), SharedComponent (ref)
        local _ = p11 == Players.LocalPlayer;

        local function OnCharacterAdded(p12) -- Line: 69
            -- upvalues: script_ClientCharacterClass (ref), u1 (ref), GlobalConfig (ref), SharedComponent (ref)
            local v13 = script_ClientCharacterClass.new(p12);
            u1.CharacterObjects[p12] = v13;
            u1.CharacterObjectAdded:Fire(v13);

            if GlobalConfig.PlayerOwnedNetworkPartConstraints == "Client" and p12:FindFirstChild("PlayerOwnedPart") then
                SharedComponent.AddPlayerOwnedNetworkPartConstraints(p12.PlayerOwnedPart, v13.HumanoidRootPart);
            end;
        end;

        local function OnCharacterRemoving(p14) -- Line: 80
            -- upvalues: u1 (ref)
            local CharacterObject = u1.GetCharacterObject(p14);
            u1.CharacterObjectRemoving:Fire(CharacterObject);
            u1.CharacterObjects[p14] = nil;
            CharacterObject:Destroy();
        end;

        if p11.Character then
            task.spawn(OnCharacterAdded, p11.Character);
        end;

        p11.CharacterAdded:Connect(OnCharacterAdded);
        p11.CharacterRemoving:Connect(OnCharacterRemoving);
    end;

    local function OnPlayerRemoving(p15: userdata) -- Line: 94
    end;

    for _, v in Players:GetPlayers() do
        task.spawn(OnPlayerAdded, v);
    end;

    Players.PlayerAdded:Connect(OnPlayerAdded);
    Players.PlayerRemoving:Connect(OnPlayerRemoving);
    CoreRemotes.ServerToClient.BindFlag.OnClientEvent:Connect(function(...) -- Line: 101
        -- upvalues: u1 (ref)
        u1.AttachFlag(...);
    end);
end;

return u1;