 
 

local Warn = require(script.Parent.Parent.Shared.Warn);
local Events = require(script.Parent.Parent.Shared.Events);
local Entity = require(script.Parent.Parent.Shared.Entity);
local Holder = require(script.Parent.Parent.Shared.Holder);
require(script.Parent.Parent.Shared.Types);
local Config = require(script.Parent.Parent.Shared.Config);
local Bin = require(script.Parent.Parent.Shared.Bin);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Death = script.Parent.Parent.Shared.Remotes.Death;
local u1 = {};

local function IsAutomatic() -- Line: 14
    -- upvalues: Config (copy)
    return Config._GetConfig("PLAYER_REPLICATION") == "AUTOMATIC";
end;

local function SetLocalCharacter(p2: userdata?) -- Line: 18
    -- upvalues: Warn (copy), LocalPlayer (copy)
    if not p2 then
        return;
    end;

    if not p2:IsA("Model") then
        Warn.high((`Model for {LocalPlayer} is not a Model instance.`));

        return;
    end;

    LocalPlayer.Character = p2;
    local CFrame = workspace.CurrentCamera.CFrame;
    workspace.CurrentCamera.CameraSubject = p2:FindFirstChildWhichIsA("Humanoid") or p2.PrimaryPart;
    workspace.CurrentCamera.CFrame = CFrame;

    for _, v in p2:QueryDescendants("LocalScript") do
        if v:IsA("LocalScript") and v.Disabled == false then
            v.Disabled = true;
            v.Disabled = false;
        end;
    end;
end;

local function StopWatch(p3) -- Line: 59
    -- upvalues: u1 (copy)
    local v4 = u1[p3];

    if v4 then
        u1[p3] = nil;
        v4();
    end;
end;

local function WatchDeath(p5: userdata, u6: any) -- Line: 67
    -- upvalues: LocalPlayer (copy), u1 (copy), Bin (copy), Death (copy), Entity (copy)
    if p5 ~= LocalPlayer or u1[u6] then
        return;
    end;

    local v7, v8 = Bin();
    local u9, u10 = Bin();

    local function CheckHumanoid(p11: any, p12: userdata?) -- Line: 74
        -- upvalues: u10 (copy), u6 (copy), u9 (copy), Death (ref)
        u10();

        if not (p12 and (u6.isContextOwner and p12:IsA("Model"))) then
            return;
        end;

        local v13 = p12:FindFirstChildWhichIsA("Humanoid");

        if v13 then
            u9(v13.Died:Connect(function() -- Line: 81
                -- upvalues: u6 (ref), Death (ref)
                if u6.isContextOwner then
                    Death:FireServer(u6.id);
                end;
            end));
        end;
    end;

    v7(Entity.GetEvent(u6, "ModelChanged"):Connect(CheckHumanoid));
    v7(Entity.GetEvent(u6, "Destroying"):Connect(function() -- Line: 90
        -- upvalues: u6 (copy), u1 (ref)
        local v14 = u6;
        local v15 = u1[v14];

        if v15 then
            u1[v14] = nil;
            v15();
        end;
    end));
    v7(u10);
    u1[u6] = v8;
    CheckHumanoid(u6, u6.model);
end;

Events.PlayerCharacterRegistered:Connect(function(p16: userdata, p17: any) -- Line: 38, Name: OnCharacterRegistered
    -- upvalues: Config (copy), Entity (copy), Warn (copy), LocalPlayer (copy), SetLocalCharacter (copy)
    if Config._GetConfig("PLAYER_REPLICATION") ~= "AUTOMATIC" or Entity.GetModelReplicationType(p17) ~= "CUSTOM" then
        return;
    end;

    local model = p17.model;

    if not model then
        return Warn.high((`No model found for {p16}`));
    end;

    if not model:IsA("Model") then
        return Warn.high((`Model for {p16} is not a Model instance.`));
    end;

    p16.Character = model;

    if p16 == LocalPlayer then
        Entity.GetEvent(p17, "ModelChanged"):Connect(function(p18, p19) -- Line: 52
            -- upvalues: SetLocalCharacter (ref)
            SetLocalCharacter(p19);
        end);
        SetLocalCharacter(model);
    end;
end);
Config._WaitForLock(function() -- Line: 118
    -- upvalues: Config (copy), Events (copy), WatchDeath (copy), u1 (copy)
    if Config._GetConfig("PLAYER_REPLICATION") ~= "AUTOMATIC" then
        return;
    end;

    Events.PlayerOwnedAdded:Connect(WatchDeath);
    Events.PlayerOwnedRemoved:Connect(function(p20, p21) -- Line: 123
        -- upvalues: u1 (ref)
        local v22 = u1[p21];

        if v22 then
            u1[p21] = nil;
            v22();
        end;
    end);
end);
Death.OnClientEvent:Connect(function(p23: number) -- Line: 98, Name: Die
    -- upvalues: Holder (copy)
    local EntityFromId = Holder.GetEntityFromId(p23);

    if not EntityFromId or EntityFromId.isContextOwner then
        return;
    end;

    local model = EntityFromId.model;

    if not model then
        return;
    end;

    task.wait();
    local v24 = model:FindFirstChildWhichIsA("Humanoid");

    if v24 and v24:GetState() ~= Enum.HumanoidStateType.Dead then
        v24.Health = 0;
        v24.Health = 10;
        v24.Health = 0;
    end;
end);

return nil;