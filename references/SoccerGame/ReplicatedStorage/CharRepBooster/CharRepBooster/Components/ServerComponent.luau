  

game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local Parent = script.Parent.Parent;
local UtilityModules = Parent.UtilityModules;
local CoreRemotes = Parent.CoreRemotes;
local FastSignal = require(Parent.UtilityModules.FastSignal);
require(UtilityModules.t);
require(UtilityModules.Trove);
local script_ServerCharacterClass = require(script.ServerCharacterClass);
local GlobalConfig = require(Parent.Components.GlobalConfig);
local SharedComponent = require(Parent.Components.SharedComponent);
local u1 = {
    CharacterObjects = {},
    CharacterObjectAdded = FastSignal.new(),
    CharacterObjectRemoving = FastSignal.new(),
    AttachedFlags = {}
};

function u1.AttachFlag(u2: userdata, u3: userdata, u4: table) -- Line: 47
    -- upvalues: GlobalConfig (copy), CoreRemotes (copy), u1 (copy)
    local function OnChange() -- Line: 48
        -- upvalues: u2 (copy), u3 (copy), GlobalConfig (ref), u4 (copy)
        local Attribute = u2:GetAttribute(u3);
        local v5 = GlobalConfig;

        for i = 1, #u4 - 1 do
            v5 = v5[u4[i]];
            local _ = i;
        end;

        v5[u4[#u4]] = Attribute;
    end;

    CoreRemotes.ServerToClient.BindFlag:FireAllClients(u2, u3, u4);
    table.insert(u1.AttachedFlags, {
        FlagInstance = u2,
        FlagAttribute = u3,
        ValuePath = u4
    });
    local Attribute = u2:GetAttribute(u3);
    local v6 = GlobalConfig;

    for i = 1, #u4 - 1 do
        v6 = v6[u4[i]];
        local _ = i;
    end;

    v6[u4[#u4]] = Attribute;
    u2:GetAttributeChangedSignal(u3):Connect(OnChange);
end;

function u1.GetCharacterObject(p7) -- Line: 71
    -- upvalues: u1 (copy)
    return u1.CharacterObjects[p7];
end;

function u1.GetVelocityForPlayer(p8: userdata, p9: any) -- Line: 75
    -- upvalues: u1 (copy)
    if p8:IsA("Player") then
        p8 = p8.Character or p8;
    end;

    if p8 == nil then
        return p9 and Vector3.new(0, 0, 0) or nil;
    end;

    local CharacterObject = u1.GetCharacterObject(p8);

    if CharacterObject == nil then
        return p9 and Vector3.new(0, 0, 0) or nil;
    end;

    local Velocity = CharacterObject:GetVelocity();

    if not Velocity then
        if p9 then
            return Vector3.new(0, 0, 0);
        end;

        Velocity = nil;
    end;

    return Velocity;
end;

function u1.Initiate() -- Line: 85
    -- upvalues: u1 (copy), CoreRemotes (copy), script_ServerCharacterClass (copy), GlobalConfig (copy), SharedComponent (copy), Players (copy)
    local function OnPlayerAdded(u10: userdata) -- Line: 86
        -- upvalues: u1 (ref), CoreRemotes (ref), script_ServerCharacterClass (ref), GlobalConfig (ref), SharedComponent (ref)
        for _, v in u1.AttachedFlags do
            CoreRemotes.ServerToClient.BindFlag:FireClient(u10, v.FlagInstance, v.FlagAttribute, v.ValuePath);
        end;

        local function OnCharacterAdded(p11) -- Line: 91
            -- upvalues: script_ServerCharacterClass (ref), GlobalConfig (ref), u10 (copy), SharedComponent (ref), u1 (ref)
            local v12 = script_ServerCharacterClass.new(p11);

            if GlobalConfig.Visualization.VisualizeNativeCharacter then
                local Part = Instance.new("Part");
                Part.Size = Vector3.new(1, 1, 1);
                Part.Transparency = 1;
                Part.Anchored = false;
                Part.CanCollide = false;
                Part.CanQuery = false;
                Part.CanTouch = false;
                Part.Massless = true;
                Part.Color = Color3.new(1, 1, 1);
                Part.CFrame = v12.HumanoidRootPart.CFrame;
                Part.Name = "PlayerOwnedPart";
                Part.Parent = p11;
                Part:SetNetworkOwner(u10);

                if GlobalConfig.PlayerOwnedNetworkPartConstraints == "Server" then
                    SharedComponent.AddPlayerOwnedNetworkPartConstraints(Part, v12.HumanoidRootPart);
                end;
            end;

            u1.CharacterObjects[p11] = v12;
            u1.CharacterObjectAdded:Fire(v12);
        end;

        local function OnCharacterRemoving(p13) -- Line: 119
            -- upvalues: u1 (ref)
            local CharacterObject = u1.GetCharacterObject(p13);
            u1.CharacterObjectRemoving:Fire(CharacterObject);
            u1.CharacterObjects[p13] = nil;
            CharacterObject:Destroy();
        end;

        if u10.Character then
            task.spawn(OnCharacterAdded, u10.Character);
        end;

        u10.CharacterAdded:Connect(OnCharacterAdded);
        u10.CharacterRemoving:Connect(OnCharacterRemoving);
    end;

    local function OnPlayerRemoving(p14: userdata) -- Line: 133
    end;

    for _, v in Players:GetPlayers() do
        task.spawn(OnPlayerAdded, v);
    end;

    Players.PlayerAdded:Connect(OnPlayerAdded);
    Players.PlayerRemoving:Connect(OnPlayerRemoving);
end;

return u1;